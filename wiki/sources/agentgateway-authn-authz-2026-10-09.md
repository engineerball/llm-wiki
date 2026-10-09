---
title: "Agentgateway Authentication, Authorization, and User-to-MCP Delegation"
tags: [source, agent-gateway, agentgateway, authentication, authorization, mcp, oauth, jwt, rbac, security]
sources: ["raw/articles/agentgateway-authn-authz-2026-10-09.md"]
date: 2026-10-09
---

# Agentgateway Authentication, Authorization, and User-to-MCP Delegation

**Research date**: 2026-10-09 (Asia/Bangkok).

**Version context**: agentgateway GitHub release `v1.6.0` was the latest release observed, and the Kubernetes documentation was on the `1.6.x` track.

## Main finding

`agentgateway` can authenticate an incoming client or user, authorize routes and individual MCP tools, and authenticate to an upstream MCP server.
These are separate decisions.

The gateway does not by itself prove that an arbitrary agent runtime has authenticated its human user, nor does gateway authentication automatically establish authorization inside the agent.
The agent runtime and MCP server still need explicit identity, consent, scope, and authorization behavior.

## User-to-MCP model

The MCP authorization specification defines the HTTP MCP client as an OAuth client acting on behalf of a resource owner, the MCP server as an OAuth resource server, and the authorization server as the component that interacts with the user and issues access tokens.

A secure chain is therefore:

```text
User authenticates and consents at Authorization Server
        |
        v
Agent runtime / MCP client holds an access token for a specific MCP resource
        |
        v
agentgateway validates issuer, audience, signature, expiry, and policy claims
        |
        v
MCP server validates that the token was issued for that MCP server
        |
        v
Gateway and/or MCP server authorizes the specific tool, resource, method, tenant, and operation
```

The MCP specification makes authorization optional for implementations.
For HTTP transports, an implementation that supports authorization should follow the MCP authorization flow.
For stdio transports, the specification says to use environment credentials instead of the HTTP OAuth flow.

## How the user is authenticated

The user is normally authenticated by an external Identity Provider or OAuth Authorization Server.
The agent runtime is an OAuth client or application component, not automatically an identity provider.
The authorization server issues the access token after the user authentication and consent flow.

For MCP HTTP transport, the MCP specification requires resource metadata and authorization-server discovery, PKCE-oriented authorization flow behavior, resource indicators, and bearer-token use in the `Authorization` header.
The MCP server must validate that the access token is intended for that MCP server and must reject tokens issued for another resource.

This means the following is not sufficient by itself:

```text
User logs into the agent application
Agent uses one shared service token for every MCP call
```

That design authenticates the service, not necessarily the user, and can create a confused-deputy problem.

## Three viable identity patterns

### 1. User-delegated token

The agent runtime obtains a user-delegated access token for the target MCP resource and sends it to agentgateway.
The gateway validates the token and authorizes using verified claims and scopes.
The token may be passed to the MCP backend only when the backend trusts the same token issuer and audience.

This provides the strongest direct user attribution, but requires careful token storage, audience restriction, scope minimization, refresh-token protection, and revocation handling.

### 2. Gateway token exchange

The client sends an inbound user or agent token to agentgateway.
The gateway validates the inbound token at the edge, then performs RFC 8693 token exchange or RFC 7523 JWT bearer exchange.
The gateway sends a new backend-scoped token to the MCP server.

The official agentgateway guide specifically documents token exchange for MCP servers and states that the MCP server need not see the incoming token and the caller need not hold a credential for the MCP server.
The exchanged token can be scoped using audience, scope, and resource parameters.

Important limitation: token exchange changes the credential sent downstream; it does not itself decide whether the user may call a particular tool.
An MCP authorization policy is still required.

The official guide also warns that the exchange forwards the incoming token to the authorization server unless edge JWT or MCP authentication validates it first.
Therefore edge validation must be configured before exchange, and the validated token must be preserved for use as the subject token.

### 3. Agent/service identity with application-level user context

The agent uses its own workload identity to call the gateway or MCP server, while the user identity is carried separately as verified context.
This can be appropriate for controlled server-side workflows, but only if the downstream policy trusts the context source and prevents the agent from self-asserting arbitrary user claims.

The user context should be inserted by a trusted component, bound to a signed token or server-side authorization decision, and checked against tenant, purpose, tool, and resource constraints.
A plain user ID header supplied by the agent must not be treated as authenticated identity.

## What agentgateway enforces

### Inbound authentication

Documented options include JWT, API key, MCP OAuth, basic authentication, and external authorization.
JWT validation can check issuer, audience, JWKS signature, key ID, expiry, and other claims.
Strict mode requires a valid token.
Optional and permissive modes allow unauthenticated requests and must not be used as protected defaults.

