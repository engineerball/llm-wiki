# agentgateway authentication and authorization research

- Retrieved: 2026-10-09 (Asia/Bangkok)
- Project: https://github.com/agentgateway/agentgateway
- Kubernetes docs track observed: `1.6.x`
- Documentation index: https://agentgateway.dev/docs/llms.txt

## Terminology

- Authentication answers: who is the caller?
- Authorization answers: what may the caller do?
- Backend authentication answers: what credential should agentgateway present to the upstream provider, MCP server, agent, or HTTP service?

These are separate controls and should not be collapsed into one policy.

## Authentication methods

### JWT authentication

The Kubernetes documentation describes JWT validation through `AgentgatewayPolicy.spec.traffic.jwtAuthentication`.
The standalone configuration uses `jwtAuth`.
Validation can use a local or remote JWKS and can check the issuer, audiences, key ID, and token time claims.

The standalone documentation lists three modes:

- `Strict`: a valid token from a configured issuer must be present.
- `Optional`: validate a token when present, but allow requests without a token.
- `Permissive`: never reject a request for JWT failure; useful only when later policies or logs consume claims.

`Optional` and `Permissive` must not be mistaken for protected authentication because they allow unauthenticated requests.

The current standalone documentation states that from version 1.5, configured `issuer` and non-empty `audiences` imply required claims.
A token missing those claims is rejected.

After JWT validation, agentgateway removes the credential from its original location by default so the backend does not receive the client credential.
`preserveToken` can retain it for later policy processing, while backend `passthrough` can forward the validated JWT to a specific backend.

### API key authentication

The Kubernetes API-key guide supports strict and optional validation.
Clients send the key in the `Authorization` header by default, and invalid or missing keys return `401` in strict mode.

The documented storage options are:

- ConfigMap containing SHA-256 hashes of keys, selected by labels. This is the recommended documented approach because plaintext keys do not need to be stored in the cluster.
- Kubernetes Secret, referenced by name or label selector. A Secret can contain a raw key or a hash.
- Inline key in policy. The documentation marks this as least secure because the value is plaintext in the cluster and any Git repository that tracks the policy.

API keys are long-lived credentials, so rotation, issuance, revocation, ownership, and leakage response remain operator responsibilities.

### MCP OAuth authentication

MCP authentication protects MCP servers through OAuth 2.0 and the MCP Authorization specification.
In standalone mode it is configured as `policies.mcpAuthentication` at route level.

The documented behavior is connect-time or eager authentication:

1. The MCP client discovers protected resource and authorization-server metadata.
2. The client obtains an access token from the identity provider.
3. agentgateway validates the token as a resource server.
4. The token is reused for subsequent requests in the MCP session.

agentgateway can proxy metadata, authorization-server metadata, client registration, and JWKS behavior for selected providers.
The official documentation lists tested provider adaptations for Auth0, authentik, Descope, Microsoft Entra ID, Keycloak, and Okta.
A pre-registered `clientId` can bypass dynamic client registration, and `clientSecret` is injected server-side for confidential clients.

### Basic and external authentication

The documentation index also lists basic authentication, OIDC browser authentication, Tailscale identity integration, and external authorization services.
These should be selected based on client type and trust boundary rather than treated as interchangeable mechanisms.

## Authorization methods

### CEL authorization for general traffic

Kubernetes authorization uses `spec.traffic.authorization`, `spec.backend.authorization`, or `spec.backend.mcp.authorization` depending on scope.
Standalone mode uses route or backend authorization policies.

The documented actions are:

- `Allow`: allow when at least one expression matches. If any Allow rule exists, unmatched requests are denied.
- `Require`: every expression must evaluate to true. This is appropriate for mandatory conditions and is fail-closed when an expression is false or cannot be evaluated.
- `Deny`: deny when an expression matches. A matching Deny overrides Allow.

Kubernetes evaluation order is Deny first, Require second, and Allow last.
Authentication runs before authorization.
The documented distinction is normally `401` for missing, malformed, or unverifiable credentials and `403` for a valid identity that fails authorization.

CEL expressions can inspect request headers, source address, JWT claims, path, MCP tool names, MCP targets, and other documented variables.

### MCP tool-level authorization

MCP authorization operates on MCP methods and tool context rather than only on an HTTP path.
The documented variables include:

- `mcp.tool.name`
- `mcp.tool.target`
- `mcp.prompt.name`
- `mcp.resource.name`
- `mcp.methodName`
- `jwt.sub` and other verified JWT claims
- `has(jwt.<claim>)`

When a tool or resource is not authorized, the gateway can filter it from list responses so unauthorized clients do not see it.
A typical policy can allow one tool only to a particular subject, for example a rule equivalent to `jwt.sub == "alice" && mcp.tool.name == "get_me"`.

The standalone documentation states that `mcp.tool.arguments` is not available when `mcpAuthorization` evaluates, so authorization should normally be based on tool name, target, method, and verified identity claims.
For argument-sensitive decisions, use route-level authorization or an external MCP policy service instead.

### External authorization

agentgateway supports an external authorization service through an Envoy-compatible external authorization API.
The service can make decisions using headers, path, method, tokens, database lookups, or other organization-specific logic.
It can also return headers for the gateway to add or use.

