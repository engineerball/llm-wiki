---
source_url: https://www.infoq.com/articles/nextgen-search-ai-opensearch-mcp/
ingested: 2026-08-04
sha256: 5b82f6df03633f499ca2706a588361abeaf00bd25f0fcb27669fd6ce831aaa8e
---

[BT](https://www.infoq.com/int/bt/ "bt")

## InfoQ Software Architects' Newsletter

A monthly overview of things you need to know as an architect or aspiring architect.

[View an example](https://www.infoq.com/software-architects-newsletter#placeholderPastIssues)

Enter your e-mail address

Select your countrySelect a countryAfghanistanÅlandAlbaniaAlgeriaAmerican SamoaAndorraAngolaAnguillaAntarcticaAntigua and BarbudaArgentinaArmeniaArubaAustraliaAustriaAzerbaijanBahamasBahrainBangladeshBarbadosBelarusBelgiumBelizeBeninBermudaBhutanBoliviaBonaire, Sint Eustatius, and SabaBosnia and HerzegovinaBotswanaBouvet IslandBrazilBritish Indian Ocean TerritoryBrunei DarussalamBulgariaBurkina FasoBurundiCambodiaCameroonCanadaCape VerdeCayman IslandsCentral African RepublicChadChileChinaChristmas IslandCocos (Keeling) IslandsColombiaComorosCongo (Democratic Republic)Congo (People's Republic)Cook IslandsCosta RicaCote D'IvoireCroatiaCubaCuraçaoCyprusCzech RepublicDenmarkDjiboutiDominicaDominican RepublicEast TimorEcuadorEgyptEl SalvadorEquatorial GuineaEritreaEstoniaEthiopiaFalkland Islands (Malvinas)Faroe IslandsFijiFinlandFranceFrench GuianaFrench PolynesiaFrench Southern TerritoriesGabonGambiaGeorgiaGermanyGhanaGibraltarGreeceGreenlandGrenadaGuadeloupeGuamGuatemalaGuernseyGuineaGuinea-BissauGuyanaHaitiHeard Island and McDonald IslandsHondurasHong KongHungaryIcelandIndiaIndonesiaIranIraqIrelandIsle of ManIsraelItalyJamaicaJapanJerseyJordanKazakhstanKenyaKiribatiKosovoKuwaitKyrgyzstanLaosLatviaLebanonLesothoLiberiaLibyaLiechtensteinLithuaniaLuxembourgMacauMacedoniaMadagascarMalawiMalaysiaMaldivesMaliMaltaMarshall IslandsMartiniqueMauritaniaMauritiusMayotteMexicoMicronesiaMoldovaMonacoMongoliaMontenegroMontserratMoroccoMozambiqueMyanmarNamibiaNauruNepalNetherlandsNetherlands AntillesNew CaledoniaNew ZealandNicaraguaNigerNigeriaNiueNorfolk IslandNorth KoreaNorthern Mariana IslandsNorwayOmanPakistanPalauPalestinian TerritoryPanamaPapua New GuineaParaguayPeruPhilippinesPitcairnPolandPortugalPuerto RicoQatarReunionRomaniaRussian FederationRwandaSaint HelenaSaint Kitts and NevisSaint LuciaSaint MartinSaint Pierre and MiquelonSaint Vincent and the GrenadinesSaint-BarthélemySamoaSan MarinoSao Tome and PrincipeSaudi ArabiaSenegalSerbiaSeychellesSierra LeoneSingaporeSint MaartenSlovakiaSloveniaSolomon IslandsSomaliaSouth AfricaSouth Georgia and the South Sandwich IslandsSouth KoreaSouth SudanSpainSri LankaSudanSurinameSvalbard and Jan MayenSwazilandSwedenSwitzerlandSyriaTaiwanTajikistanTanzaniaThailandTogoTokelauTongaTrinidad and TobagoTunisiaTurkeyTurkmenistanTurks and Caicos IslandsTuvaluUgandaUkraineUnited Arab EmiratesUnited KingdomUnited States Minor Outlying IslandsUruguayUSAUzbekistanVanuatuVatican City (Holy See)VenezuelaVietnamVirgin Islands (British)Virgin Islands (U.S.)Wallis and FutunaWestern SaharaYemenZaireZambiaZimbabwe

I consent to InfoQ.com handling my data as explained in this [Privacy Notice](https://www.infoq.com/privacy-notice).

[We protect your privacy.](https://www.infoq.com/privacy-notice/)

Close

Online InfoQ Engineering Leadership Certification (Aug 21): Strengthen how you lead technical strategy, execution, and accountability. [Register Now](https://www.infoq.com/url/pb/55d807d0-1ac5-4dd2-9765-4c2d9bc69694/)

Close


[InfoQ Homepage](https://www.infoq.com/ "InfoQ Homepage")[Articles](https://www.infoq.com/articles "Articles")NextGen Search - Where AI Meets OpenSearch through MCP

[AI, ML & Data Engineering](https://www.infoq.com/ai-ml-data-eng/ "AI, ML & Data Engineering")

[Below the Framework: Why Agent Context Is an Infrastructure Problem (Webinar Aug 27th)](https://www.infoq.com/url/t/7dad997e-b5eb-4c47-99bd-b4fe9a9d04b0/?label=Tacnode-EventPromoBox)

# NextGen Search - Where AI Meets OpenSearch through MCP

Dec 17, 2025




17
min read



#### Follow us on

[Youtube232K Followers](https://bit.ly/4bg6QM8) [Linkedin26K Followers](https://bit.ly/44IzAtf) [InstagramNew](https://bit.ly/4eYXrtM) [RSS19K Readers](https://bit.ly/3RaJalC) [X57.1k Followers](https://bit.ly/4pfxivv) [Facebook21K Likes](https://bit.ly/3QrGMH2) [BlueskyNew](https://bit.ly/4eS8FjG)

Log in to listen to this article

Loading audio

Your browser does not support the audio element.


0:00

0:00

Normal1.25x1.5x

Like

- [Reading list](https://www.infoq.com/showbookmarks.action)

### Key Takeaways

- As keyword search reaches its limits, the industry is shifting toward semantic, multi-modal, conversational, and agentic AI search that understands user’s intent, context and empowers users to get insights through natural-language queries without needing technical skills or custom application development.
- Next-generation context-aware conversational search solutions can be built using OpenSearch and AI agents powered by Large Language Models (LLMs) and Model Context Protocol (MCP). MCP bridges AI agents and OpenSearch for creating intelligent search applications.
- AI agents (specialized AI applications) are LLMs equipped with role, task, and context management capabilities. A typical AI agent integrates an LLM for reasoning, Memory for maintaining relevant context across interactions, Tools for extended capabilities, and Retrieval Augment Generation (RAG) for selective knowledge retrieval.
- The proposed architecture brings these components together through three layers: an agentic layer for intelligence, an MCP protocol layer (MCP client & server) for communication, and a data layer for indexing, search, and analytics.
- MCP server deployment patterns include local, remote, managed hybrid (on-premises/cloud), and cloud-native deployments, with each option offering different trade-offs based on organizational needs.

## Introduction

Imagine a sales executive querying, "Show me the top ten products by revenue this quarter and predict/forecast next month's trends" in plain English, and get comprehensive insights in seconds without waiting days for a BI team report. You could also ask your system, "What's causing high latencies in my application?" and retrieve not just latency-related search results, but also a comprehensive analysis and correlation of error logs, metrics, and recent deployments.

The next-generation agentic search enables this conversational search functionality, where AI agents powered by LLMs interact with data systems through standardized protocols such as MCP to deliver conversational, context-aware search experiences.

In this article, we will explore how MCP bridges AI agents and OpenSearch to create intelligent search applications. We will also explore the evolution from keyword search to agentic search, understand the architectural components, and walk through practical implementations with live examples.

## OpenSearch & Industry Use Cases

[OpenSearch](https://opensearch.org/) is an open-source search and analytics suite used for log analytics, real-time application monitoring, and website search use cases. With nearly [nine hundred million software downloads](https://opensearch.org/announcements/opensearch-3-0-enhances-vector-database-performance/) since its inception and participation from thousands of contributors, and with [over fourteen premier members](https://opensearch.org/blog/driving-community-contributions/) like [AWS](https://aws.amazon.com/opensearch-service/), SAP, and Oracle, etc., OpenSearch is ranked in the [top five search engines](https://db-engines.com/en/ranking/search+engine) according to [DB-Engines](http://db-engines.com/).

From an e-commerce product search to an observability platform, many industry verticals use OpenSearch for lexical, semantic search, and log analytics use cases. Let's take a quick look at how search has evolved.

## Search Evolution: From Keywords to Agents

![](https://www.infoq.com/articles/nextgen-search-ai-opensearch-mcp/articles/nextgen-search-ai-opensearch-mcp/en/resources/163figure-1-1765802305311.jpg)

**Figure 1: Evolution of Search**

### Keyword Search

Also known as lexical search, which is a traditional method of search, i.e., using specific words or phrases (aka keywords). OpenSearch uses [TF-IDF or Okapi BM25F](https://kmwllc.com/index.php/2020/03/20/understanding-tf-idf-and-bm-25/) algorithms by default, also popularly known as " [Lucene](https://lucene.apache.org/)" indices. Even though it is fast, deterministic, and language-agnostic, keyword search ignores user context and intent.

For example, a query for " _Black jacket for men_" returns any document containing these words, including " _men wearing black shirts_" or " _jackets in other colors_". You can try the keyword search from the [OpenSearch AI demos](https://huggingface.co/spaces/opensearch-project/OpenSearch-AI) in [Hugging Face](https://huggingface.co/opensearch-project) by selecting the search type as "keyword search".

### Semantic Search

Semantic search is advanced compared to a keyword search; the user's context and intent are considered during the query execution. In semantic search, data is being converted into vector embeddings (i.e., text is converted into a numerical representation). These vector embeddings are also called the [vector store](https://opensearch.org/platform/vector-engine/) (aka vector database) use case. OpenSearch offers a choice of [multiple pretrained models](https://docs.opensearch.org/latest/ml-commons-plugin/pretrained-models/) to convert the data from text to vector embeddings or other embeddings like image, audio, or video, etc.

In the same example we used in keyword search (e.g., search for " _Black jacket for men_"), then you will see results only related to " _men wearing black jackets_". You can try the keyword search from the OpenSearch AI demos in Hugging Face by selecting the search type as "vector search".

### Multi-modal or Hybrid Search

This search approach is a combination of keyword and semantic search. A search can get you the keyword and semantic-based results. Moreover, with [multi-modal search](https://opensearch.org/blog/multimodal-semantic-search/), search results use [multiple models](https://docs.opensearch.org/latest/ml-commons-plugin/pretrained-models/) for different types of data like text with images, etc. For example, in the demo page, [OpenSearch AI demos](https://huggingface.co/spaces/opensearch-project/OpenSearch-AI) in [Hugging Face](https://huggingface.co/opensearch-project), you might have witnessed the results showing both keywords and images.&

### Conversational Search

[Conversational Search](https://docs.opensearch.org/latest/vector-search/ai-search/conversational-search/) uses natural language to query OpenSearch like Q&A by leveraging [LLMs](https://en.wikipedia.org/wiki/Large_language_model). These LLMs are stateless, but they maintain conversation context and history in two ways:

- Built-in memory provided by modern LLM providers like OpenAI ChatGPT, Anthropic Claude, etc., for session-based retention
- External memory storage systems for persistent enterprise-grade memory management. These storage systems include Traditional databases (e.g., PostgreSQL, Redis, Cassandra), Vector databases (e.g., OpenSearch, Pinecone), or [Agentic Frameworks](https://docs.aws.amazon.com/prescriptive-guidance/latest/agentic-ai-frameworks/frameworks.html) (e.g., LangChain, Strands, LlamaIndex)

Conversational Search with [RAG](https://opensearch.org/blog/using-opensearch-for-retrieval-augmented-generation-rag/) augments the LLM response by connecting to external data sources (typically connected to a single data source) such as OpenSearch. Typically, users tell what exactly needs to be searched and retrieve data from OpenSearch. It is best suited for simple to moderate queries and straightforward information retrieval.

The key distinction is that memory (built-in or external) maintains conversation history for continuity of context. At the same time, RAG enhances the LLM response by retrieving relevant information from external data sources to provide more accurate and up-to-date answers.

### Agentic Search (Next Generation Search)

[Agentic Search](https://docs.opensearch.org/latest/vector-search/ai-search/agentic-search/index/) in OpenSearch will help you to ask questions in natural language, like plain English.

Agentic Search is a superset of Conversational Search. Unlike conversational search, agents will have built-in memory capabilities and orchestrate a task workflow with LLM reasoning capabilities and make decisions on the query execution on OpenSearch. These tasks include Search, analyze, correlate, and execute. Agents will also iterate the workflow plan autonomously as needed.

Agentic Search can connect to multiple data sources by orchestrating multiple tools for information retrieval and augmenting responses. With Agentic Search, a user can keep the conversation intact and execute [tools](https://huggingface.co/learn/agents-course/en/unit1/tools) (aka tasks) on OpenSearch through [Model Context Protocol](https://modelcontextprotocol.io/docs/getting-started/intro), which will be discussed in later sections of this article.

Before diving deep into the next-generation agentic search architecture and implementation details, let's look at how agents play a critical role in agentic AI application architecture.

## What are AI Agents?

AI agents (specialized AI applications) are Large Language Models equipped with role, task, and context management capabilities. A typical AI agent integrates an LLM for reasoning, memory for maintaining relevant context across interactions, tools for extended capabilities, and RAG for selective knowledge retrieval, all designed to efficiently manage the LLM's limited context window by retrieving only pertinent information and preserving critical details. Given a task, agents achieve objectives through iterative reasoning with available tools while dynamically managing what information enters the context window to optimize response generation.

![](https://www.infoq.com/articles/nextgen-search-ai-opensearch-mcp/articles/nextgen-search-ai-opensearch-mcp/en/resources/126figure-2-1765802305311.jpg)

**Figure 2: Core Architecture of AI Agents**

Let's review two popular OpenSearch business use cases to understand how OpenSearch Agentic Search will help.

|     |     |
| --- | --- |
| **Search Use Case: Sales Analyst Creating an Executive Sales Report**<br>The Sales Analyst (AI Agent) is tasked with creating a weekly sales performance report for executive leadership.<br>AI Agent leverages the Analytics Manager (LLM Orchestrator), which acts as a brain and directs:<br>**What to analyze** (weekly sales by category, top products, customer trends, and marketing campaign impact),<br>**Where to look** (sales database, inventory system, marketing platform, customer analytics),<br>**How to investigate** (generate queries to aggregate sales data, correlate with campaigns, and compare trends)<br>Once the execution plan is ready, the AI Agent uses available tools through MCP:<br>- Sales Database (Salesforce) to query revenue, orders, and product performance<br>- E-commerce Platform (MySQL) API to retrieve inventory levels and customer order details<br>- Marketing Platform (SAP ERP) API to review campaign performance and correlate with sales spikes<br>- AI Agent may also use reference documentation (knowledge bases/RAG) such as:<br>Sales report templates and KPI definitions<br>- Database schema and field definitions<br>- Historical sales reports and seasonal patterns<br>- Business rules (e.g., how "active customer" is defined)<br>On Day 2, if the executive (user) needs to refer to the Day 1 sales summary by category, the AI Agent remembers (memory) the Day 1 findings and continues the context-aware conversation on Day 2. | **Observability Use Case: DevOps Engineer Investigating a Production Outage**<br>A DevOps Engineer (AI Agent) is tasked to investigate and resolve a production application performance issue.<br>AI Agent leverages the Incident Manager (LLM Orchestrator), which acts as a brain and directs,<br>**What to investigate** ( slow query logs, API latency metrics, recent deployments),<br>**Where to look** (application observability information, such as logs, metrics, traces),<br>**How to investigate** (generates a query to analyze Error logs with latency metrics & traces and correlates them with recent deployment timelines)<br>Once the execution plan is ready, the AI Agent uses available tools through MCP<br>- OpenSearch to query application logs, metrics & traces<br>- GitHub API to review recent code deployments for correlation<br>- PagerDuty API (or other) to correlate related alerts<br>AI Agent may also use reference documentation (knowledge bases/RAG) such as<br>- Troubleshooting runbooks<br>- System architecture design documents<br>- Historical incidents and resolutions<br>On Day 2, if the DevOps engineer (AI Agent) needs to refer to the patch applied for the Day 1 incident, the AI Agent remembers (Memory) the Day 1 findings and continues the context-aware conversations on Day 2. |

## Why do we need Agents?

### LLMs: Yesterday's Brain Problem

Large Language ModelsFunctional Models (FMs) were trained on a large corpus of data, but don't have information on real-time data. So, working with an LLM alone is like working with yesterday’s brain. RAG addresses this issue by connecting LLMs to external data sources like OpenSearch or RDBMS, etc.

For example, if a DevOps engineer asks for real-time application performance metrics or insights into a production application. LLM alone can’t provide the information. LLM needs to augment the response using existing data stores like OpenSearch to provide real-time insights.

Traditional RAG requires users to specify exact queries and retrieves from a single source in one step. AI Agents enhance RAG by autonomously reasoning about the problem, orchestrating multiple data sources through MCP (e.g., OpenSearch, GitHub, CloudWatch), correlating findings, and iterating until a solution is found.

### Memory of Conversation

LLMs alone don't store user conversation history. LLMs process each prompt independently without retaining previous interactions. Agents can maintain conversation history through various memory mechanisms, like [short-term and long-term memory](https://www.ibm.com/think/topics/ai-agent-memory#498277086).

So, there is a need for memory setup with an external database and to use the RAG technique to keep up with conversations. From OpenSearch 3.3 onwards, [agentic memory](https://docs.opensearch.org/latest/ml-commons-plugin/agentic-memory/) is offered as a built-in feature. [Modern AI agent](https://aws.amazon.com/blogs/machine-learning/amazon-bedrock-agentcore-memory-building-context-aware-agents/) frameworks come with built-in memory to eliminate the need to maintain separate databases.

### Knowledge Bases

LLMs don't have your company’s proprietary data. You can provide your company’s data as a knowledge base to the LLM. LLMs use this knowledge base to augment their responses with the RAG technique.

### Tools

Each agent will have certain tools to execute tasks by leveraging LLMs for reasoning and planning capabilities. For example, OpenSearch provides a [set of tools](https://docs.opensearch.org/latest/ml-commons-plugin/agents-tools/tools/index/) that perform tasks such as search, analyze, correlate, and execute. You can also implement your own agentic tools using Agentic Frameworks.

## Challenges in Developing AI Agents

Building an AI agent is an easy task, but integrating it with existing systems like databases and web services, is complex. Each use case needs an implementation of a specific API or another way of integration with the respective services. For instance, databases use JDBC connections, and web services work on REST API calls.

As discussed in previous sections, the sales assistant agent connects to different data sources using distinct connectors to perform a comprehensive analysis.

![](https://www.infoq.com/articles/nextgen-search-ai-opensearch-mcp/articles/nextgen-search-ai-opensearch-mcp/en/resources/106figure-3-1765802305311.jpg)

**Figure 3: Sales Assistant Agent using a custom connector per data source**

Model Context Protocol (MCP) will help overcome this complexity by providing a single and simplified way (universal way) of connection.

## Model Context Protocol (MCP): The Universal Connector

MCP provides a unified API to connect to different services, which makes AI agent integration seamless. MCP setup has two components.

- **Model Context Protocol**: An open-source, standardized, and secured protocol (based on [JSON-RPC 2.0](https://www.jsonrpc.org/)) that governs communication between MCP clients and MCP servers. Think of it like a universal power adapter or travel power adapter where you can use it in different countries with different sockets, and the adapter can streamline the input power and provide the connectivity and output required. More information about MCP can be found in this [article](https://modelcontextprotocol.io/docs/getting-started/intro).
- **MCP Server**: MCP Server is a special program that acts as a secure bridge between AI models and external data sources. It provides the tools to execute tasks on the respective service.

![](https://www.infoq.com/articles/nextgen-search-ai-opensearch-mcp/articles/nextgen-search-ai-opensearch-mcp/en/resources/73figure-4-1765802305311.jpg)

**Figure 4: Sales Assistant Agent using MCP**

## How does OpenSearch Agentic Search work?

In this section, we chose the local deployment model for this demonstration to simplify setup. Production deployments should use managed hybrid or cloud-native options for better security and scalability.

![](https://www.infoq.com/articles/nextgen-search-ai-opensearch-mcp/articles/nextgen-search-ai-opensearch-mcp/en/resources/57figure-5-1765802305311.jpg)

**Figure 5: OpenSearch Agentic Search – MCP setup and flow**

### Architecture Overview

- **Agentic Layer**


Claude Desktop functions as both a conversational interface (i.e., an agent AI application) and an MCP client, and can be [downloaded](https://claude.ai/download) to your local machine. As shown in the above figure, it communicates with the Claude Sonnet 4.5 LLM via the internet for reasoning and instructs the MCP to retrieve information from OpenSearch.
- **Protocol Layer (MCP Client and Server)**


MCP Client is configured through '`claude_desktop_config.json'`, will hold the configuration to connect to the OpenSearch, and initiate the communication to the MCP Server via the MCP protocol. MCP Server runs as a standalone service that bridges the MCP protocol to OpenSearch. It exposes OpenSearch operations as MCP tools, translates protocol messages to REST API calls, and formats the results for LLM consumption.
- **Data Layer**


OpenSearch stores and indexes the data, exposing operations through the MCP server.

### OpenSearch MCP Server Setup

OpenSearch provides the MCP server as the default from version 3.0 or greater. You can download and install the [OpenSearch MCP server](https://github.com/opensearch-project/opensearch-mcp-server-py) on your local machine or you can also follow the implementation guide provided in this article. The MCP server plays a critical role in translating/converting MCP tool queries to OpenSearch native REST HTTP API calls and submitting translated queries to OpenSearch and handling the results and formatting them as LLM-compatible responses.

The server also exposes OpenSearch operations such as Search, Analysis, etc, as MCP tools. By default, it will provide the tools to execute tasks on OpenSearch. The available [default tools](https://github.com/opensearch-project/opensearch-mcp-server-py?tab=readme-ov-file#available-tools) are:

- **ListIndexTool** lists all indices in OpenSearch with full information, including docs.count, docs.deleted, and store.size.
- **IndexMappingTool** retrieves index mapping and setting information for an index in OpenSearch.
- **SearchIndexTool** searches an index using a query written in query domain-specific language (DSL) in OpenSearch.
- **GetShardsTool** retrieves information about shards in OpenSearch.
- **ClusterHealthTool** returns basic information about the health of the cluster.
- **CountTool** returns the number of documents matching a query.
- **ExplainTool** returns information about why a specific document matches (or doesn't match) a query.
- **MsearchTool** allows executing several search operations in one request.

## MCP Server Deployment Patterns

Typically, MCP server installations come with the following deployment options.

- **Local Deployments**


MCP servers can run on an individual's workstation alongside the Claude desktop. This deployment is suitable for development and testing.
- **Remote Deployments**


External service providers (e.g., Salesforce, SAP etc) expose their systems through MCP servers, typically for security and governance reasons.
- **Managed Hybrid (On-premises/Cloud) Deployment**


Organizations deploy a centralized " [MCP Hub](https://www.truefoundry.com/blog/what-is-mcp-hub)" on-premises or in their cloud environments. The organization's MCP Hub will provide standardized, scalable, controlled access to multiple data sources.
- **Cloud-Native Deployments**


Major cloud providers like [AWS](https://github.com/awslabs/mcp), [GCP](https://docs.cloud.google.com/mcp/overview), and [Azure](https://learn.microsoft.com/en-us/azure/developer/azure-mcp-server/overview) offer their own MCP services.

Please note that you can also implement your own MCP server tools according to your requirements.

## Implementation Guide

This section demonstrates how to configure Claude Desktop with OpenSearch MCP Server for agentic search capabilities. We'll walk through installation step-by-step guidance, configuration, and query examples using two sample datasets: e-commerce orders and observability data. The complete source code and step-by-step setup instructions are available at [NextGenSearch-OpenSearch-MCP](https://github.com/daggumalli/NextGenSearch-OpenSearch-MCP)

## Agentic Search – User and MCP Interaction Flow

Below is the high-level flow of user and MCP interaction steps, demonstrating when a query is issued by a user, how it's being translated, and how MCP fetches and presents the data from OpenSearch to the user.

![](https://www.infoq.com/articles/nextgen-search-ai-opensearch-mcp/articles/nextgen-search-ai-opensearch-mcp/en/resources/39figure-6-1765802305311.jpg)

**Figure 6: User and MCP Interaction Flow**

\[Click here to [expand image above to full-size](https://imgopt.infoq.com/fit-in/3000x4000/filters:quality(85)/filters:no_upscale()/articles/nextgen-search-ai-opensearch-mcp/en/resources/39figure-6-1765802305311.jpg)\]

Now, let's see how the overall architecture works in action.

## Demo: Agentic Search in Action

The following examples demonstrate MCP-enabled agentic search using Claude Desktop connected to OpenSearch

### Demo Environment

For this demonstration, we are using two default datasets that OpenSearch provides as an installation package. Please refer to the implementation guide or [OpenSearch Dashboards Quick start guide](https://docs.opensearch.org/latest/dashboards/quickstart/) for more details.

- Sample eCommerce Orders: Retail transaction data for customer behavior analysis
- Sample Observability Logs, Traces, and Metrics: Logs, traces, and metrics for system monitoring queries

Please note, we are using simple English data for this article/demo. But you can also implement the same for vector data on OpenSearch.

### General Queries:

Let's look at some general natural language queries using this setup. On first use, you may need to issue a query like "Connect to my OpenSearch using MCP" so that the MCP connection is initialized.

#### MCP tools Query: " _List Tools_".

‘List tools’ query will give you the list of tools available under the MCP configuration to use with OpenSearch.

#### Index Query: " _List index or list indices of sales data and observability data_"

This is the NLP query where LLM understands the context of our query and goes through all available tools and selects ListIndexTool as the appropriate tool to list all the indices available in the OpenSearch.

#### Cluster Admin Query: " _Is the cluster healthy?_"

This is a platform operations query to check the OpenSearch cluster health. For this query, LLM uses ClusterHealthTool to provide the response back to the user.

![](https://www.infoq.com/articles/nextgen-search-ai-opensearch-mcp/articles/nextgen-search-ai-opensearch-mcp/en/resources/27figure-7-1765802305311.jpg)

**Figure 7: MCP Generic Queries**

Now, deep dive into some analytical insights on top of sales data.

### Sales Analyst Demo: Conversational Agentic Search for Business Insights

#### Sales Analyst: Popular Product categories query:

" _Can you find the most popular category of products ordered last quarter?_"

This query aggregates and provides results for the product orders for last quarter in the most popular category.

#### Sales Analyst – AI Insights Query:

" _Based on sales data, what is the interesting part to you?_"

In this query, we are leveraging pure AI analytical insights on sales data.

![](https://www.infoq.com/articles/nextgen-search-ai-opensearch-mcp/articles/nextgen-search-ai-opensearch-mcp/en/resources/21figure-8-1765802305311.jpg)

**Figure 8: Sales Analyst - Business Insights Queries**

#### Sales Analyst – Executive Board BI Query

" _Can you create a graph based on sales data for the executive board?_"

This is a very useful scenario for executives, where they don’t need to rely or wait for their BI teams to provide sales performance reports; instead they can generate on demand with required clauses by querying in plain English.

![](https://www.infoq.com/articles/nextgen-search-ai-opensearch-mcp/articles/nextgen-search-ai-opensearch-mcp/en/resources/18figure-9-1765802305311.jpg)

**Figure 9: Sales Analyst - Executive Board BI Query**

\[Click here to [expand image above to full-size](https://imgopt.infoq.com/fit-in/3000x4000/filters:quality(85)/filters:no_upscale()/articles/nextgen-search-ai-opensearch-mcp/en/resources/18figure-9-1765802305311.jpg)\]

**Note**: Claude Desktop can create React.js code that can be converted to dashboards.

Claude Desktop can also publish public dashboards. For example, here is a quick reference to the [above dashboard](https://claude.ai/public/artifacts/74b56fce-e102-4949-b843-55fd0ad6ec16).

Now, let’s look at the DevOps role and how they can leverage this whole MCP setup with OpenSearch.

### DevOps Demo: Conversational Insights on Observability Data

A DevOps engineer spends a significant amount of time troubleshooting a production issue by switching between different sets of dashboards and tools, as well as using custom scripts, [increasing Mean Time To Detect (MTTD) and Mean Time To Recover (MTTR)](https://www.suse.com/c/mttr-vs-mttd-what-is-the-difference/).

This investigative process might span multiple hours to days depending on the complexity of the issue. With OpenSearch Agentic Search with MCP, these workflows are conversational. Instead of writing complete domain-specific language ( [DSL](https://docs.opensearch.org/latest/query-dsl/)) queries or navigating between different datasets and systems, engineers can ask operational questions in plain English.

#### DevOps Engineer – Application Performance Investigating Query

" _What's causing high latencies in my application?_"

This query will scan through all the observability data available in different OpenSearch indices and automatically identify the relevant fields, and produce a summarized explanation of the latency issues.

#### DevOps Engineer – Monitoring and Observability Query

" _Show me nodes with high CPU usage and their active tasks_"

Same as a latency query, this query pick the right observability fields, and returns a clean summary of nodes with high CPU"

![](https://www.infoq.com/articles/nextgen-search-ai-opensearch-mcp/articles/nextgen-search-ai-opensearch-mcp/en/resources/13figure-10-1765802305311.jpg)

**Figure 10: DevOps Engineer - Application Performance and Observability Queries**

\[Click here to [expand image above to full-size](https://imgopt.infoq.com/fit-in/3000x4000/filters:quality(85)/filters:no_upscale()/articles/nextgen-search-ai-opensearch-mcp/en/resources/13figure-10-1765802305311.jpg)\]

#### DevOps Engineer - Observability - Correlation Analytics Query

" _Give me CPU-to-Latency Correlation insights dashboard_"

As you can see in the demo screenshot below, there is no need to switch between two screens or dashboard or manually correlation. Both CPU and Latency metrics are correlated, and Agent search gives a comprehensive view of correlation analytical insights.

![](https://www.infoq.com/articles/nextgen-search-ai-opensearch-mcp/articles/nextgen-search-ai-opensearch-mcp/en/resources/11figure-11-1765802305311.jpg)

**Figure 11: DevOps Engineer - CPU-to-Latency Correlation Query and Dashboard**

\[Click here to [expand image above to full-size](https://imgopt.infoq.com/fit-in/3000x4000/filters:quality(85)/filters:no_upscale()/articles/nextgen-search-ai-opensearch-mcp/en/resources/11figure-11-1765802305311.jpg)\]

For quick reference for the above correlation see the [analysis published dashboard](https://claude.ai/public/artifacts/2b2ed2e5-d738-4f51-80cb-2f70a84e3ab9).

#### DevOps Engineer – Observability – Anomaly Detection Query

" _Can you detect any anomalies in this observability data and create a dashboard?_"

Traditional observability platforms require setting up and training anomaly-detection models on your data, whereas an LLM can automatically understand your observability signals and identify anomalies using simple plain English queries.

![](https://www.infoq.com/articles/nextgen-search-ai-opensearch-mcp/articles/nextgen-search-ai-opensearch-mcp/en/resources/8figure-12-1765802305311.jpg)

**Figure 12: DevOps Engineer - Anomaly Detection Query and Dashboard**

\[Click here to [expand image above to full-size](https://imgopt.infoq.com/fit-in/3000x4000/filters:quality(85)/filters:no_upscale()/articles/nextgen-search-ai-opensearch-mcp/en/resources/8figure-12-1765802305311.jpg)\]

For quick reference for the above see the [anomaly detection published dashboard](https://claude.ai/public/artifacts/1c552830-be87-4b6a-b738-5aa0aeb66ca2).

## Conclusion

The evolution from keyword search to agentic search represents a fundamental shift in how organizations interact with data. While semantic searches understand the intent and context of a user query, with MCP and the combination of Large Language Models and OpenSearch, we’re stepping into a new era where search feels more like a conversation than a query.

MCP standardized protocol eliminates the integration complexity and makes it possible for AI agents to connect with different data sources, think through the context, and even act on what they find with reasoning. As AI continues to evolve, the combination of standardized protocols like MCP with powerful search engines like OpenSearch will make intelligent, context-aware data access accessible to every organization.

## About the Authors

[![](https://cdn.infoq.com/statics_s1_20260729094803/images/profiles/8efbd82eac4c89c607f98cd764639fbc.jpg)](https://www.infoq.com/profile/Srikanth-Daggumalli/)

#### **Srikanth Daggumalli**

Srikanth Daggumalli is a Senior Analytics & AI Specialist Solutions Architect in AWS. Out of nearly twenty years of experience, he has over a decade of experience in architecting cost-effective, performant, and secure enterprise applications that improve customer reachability and experience, using big data, AI/ML, cloud, and security technologies. He has built high-performing data platforms for major financial institutions and Fortune 500 enterprises, architecting mission-critical solutions across global payments, cross-border transactions, anti-money-laundering systems, credit-risk management, enterprise analytics, and high-availability data infrastructures – enabling improved customer reach and exceptional user experiences. He also built so many real-time streaming Log Analytics, SIEM, observability, and monitoring solutions for many AWS customers, including major financial institutions, Enterprise, ISV, DNB, and Automotive and Manufacturing etc.

Show moreShow less

[![](https://cdn.infoq.com/statics_s1_20260729094803/images/profiles/ec238719d02c72e80496fe7164545e44.jpg)](https://www.infoq.com/profile/Arun-Lakshmanan/)

#### **Arun Lakshmanan**

Arun Lakshmanan is an OpenSearch specialist at Amazon Web Services, bringing more than twenty years of experience in software and information technologies. He has dedicated the last decade to information retrieval, helping customers and developers worldwide design and implement effective search solutions. Arun holds a Master's degree in Computer Science and resides in the Chicago suburbs.

Show moreShow less

- #### Popular in AI, ML & Data Engineering



  - ##### [Netflix Details its In-House LLM Serving Platform with Triton and vLLM](https://www.infoq.com/news/2026/07/netflix-llm-platform/ "")

  - ##### [Securing MCP in Production: Defense-in-Depth beyond the Gateway](https://www.infoq.com/articles/securing-mcp-production-gateway/ "")

  - ##### [Securing MCP in Production: Defense-in-Depth Beyond the Gateway](https://www.infoq.com/articles/securing-mcp-production-gateway/ "")

  - ##### [An Evolutionary Architecture Pattern for Managing AI’s Pace of Change](https://www.infoq.com/articles/evolutionary-architecture-pattern/ "")

  - ##### [The Future of Engineering: Mindsets That Matter When Code Isn’t Enough](https://www.infoq.com/presentations/ai-future-engineering/ "")


#### Related Sponsors

  - ##### [AI Agent Swarm Patterns (InfoQ Webinar) - Watch Now On-Demand](https://www.infoq.com/vendorcontent/show.action?vcr=b04e8a98-3462-46e7-bb9d-c621b641e63c&primaryTopicId=4523&vcrPlace=BOTTOM&pageType=ARTICLE_PAGE&vcrReferrer=https%3A%2F%2Fwww.infoq.com%2Farticles%2Fnextgen-search-ai-opensearch-mcp%2F)

  - ##### [Vibecoding your Own Multi-Agent Workstation](https://www.infoq.com/vendorcontent/show.action?vcr=fb74901d-d8f8-4924-b930-ad16a2db1941&primaryTopicId=4523&vcrPlace=BOTTOM&pageType=ARTICLE_PAGE&vcrReferrer=https%3A%2F%2Fwww.infoq.com%2Farticles%2Fnextgen-search-ai-opensearch-mcp%2F)

  - ##### [From Prompt Hacking to Architectural Determinism: Engineering Reliable GenAI Systems](https://www.infoq.com/vendorcontent/show.action?vcr=2c3e2def-3d98-457d-b00f-229fa12f9647&primaryTopicId=4523&vcrPlace=BOTTOM&pageType=ARTICLE_PAGE&vcrReferrer=https%3A%2F%2Fwww.infoq.com%2Farticles%2Fnextgen-search-ai-opensearch-mcp%2F)

  - ##### [How an AI Agent Deleted Production Data and Its Backups at a Company (and How to Protect Yours)](https://www.infoq.com/vendorcontent/show.action?vcr=a5e413c2-9a1c-4aad-8fd1-0730c6dd373c&primaryTopicId=4523&vcrPlace=BOTTOM&pageType=ARTICLE_PAGE&vcrReferrer=https%3A%2F%2Fwww.infoq.com%2Farticles%2Fnextgen-search-ai-opensearch-mcp%2F)

  - ##### [Make Quality Executable: Verification Gates for Agentic Engineering at Scale](https://www.infoq.com/vendorcontent/show.action?vcr=01937dc3-7e40-4ce7-abbf-09fcb9e70606&primaryTopicId=4523&vcrPlace=BOTTOM&pageType=ARTICLE_PAGE&vcrReferrer=https%3A%2F%2Fwww.infoq.com%2Farticles%2Fnextgen-search-ai-opensearch-mcp%2F)
- #### Related Sponsor

[![Related sponsor icon](https://imgopt.infoq.com//fit-in/218x500/filters:quality(100)/filters:no_upscale()/sponsorship/topic/29fe04fa-b3b6-4c3e-ba9f-511532c682bf/DatadogWebinarAug6-RSB-1782482966045.png)](https://www.infoq.com/url/f/371e81f5-591a-4cad-b047-3264ff4a7bb4/)



  - August 6, 2026, 1 PM EDT

    ##### [Building AI Agent Evals for High-Stakes Incident Response](https://www.infoq.com/url/f/630509fe-821c-4992-a4b5-6ca7cd134612/)


    [Presented by: Brianne Bujnowski - Senior Product Marketing Manager, AI at Datadog, and Benjamin Barton - Senior Software Engineer at Datadog](https://www.infoq.com/url/f/bb4f9b00-9a76-4b70-a5a2-c8892b5aa36b/)


[BT](https://www.infoq.com/int/bt/ "bt")