### Route and backend authorization

CEL policies can authorize based on request attributes and verified JWT claims.
The documented actions are Allow, Require, and Deny.
Authentication happens before authorization, with the normal distinction of `401` for authentication failure and `403` for authorization failure.

### MCP tool authorization

MCP authorization can inspect verified JWT claims together with MCP context such as tool name, target, prompt name, resource name, and method name.
Unauthorized tools can be filtered from `tools/list` responses.
Tool arguments are not available to the standalone `mcpAuthorization` decision, so argument-sensitive rules require route-level authorization or an external MCP policy service.

### Downstream authentication

Backend authentication can use a static Secret, passthrough of a validated JWT, provider-specific credentials, or token exchange.
By default, validated inbound credentials are removed before forwarding.
The gateway therefore does not accidentally forward a user's token unless passthrough or an explicit exchange/backend policy is configured.

## What agentgateway does not automatically enforce

The official material does not establish that agentgateway automatically:

- authenticates the human user inside every agent runtime;
- verifies that an agent's own claimed user identity is genuine;
- makes an LLM's tool-selection decision safe;
- applies the user's business authorization model inside the agent's planning loop;
- authorizes individual MCP data rows, records, or clinical resources inside the MCP server;
- propagates a user identity through every transport and backend automatically;
- prevents a compromised agent from replaying a valid token within its lifetime;
- creates a complete audit record linking user intent, agent reasoning, tool arguments, and downstream effects.

These controls must be implemented and verified in the agent runtime, identity provider, gateway policy, MCP server, and application domain layer as appropriate.

## Recommended authorization decision inputs

For a sensitive MCP function, authorization should be bound to at least:

- authenticated user subject;
- tenant or organization;
- agent/workload identity;
- MCP server and resource audience;
- tool name and MCP target;
- required scope or role;
- resource-level authorization;
- tool arguments where policy permits inspection;
- purpose of use;
- consent or approval state;
- time, session, and token validity;
- audit correlation ID.

## Minimum secure flow

```text
1. User authenticates with the organization IdP.
2. Agent runtime creates an authenticated session bound to the user and tenant.
3. Agent runtime obtains a resource-specific token or calls a trusted token broker.
4. Gateway validates issuer, audience, signature, expiry, and required claims.
5. Gateway applies route and MCP tool authorization.
6. Gateway optionally exchanges the token for an MCP-server-specific token.
7. MCP server validates its own audience, issuer, scope, and expiry.
8. MCP server applies domain and resource-level authorization.
9. The tool call and result are audited without logging raw tokens or sensitive payloads.
```

## Anti-patterns

- Shared long-lived service token used for all users and tenants.
- Accepting `X-User-Id` or similar headers directly from an untrusted agent.
- Passing a valid user token to every MCP server without audience restriction.
- Using gateway authentication as proof that the MCP server enforces row-level or clinical authorization.
- Allowing tools based only on the fact that they were advertised in `tools/list`.
- Using optional/permissive authentication on a route that handles sensitive data.
- Caching authorization decisions without including every decision input in the cache key.
- Logging Authorization headers, refresh tokens, PHI, or unrestricted tool arguments.

## Evidence boundary

The MCP specification defines the OAuth roles and transport-level authorization flow.
agentgateway documentation defines gateway-side JWT/OAuth validation, CEL policy enforcement, MCP tool authorization, external policy callouts, and backend token exchange.
Neither source alone proves that a particular agent framework implements end-user authentication or that a deployed MCP server enforces domain-level authorization.
Those behaviors require inspection and testing of the specific agent runtime, identity provider, MCP server, and application policy.

## Primary sources

- https://modelcontextprotocol.io/specification/2025-11-25/basic/authorization.md
- https://modelcontextprotocol.io/specification/2026-07-28/basic/authorization.md
- https://agentgateway.dev/docs/standalone/latest/documentation/configuration/security/mcp-authn.md
- https://agentgateway.dev/docs/standalone/latest/documentation/configuration/security/mcp-authz.md
- https://agentgateway.dev/docs/kubernetes/latest/documentation/mcp/tool-access.md
- https://agentgateway.dev/docs/kubernetes/latest/documentation/security/authorization.md
- https://agentgateway.dev/docs/kubernetes/latest/documentation/security/backend-authn/token-exchange/mcp.md
- https://agentgateway.dev/docs/kubernetes/latest/documentation/security/backend-authn/token-exchange/standard.md
- https://agentgateway.dev/docs/kubernetes/latest/documentation/security/backend-authn/key.md
- https://agentgateway.dev/docs/kubernetes/latest/documentation/about/policies/filter-order.md