External authorization can be attached at Gateway, HTTPRoute, or backend scope.
Gateway and route policies run before backend selection.
Backend policies run after backend selection and are useful when the decision or response must be specific to the selected backend.

The standalone documentation states that external authorization calls default to a two-second timeout.
For gRPC external authorization, decisions can be cached.
The cache key must include every request property used by the authorization service, otherwise one decision can be incorrectly reused for another request.

### MCP guardrails / ExtMCP

MCP guardrails use an external ExtMCP policy service to inspect or mutate MCP requests and responses.
The documented interface includes request and response checks.
A policy server can deny a tool call, mutate parameters, filter tool listings, or annotate descriptions.
`FailClosed` denies traffic when the policy service fails, while `FailOpen` allows traffic to continue.
For sensitive tools, FailClosed is the safer default, but the policy service needs a timeout and availability design to avoid hanging requests.

## Backend authentication and token exchange

Inbound authentication and outbound backend authentication are separate.
The backend policy can:

- Read a static credential from a Kubernetes Secret.
- Use an inline credential, which the documentation warns is plaintext and should be avoided where possible.
- Pass through the already validated client JWT to a selected backend.
- Use provider-specific backend authentication for AWS, GCP, Azure, and other integrations.
- Exchange the incoming credential for a backend-scoped token.

The documentation includes RFC 8693 token exchange and RFC 7523 JWT bearer grant patterns.
Token exchange is useful when the upstream should not receive the original user token or when a separate trust boundary requires a scoped token.

## Policy processing and precedence

Kubernetes policies run through fixed phases:

1. Frontend
2. PreRouting traffic
3. PostRouting traffic
4. Backend

PreRouting can run authentication and external authorization before route selection.
PostRouting is the default traffic phase and runs after route selection.
Backend authentication and authorization run when connecting to the selected upstream.

Policies merge at field level rather than recursively combining every nested list.
More specific targets generally take precedence over less specific targets.
For equal specificity and conflicting fields, the documentation states that the older policy wins based on creation timestamp, with a stable lexical tie-breaker.
This creates an operational risk if multiple teams attach overlapping policies without ownership and review.

## Security recommendations derived from the documentation

1. Use `Strict` authentication for protected LLM, MCP, and A2A routes.
2. Do not use `Optional` or `Permissive` as a substitute for authentication.
3. Prefer remote JWKS with key rotation for production JWT validation.
4. Use explicit issuer and audience validation where the identity provider supplies stable claims.
5. Store provider credentials in Secrets or an external secret manager, not inline policy values.
6. Hash API keys in ConfigMaps when the documented pattern fits the threat model, or use tightly controlled Secrets.
7. Apply separate authorization rules to the gateway, route, backend, MCP server, and individual tools as required.
8. Use `Require` for mandatory claims because it fails closed when a claim is missing or an expression errors.
9. Treat tool listing as an authorization surface because it can reveal capabilities even before a tool is called.
10. Use FailClosed ExtMCP guardrails for high-risk tools and configure explicit timeouts.
11. Include all authorization inputs in external-auth cache keys.
12. Use token exchange when the upstream must receive a scoped credential instead of the original user identity token.
13. Avoid logging raw Authorization headers, JWTs, API keys, prompts, tool arguments, or PHI.
14. Test the expected `401`, `403`, allow, deny, timeout, key rotation, and policy conflict behavior before production.

## Limitations and open questions

The documentation establishes configuration behavior and examples, but it does not by itself prove a deployment's security posture, availability, compliance, or resistance to all agent-specific attacks.
A production design still needs an identity threat model, authorization test matrix, secret rotation procedure, audit-log policy, break-glass process, and human review for high-impact tools.

## Primary sources

- https://agentgateway.dev/docs/kubernetes/latest/documentation/security/authorization.md
- https://agentgateway.dev/docs/kubernetes/latest/documentation/security/jwt/setup.md
- https://agentgateway.dev/docs/kubernetes/latest/documentation/security/apikey.md
- https://agentgateway.dev/docs/kubernetes/latest/documentation/mcp/mcp-access.md
- https://agentgateway.dev/docs/kubernetes/latest/documentation/mcp/tool-access.md
- https://agentgateway.dev/docs/kubernetes/latest/documentation/mcp/auth/setup.md
- https://agentgateway.dev/docs/kubernetes/latest/documentation/mcp/guardrails/setup.md
- https://agentgateway.dev/docs/kubernetes/latest/documentation/security/extauth/byo-ext-auth-service.md
- https://agentgateway.dev/docs/kubernetes/latest/documentation/security/backend-authn/key.md
- https://agentgateway.dev/docs/kubernetes/latest/documentation/security/backend-authn/token-exchange/standard.md
- https://agentgateway.dev/docs/kubernetes/latest/documentation/about/policies/filter-order.md
- https://agentgateway.dev/docs/kubernetes/latest/documentation/about/policies/target-merge.md
- https://agentgateway.dev/docs/standalone/latest/documentation/configuration/security/jwt-authn.md
- https://agentgateway.dev/docs/standalone/latest/documentation/configuration/security/mcp-authn.md
- https://agentgateway.dev/docs/standalone/latest/documentation/configuration/security/mcp-authz.md
- https://agentgateway.dev/docs/standalone/latest/documentation/configuration/security/http-authz.md
- https://agentgateway.dev/docs/standalone/latest/documentation/configuration/security/external-authz.md
