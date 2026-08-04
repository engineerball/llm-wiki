---
source_url: https://www.youtube.com/watch?v=oF-LYeTTjfE
ingested: 2026-08-04
sha256: 89bf1023c13d0d4e04943cb922bdd3567913240b2efc3d1775c4ec806cad9f80
---

![Thumbnail (1920x1080)](https://i.ytimg.com/vi/oF-LYeTTjfE/maxresdefault.jpg)
# [Query Understanding With Large Language Models: Techniques and... - Hajer Bouafif & Cédric Pelvet](https://www.youtube.com/watch?v=oF-LYeTTjfE)

**Visibility**: Public
**Uploaded by**: [OpenSearch](https://www.youtube.com/@OpenSearchProject)
**Uploaded at**: 2025-09-13
**Published at**:
**Length**: 50:40
**Views**: 343
**Likes**: 2
**Category**: Science & Technology

## Description

```
Query Understanding With Large Language Models: Techniques and Optimizations in OpenSearch - Hajer Bouafif & Cédric Pelvet, Amazon Web Services

This session presents a range of techniques that integrate Large Language Models (LLMs) with OpenSearch to enhance query understanding in search systems. We will examine the use of LLMs for query expansion, highlighting their ability to generate semantically enriched tokens that bridge lexical gaps between user queries and document content. Additionally, we explore query rewriting strategies that leverage LLMs to infer and apply relevant metadata filters, improving retrieval precision. While LLMs offer substantial improvements in relevance, they also introduce challenges related to inference cost and query latency. To address these, we introduce semantic caching using OpenSearch, an effective approach to mitigate the performance overhead of LLMs in production-grade search pipelines. The session includes a live demonstration of these methods in the context of an e-commerce use case using OpenSearch.
```

## Transcript

All right, good morning everyone.
Welcome to this session about query
understanding with LLMs where we're
going to be talking about search.
So search technology and really the
market around search has evolved in the
past few years like tremendously. We
have seen the arrival of vector search,
semantic search, all these things and
companies have tried to implement
semantic search as a silver bullet and
this silver bullet is actually not
working very well. So they are
struggling. They're seeing that the
search results are not as good as they
would like to be at the end by only
using semantic search. And this is uh
this is something that has been um like
acted upon with various techniques. So
you can use something like reranking to
act on the output to improve the
relevancy of the search results. But
this doesn't really work if your initial
search results are not good.
So these technologies are um are not I
would say the solution the full solution
to having good semantic search in the
end. At the same time, we've had large
language models that have become very
very good at understanding content at
extracting information out of content.
So today we are going to be talking
about uh these large language models how
they are how they can actually improve
the input of the search results. Uh
because the input is something that uh
if we have low quality input, you are
going to have low quality output. So in
this talk we are going to be talking
about the um like how to improve the
quality of the input by using large
large language models.
I am sick pv I'm a principal specialist
solutions architect with AWS and today
we are going to u also have a gra who is
going to be presenting with me.
>> Yes. So let's look at um the uh the
underlying technologies that we have
with open search. Um so we have multiple
things multiple layers I would say of
search technologies. Uh the foundations
of what we have in open search is going
to be the historical lexical search with
the M25. U this is where you are going
to be dealing with synonyms. You are
going to be dealing with exact match or
something that's going to be close to to
what you have with tokenizers analyzers
all these things. And this is what
historically companies have been doing.
This works really well for most cases.
But if you want to introduce multiple
languages, if you want to introduce uh
more complex synonyms, semantic
searching, all these kind of things,
lexical search is not enough.
Sparse neural search under spar search
is um is something that is going to be
close in the execution of lexical
search. So we're going to get a an array
of uh of terms of tokens of words uh
that are going to be extracted
semantically going through a specific
model. uh and you are going to have some
weights in addition to the to the terms
themselves and this adds context. You
have semantic context. Uh this this gets
a bit better. U it's actually very
interesting in a single language
probably more than vector search in some
cases. Uh but if you want to deal with
multiple languages at the same time
sparse neural search starts to get
things but still the the vector search
is going to be much better at multiple
languages.
Vector search is a way to really
abstract the representation of the
actual data. So you are going to be
representing your uh your documents or
barraphs, chunks of documents and your
search queries as vector of vector
embeddings and these are numbers that
are completely abstracting rep the
representation of the of the meaning. So
this is uh these are the I would say the
the main things that we're going to to
see the main building blocks of what we
are going to see there and then you also
have hybrid search because sometimes you
want to have exact match if you have a
reference for example for a book or
something you want to have exactly this
reference and this is where lexical
search is going to to be shining vector
search going to be losing that in
translation. Uh but if you want to have
semantics you need vector search. So to
combine these different techniques,
hybrid search is able to give you uh
basically a combination of the search
results with some specific rules that
you have to define. Uh and hybrid is
going to help there. And then multimodal
search is a way to search your data
through different uh modalities like for
example through text, images, sounds,
videos, any kind of modalities that can
turn into a vector embedding. Multimodel
search is going to be helping there.
So on top of that, on top of this
foundation, uh we have this um like
different plugins, different
functionalities inside of open search
that will help you simplify the usage of
these. So uh on on the left we have the
document processing with the ML
inference processor. On the right we
have the uh also the the uh the docu the
search query and results processing with
the ML inference processor. Basically,
it's way too abstract how to create the
embeddings, how to use vector search
internally by sending the the original
text, original data that you have.
In addition to that, we have uh some
very interesting um plugins. Uh one is
user behavior insight UBI where we are
going to be able to capture the link the
correlation between the input what the
user is actually inputting into the
search box and the actual output what
has been selected what has been bought
if you are on an e-commerce website and
gathering this information enables you
to have a better understanding of what's
happening you can have analytics on that
and you can also use this kind of
information to better rerank your data
your results and this is where the the
ranking um technologies is going to be
helping. But as I mentioned at the
beginning, reranking only helps if your
initial sub results are already having
the uh the relevant results. It's just
going to be reordering the results. It's
not going to be getting any new
information out of your database. If
it's not there, you won't be able to see
it even if you have a good reanker.
So we have uh LTR launch to rank, we
have Amazon personalize, we have
multiple ways to to rerank there. Um
this is very very useful if you want to
personalize at the end uh you have
search results and uh for some users um
the number uh like three items is
actually the most relevant then you are
going to be learning that and then
proposing this item first the next on on
the next iterations
and then finally on top of that we have
I would say applications that you find
at the um like not necessarily inside of
open search. You can do some of them
inside of open search but mostly you are
going to see them in the in the
application level. Uh so everything
that's going to be about query
understanding query writing. So query
understanding is to be able to
understand what the intent of the user
actually is. Uh and sometimes you have a
a discrepancy between what the user is
actually thinking and what the input um
UX is actually enabling the user to to
to write. Query rewriting is going to be
to enable the the the system to actually
improve the quality of the input. It
could be uh rewriting with uh adding
some filters that would be extracted
from the input. It could be rewriting
with better uh uh better spelling. It
could be rewriting by adding some um
some semantic context.
Query classification. Uh this is where
we we want to basically um like
differentiate between users who want to
um like target something that's very
very specific uh where some other
queries may be targeting something
that's more generic like some users will
know exactly what they want to do what
they want to search for and some users
are like well I'm looking into this kind
of thing but I'm not exactly sure. So
these kind of queries will target
different underlying technologies
lexical search vector search sparse
through this this kind of query
classification
to evaluate the result. We can have LLM
as a judge uh offline online and then we
can also have result summarization
mostly useful if you have um if you want
to get some some information about a lot
of data uh you can actually use NM to
summarize they are very good at
summarizing information uh useful for
your log analytics for example you can
ask okay what kind of errors did I have
yesterday it will summarize everything
and will give you the answer for that as
a summary
So the context is very very important
here. Um so I mentioned we are going to
be talking about the input mostly the
input today how to improve the quality
of the input and the context is very
very critical.
So we have three main context parts. We
have the user context domain context and
the business context. Um if we are
looking at a at a search engine, you
have an application where you have some
search, you have different users. These
users will have different interests.
They will have different goals. They
will have different behaviors. Uh and
they will have also maybe some diff some
uh some some preferences like I'm
looking for cheaper items or I'm okay
with like luxury items or something. So
these depending on the user
understanding what the user actually uh
wants ultimately by some context that
can be captured in multiple ways that
we're going to be talking about uh we
can actually add some information on the
input that may not be captured by what
the user is actually putting. They're
not in their input say who they are.
They're just going to be inputting what
they want.
The domain context is more about the
industry what's going on with the
trends. uh product recommendations,
everything that's there. For example, if
you're looking for an iPhone, uh if the
system knows that an iPhone 17 was
announced yesterday, that would be very
useful. You can bump that up. Uh
otherwise, you would get different
versions and not not not really useful.
So, um domain context with industry
specific domain specific information can
also be added to uh to the global
context to improve the input. And
finally, when we have an application
that does search,
it is very very common that the business
itself wants to have some
results that get get are going to get
promoted. For example, if you are
promoting uh videos like news u then you
you may want to have some of these
latest news promoted at the top. Or if
you are running a bookshop, you want
some specific books to to pop at the
top. Or if you uh have some paid
customers like these customers who are
paying to get uh advertisements for
their products, they also want to be to
be promoted there. So traditionally, if
you want to do that with um like search
queries that you build for lexical
search, you're going to have a very very
long search queries that are going that
is going to be optimized one way for the
users and then the business comes and
say I want to optimize this way. So they
turn the query around and and modify
that and then they they say okay now the
users are not happy with the results. So
they modify the search and then they
have an an insanely complex query that
even the the the person who wrote this
query if they go on vacation they come
back they don't understand what the
query does. So um this is a very complex
situation where you want to optimize the
search results based on different
complimentary or contradictory in in
some cases uh um like users.
So um in the demo that we're going to
have we are going to be focusing on the
uh user context and for this user
context let's have a look at uh at an
example. So here we have an input and
the UX is going to be very important
here. uh if you if we have a different
UX uh for example having a chatbot or
something the input will be different
but if we have a text box like this the
classical mental model around that is
going to be I'm going to input a few
words and having a few words is going to
be u to be a bit critical and first of
all um here we have three different
people and with exactly the same words
that they could be inputting they have
actually different things in
And this is not the only problem because
uh if we are looking into uh semantic
search for example if we are looking
into like the the embeddings um what's
happening is that the transformer models
have been trained on longer inputs to
create an embedding. So you have usually
sentences you have like tens of words
and here you have one word two word
three words and if you have a low
quality input like a few words only if
you don't do something to improve this
input then the uh the output the
embedding itself is going to be lower
quality. You are going to see that your
cosine similarity score is going to be
0.7 0.6.4 for and then you are going to
be having a very low threshold which is
going to be increasing the noise in your
search results which is going to be
basically impacting the quality of the
result. So we need to be able to
actually act on this input based on some
information that we have on on these
people.
So here we have different uh
different
intents and uh to do that we are going
to be uh talking about or introducing uh
the concept of personas for uh for this
kind of uh application. So a persona
first of all u probably you've heard of
this term before I want to uh to
emphasize that a persona is not a role.
So a persona is not a data scientist.
It's not a um a a student. It's not a
worker somewhere. It's a person.
It's an abstract a fictional person that
is going to be representative of a group
of real people. And these people are the
users of your application. So there are
multiple ways of having of getting the
personas but basically see that as
people that are going to be representing
your actual users and they will have
different characteristics.
These characteristics are going to be
about behavior about mental model and
about goals
and to to actually have personas there
are multiple ways. So usually to have
good personas you are going to have user
research. So you have a UX team that
does user research and you get the
personas and then you know exactly who
your users are and these users may vary
per country. They they may vary like if
you if you are worldwide than this but
uh you need to be able to understand the
users to be able to to capture how to
actually provide value to them.
If you don't have that because maybe you
are starting or maybe you don't have a
team that does that or you already have
something uh actually you probably have
intent in intentionally or not created
what we call proto personals. Proto
personals are like an idea of what our
users actually are. they are not
validated at this stage by uh by the the
data points that you can get from the
from the field but they represent
already something and then you need to
validate your hypothesis on these proto
personas to actually refine and get
better information about your users.
So if we have um personas and or if we
have proto personas then we can actually
uh get some uh some good information
about our users and use this information
to actually enrich the the result.
And with that I'm going to let Asia talk
about search flow and architecture.
>> Thank you S.
There is a lot of noise. Let me know if
I should repeat this. Um
all right so um was Federric went
through how important it is to build
your persona and also include the user
context business context uh domain
context into your uh search queries. Now
usually um let's say you have a business
context where you would like to
prioritize some marketing strategies for
example you will need to do some
processing uh after retrieving your
search results you have like the
advertisement organic search results uh
and so on here we are going into more
simplistic approach into how LLM can
makes it easy for us to include the
context within the search query in
itself uh and reduce the amount of
processing postprocessing that you
usually do on the search query.
So if you take a persona um it's coming
on connect on your web application. It
will type in uh their input. So instead
of post-processing the search results
here we are pre-processing the search
results using the context. Um so it the
user input will go through let's say
routing a gateway. You can think about
it like that. Um and here you will have
you will need to build like or what we
suggest is that you build different
paths for your query. The first path
will be uh for the persona that you have
already identified. You know your users,
you know your persona and for those u
identified personas. So you have already
gathered we expect you to already have
uh gathered context about what their
preferences what they are what's their
behavior what's their priorities in life
uh what they're looking for usually and
also like capture the UBI data meaning
for example what type of queries do they
usually run are they the type of persona
that um uses or they know exactly what
they're looking for are they the type of
persona that they always look for
specific brands they want keywords or
they more into navigational type of
persona where they want more flexibility
from their search results.
And then as a business you need to grow,
right? And you would need to also
accommodate for search results that are
uh tailored to new users, new users
where you don't know the context yet.
Maybe you do have some context and that
context. What we recommend here is to
not have something like anonymous
completely uh blank without any
personalizations. You can always have
personalizations based on the uh already
existing personas. So how the headqu are
uh what the trends currently recently
your customers are looking for for
electronics versus um I don't know some
fashion items uh and so on. Or if it is
broadcast for example online, you know
where your users are going to and what
type of podcast they are looking for uh
in that point in time. So you can always
enrich for the new users as well. And
here you will include the uh market
trends, business priorities where this
context will come from your own
environment basically. So you can bring
it from external databases, you can
store the information in open search uh
and build this context included within
your uh search query and then finally
you will run the search query enriched
already into with open search as a
search engine.
So here you have couple of benefits that
we highlight. So first you have a
tailored search persona for uh tailored
search experience uh for the primary
persona that you're already familiar
with and also the new persona or proto
persona as uh Cedric mentioned and uh
also um you not only including the user
context here we are taking consideration
the domain and business priority which
is many many customers that we talk to
they want to include the business
context but they don't know why or how
and uh they overlook basically the
importance of having the business
context uh besides the user context.
So if we take a persona Sarah u she's um
uh 32 years old uh she likes like good
quality products she's into fitness
travel and uh she's mainly shopping
online. So Sara is a persona that uh we
know already
and Sara comes into our e-commerce uh
applications. She types in black shoes.
So here instead of having Sara go
through all the filtering and like
looking for type or the brands that they
she she usually likes we already provide
that information within the search query
for her. So first we generate the
context for her. So we know her
preference, we know how she usually run
their search queries using UBI. Um we
will generate more text to enrich first
of all the few words that she has
because here when we enrich with text we
also reduce the noise in the embedding
and the vector search provide us with
better results. So that's on the
technical level on the uh context and
search relevancy level. So we uh
complete what she have already started
as a search input with her own uh
preferences without her having to type
all of this information. And also we
automatically extract the filters for
her and we apply the filters instead of
her going to the faces and filter on the
brands filter on the age category etc.
We already know that she's looking for a
footwear. We already know that she's
looking for a female products unless she
she specifies otherwise like saying
black shoes for men for example or for
young children
and then in open search in itself. So
here we provide an example for again but
think about it as a hybrid search as
well where uh you instead of running the
embedding or generating embedding for
black shoes only you have an embedding
of enriched text that provides good
embedding quality and therefore good
vector search quality as well. And this
is something very important to consider
when you're running vector search. It's
nothing magical in it. you need to make
sure that the embedding is of a good
quality and representing uh the uh the
the information with the most um
complete context possible basically.
Okay. So um from architecture
perspective this is think about it as a
reference architecture. Um and we Cedric
will go through a demo how we
implemented this. Um so again we have
the web application we have the user
coming in typing their um query. Now the
query will enter the decision gateway
for routing as we discussed uh if it is
a new persona or an existing persona
that we are familiar with
and here um the um the the the logic in
itself on how to process this is going
into LLM first architecture. So here we
are using strands agents um as the
primary planner and orchestrator for
this query understanding. If you're not
familiar with trends, agent is an
open-source agent uh framework. It's
based on Python. It's very easy to start
with and basically with trans you have
three elements. You have the model LLMs,
you have the prompt and you have the
tools. And the tools you can you have
already pre-existing list of tools.
Otherwise, you create a function Python
function and you have like a decorated
as a tool and the LLM will automatically
uh capture that and use it use that
function as an existing tool. And um
also something about strand strands and
what pushes us to use strands is that
eliminates the um the building steps and
to like hey build the fl the flow uh
explain to the LLM what should we do at
the first step second step and so on
which tool to use and and when here the
LLM chooses by itself what's the
framework what's the flow and also what
tools to choose for that specific query.
Now uh so we are using in the demo cloud
4 uh it's host on Amazon bedrock but of
course think about it as your uh own LLM
or small lang large large language
models uh hosted on your own uh
inference here the LM will automatically
generate or expand the query using the
uh context that we provided with um here
we're providing it with a tool which is
a Python function that will Um
it will first uh extract the filters
that have been um extract the filter
from the expanded query and uh it will
also construct the open source DSL query
basically like the uh the filters and
like if it is master should um and uh
whether the type of query can or hybrid
and then uh the the agent will run or
use open search as a tool to run the
personalized search and run the uh
provide the personalized search results.
It's as simple as this right
now. Um yes, it is simple but for
production workloads, it's going to be
complex to implement this and it is also
challenging to uh maintain the your uh
business SLA service um level agreements
in terms of latency and so on. So let's
say uh the LLM goes into um a loop and
thinking and reasoning again and again.
What should be the flow? It's losing
time. Uh and also maybe the query
generation is taking long time than
expected. What would you do? You will
lose Sara that was on the web
application in that case. So here uh we
highly recommend that you build your
default path. The default path is uh
where you know what works best with most
of your users. have the query already go
through the default path by default. get
the results as soon as possible and then
with the uh if you have an existing
persona coming in or even anonymous
persona you'd specify a timeout your
threshold what's your expected latency
for example for e-commerce podcast uh
e-commerce website is like 200
millisecond 300 maybe they don't they
cannot go beyond that why for example if
it is a rag internal rag use case they
can go with 1 second two seconds so here
you definitely need as business define
what's your timeout and if the um the
RLM architecture here RLM first
architecture exceeds that time out you
already have the research results
provided by the default path and you
retrieve that so here you have um
different benefits you have your
fallback strategy so uh you don't exceed
the business SLA so the business is
happy users uh are happy happier than uh
spending a lot of time on the web
application uh and also you reduce the
zero results uh from your uh search uh
experience.
I think with that we'll go to the demo.
Uh
thank you Aar.
So before going to the demo uh let's
introduce the demo context. So we are
going to see a um so an application
where we are going to be searching for
items in a store in shop store and uh
meet our three main personas that we are
going to be looking at. So we have Sarah
who's a marketing manager who whose
interest are in technology fitness
travel and preferences are around
quality and efficiency and shops online
very frequently. Alex is going to be a
computer science student and with
gaming, programming and music interests,
more budget conscious, look looking for
deals, looking for discounts. And
finally, we have Michael uh who likes
do-it-yourself projects, gardening,
sports,
likes also durable um durable items and
u with good values and prefer instore
shopping.
So for the demo, let me set this up.
Quickly,
where are my displays?
Mirror.
Yeah.
All right.
So for this demo, we have a simple
application uh that has been created in
Python. uh and we are showing here
multiple uh multiple possibilities with
a persona. So we can go with no persona
at all which means that we are going to
be dealing with no query understanding,
no query expansion, nothing uh just as
is semantic search. We can have an
anonymous user. We can have our three
main personas. The anonymous user is
going to have uh some general interests
general shopping search without
personalization etc. It's going still to
be able to expand
based on the LLM understanding of the
input, but it's not really going to be
like personalized at all. So here we can
search for um our famous black shoes
and uh this is going to go through
multiple steps. So the first step is
going to be the query expansion we have.
So here I selected no person here. So
I'm not going to have any kind of query
expansion. So I'm effectively going to
open search and generate a query that
looks like this. Uh so this is my my
black shoes here. Uh computing the
embedding through this model and we have
no filters extracted. And then we are
outputting only what we want. We found
10 results because this is what we ask
for with size equals 10. And we get some
black shoes because well this is
semantic search so this is not too bad
but it's random random shoes. We don't
really have anything that's going to be
random. So, we need to browse in the
result uh as a user. If we have that,
okay, this is the one that I want. I'm
going to look uh we have scores that are
not too bad as well. Uh we are using
cosign similarity and we have 0.79 best
score. It's not too bad. Uh we can have
worse than that definitely without any
uh any expansion. But let's look at what
happens when we actually change that. So
just changing the context of who the uh
the user is is going to be providing a
different result in the query expansion
set. So here the LLM actually uh
returned this uh this uh these results.
So we have expanded the query with um
something that is really generic. So we
have all sorts of shoes, sneakers,
boots, u oxfords etc. So same thing it's
not very personalized because our
persona is not it is a generic one. So
uh what we have here is obviously a
different query. Uh we have extracted
footware as a category. So this is
already something that can be
interesting. We don't have any
characteristics other than that. So um
we just have the query expansion. We are
still going to go through the same model
for the embedding and we are going to
have uh this the search results. So it
actually improved the score a little bit
from 079 we went up to uh 081.
Uh and we are still getting some uh some
random shoes but at least uh the um the
the input has been a little bit more um
more tailored towards looking for uh for
footwear shoes uh and not for toys or
for something something different.
If we go to other personas like Sara for
example, let's go there.
We are going to get some photo of
personalization out of the box. It's
going to be looking at the information
that we have about Sara and we are going
to be getting some gender affinity here.
Uh Sarah likes u athletic running
sneakers but also comfortable shoes uh
for uh for professional
um professional environments. And here
we are going to see uh so the new query
expansion with the filters and we are
going to get some results. So 0.82 first
one comfortable shoes. So not really for
the um like not sports related but it's
also based on the fact that our data set
is not actually uh targeting footwear
for this gender affinity that well. So
the uh the input is not everything. Uh
the actual catalog and the way that you
actually uh put your data in the catalog
is going to be uh also very important
here. So here we are getting some some
results that are that are interesting.
Uh but if I change that and I want to
actually ask Sara search for uh my
brother
and the LM here is going to understand
something uh that's new. uh we are going
to be looking not something for Sarah
but looking for uh for our brother. So
maybe we have information maybe we don't
but at least we have other information.
Brother is going to be mostly looking
for a male gender affinity and we are
going to start getting uh some uh some
results that are a bit different.
So we can do the same thing with all the
different personas uh and start seeing
some uh some results that are going to
be uh really tailored to um to the
different different persona. So Alex
being a student we are probably going to
get some uh cheaper shoes more
comfortable. Yeah. So we have sneakers
here.
Same thing with the with score relevancy
that is that is high still. That's good.
So we have all of that. I can go also
with with Michael. I'm not going to go
through everything. But because we are
using semantic search with uh with dense
vectors, we can also uh search with
different languages. So uh I can search
in French
and I'm going to to get some some
results there with the C expansion.
So same thing we have black shoes which
is literal literal translation and we
have something that is tailored to Alex
because this is the person that we have.
So this uh this approach is actually uh
very interesting when you really have
some information about uh about the user
but you may not have all of that. So
here we say well we have a persona we
have uh we use that persona there. You
still need to have a an actual user.
Remember that personas are fictitious
people that represent a group of real
people. So you still need at some point
to have a link a mapping between who the
actual user is and mapping this person
to uh to to this persona that is
representative of the group of users
with the same goals, mental model and
behavior.
Uh so yeah so this um these models are
really really good with uh with multiple
languages. So I showed French uh we can
go uh if we want with uh with Japanese
um
and we are going to get similar similar
results as well.
Yeah.
and something. So you can see that it's
taking quite some time. Um but if I'm
going back to uh to my black shoes
initial okay let's change the input.
Okay.
Yeah.
This one here is going to use a cachi
response. So if you were in the previous
session where u there was a talk about
semantic caching and caching for LLMs um
this one is using a simple exact match
with the input on the output. There are
other techniques to do that. I recommend
watching the the video of the previous
session. uh if you have the time and you
did not attend the previous session but
basically we can use caching here to
improve the speed because obviously
going through the LLM waiting 1 second
or two um this was not taking a massive
amount of time here but in reality if
you have a lot of things maybe it's
going to be a bit more expensive so
caching is going to be part of this uh
of this setup.
Yes.
So uh let's go now with the
what do we have here the lab demo and
with the best practices for prod
deployment.
Thank you sik.
All right. So um quickly how to um make
sure that that such simple solution that
you can think of is ready for
production. uh we do have many like list
of musthaves fallback strategy I will
discuss with your critical path here
recommendation is to go with hybrid
search to be honest like that's what we
see uh most of the our customers getting
the value uh from um then optimize the
LM latency with caching uh experience
caching uh mechanism or maybe use also a
memory database like Valky um look for
uh features where you can improve The
latency on the inference level. So here
if you are using Amazon bedrock we do
support a feature called latency optim
optimized inference is like for enable
it for specific LLMs but I think they
will uh increase or like increase or add
more uh LLM support for the latency
optimized inference. Um and then
optimize of course your vector uh
deployment with open search. Apply
filters as much as you can. Uh use
optimized memory nodes. um of course
evaluate. So here we not go into deep
into how to evaluate this but the LLM in
itself and the strands they have the
feedback loop and they automatically
evaluate basically uh the search or the
final response based on the user uh
input and reason whether that's good
enough or not. Um and then um observe of
course. So here we talk about
observability strands also uh integrates
with open telemetry. So you can already
publish the logs, traces uh and metrics
into open search and u monitor the
different latency uh and performance of
the LLMs but also the response of the
LLM. Um watch out for frequent updates.
This is also something to consider for
your data. If you have frequent updates
of your data, make sure that you're um
you're accommodating for that whether
for the graph if you're using HNSW uh
for the vector graph constructions. Um
also if you are choosing changing the
embedding LLM, make sure that you also
reindex the whole data otherwise you
will get with the you end up with the
very bad search results. Um
uh user reanking as well. I think like
uh these are like capabilities that are
good. They are there. They're easy to
implement. So there is no harm to also
have reranking in your uh search
pipeline before going into a very
advanced um pipelines test scale of
course and use open search benchmark.
They have released open search benchmark
2.0 uh o I think uh which is very um
relevant and important to uh test
especially the scale of your uh of your
domain and how important or how
efficient is your cluster configuration
is able to handle the scale of data. So
here we leave you with few resources. So
the first one um is the hagging phase
public demo. Here we uh provide you with
demos on many many strategies into how
to uh integrate LLMs and machine
learning with open search whether for
query rewriting or for semantic
highlighting uh for multilingual support
for agentic rag and so on. So uh we
highly recommend you check that uh out.
Uh also review UBI if you still did not
hear about UBI not familiar what it is
about. Uh the open search 3.2 to
releases especially on vector ver vector
search optimization uh releases and
finally the trans agent if you are not
familiar with the uh SDK.
Thank you so much everyone uh for your
time and u yeah have a great day
question. Yeah.
>> Yeah. First of all, thank you so much
for the idea. It's it's really good and
I could probably go backwards to say
it's really amazing one. The reason I'm
saying that is because many of the users
that I'm speaking to, they actually need
guidance like this and this fills the
gap. I feel like thank you. Thank you so
much for
>> having said that um one of the things
that we use for enrichment is beyond the
query itself is the filters is the
filters. So I was how I was wondering
how do you ensure that the filter that
is being generated is already present in
your open search indices. So how do you
coordinate that in your particular
documentation implementation? How do you
ensure that they are correct filters?
>> Yeah. Okay.
>> So
yeah so for the for for the filters and
ensuring that you have the correct
filters there are multiple things. So
first of all, the way that it's done
with with strands, we have a prompt that
at this time lists ex extensively and
exhaustively all the uh possible values
for a uh for example the uh like
footwear like the category footwear,
dresses, shirts, etc. This can be
queried, this can be dynamic. It's
currently set in our demo prompt, but
this can be dynamic. So you can extract
from actual data like what do you have
in your inventory? Maybe you want to use
only what's in your inventory. Maybe you
want to uh use uh what everything that's
possible. Uh I've seen some for example
some some companies uh with u secondhand
cars for example. Uh there are two
options. You can use the set of
secondhand cars that you have in your
catalog or you can use all the possible
brands with all the possible models.
>> So two different things uh that you can
that you can have. But basically yes
this can be completely the dynamic. Uh
the idea is that the LLM needs you need
to instruct the LLM to pick with a
specific set of exact matches here
otherwise it will create something that
may not exist in your uh in your result.
And also the filters that we've been
showing here are I say hard filters.
It's like it's either in or out. We can
change that uh to more soft filters by
having some boosting in the search query
things like this. So same thing if we
don't want to be as uh strict as we were
in this demo we can change the the the
mechanism a bit thank you so much can do
it
>> any other yeah question
>> yeah first of all great talk I have one
question uh terms of like do you have
any recommendations of how to use UVA
data as useful inputs for the large
language
so that it can generate user personal
exper
any any any recommendations.
So when I mention the proto personas for
example um this is something that can be
uh very common even if you don't name
that proto personas you probably have
done that so this this is an hypothesis
so when you create proto personals you
have an hypothesis these personas that I
showed were proto personas we did not
conduct user research for that um so you
have an hypothesis and then with UBI you
actually capture the actual
behavior of your users and behavior is
an important part of personal Remember
personas are goals behavior and mental
model behavior is one of the important
thing. So using UBI if you can capture
the the behavior of your users you can
actually refine these personas validate
or invalidate your hypothesis on who
your users are and actually get better
personals but with with time and if you
have a better understanding of your
users you are going to be able to
provide better query results because you
understand them better and you can
enrich the the queries that way. So this
is one way that I'm thinking of uh that
comes to mind to use UBI to uh to
improve the input that you send to the
to your uh to your LLM not the LLM
itself but but the for the input
>> take the do some transformation before
we send it to the last so that becomes
useful user
>> yeah it's in the input so I mentioned
the the the um the prompt for the llm uh
the prompt is basically
given this persona's interest, goals,
characteristics, etc. expand the query
that was this like from the input
extract the filters all these things.
So, um it uses the the the personal
characteristics including the behavior.
So, if you refine the behavior, you are
going to impact what the LM is going to
do.
>> Thank you.
>> Any more questions?
>> Yes.
How do you know that
some sort of
>> the question?
>> Um
>> seems pretty fine. Question is that how
do you know that those are the right for
different data set? How do you know that
the the value of the filter exists or
how we do know that the fil
>> the filter itself exists? Um yeah that's
part of what you have already answered I
think earlier. Um here in the demo in
itself we so we predefine what we would
like to filter against. So we don't
provide like the index in itself it has
let's say 10 20 fields we tell the LLM
hey you can only generate filters that
are related to these specific fields. is
like how do we filters
for
>> how do we know that the right filters
for the recommendation?
>> Yeah. For example, like how do you come
up with
one of
>> u um I think this is yeah I think this
highly depends on the business like you
mean uh how do we know which filter to
apply based on that query?
>> Okay.
Um,
>> you mean the Yeah. So that's for the not
not for the query. That's right. For the
for for the catalog of your items, you
need to be able to to to to label your
items with the proper results. Is that
the question? Yeah.
So I mean it's always like tuning the
relevancy especially like in e-commerce
it's always like a back and forth
between tuning the crow itself and
tuning what you add as metadata to your
catalog. Uh here we didn't talk at all
about that part but this is definitely
something that uh especially in
e-commerce you you have to do a lot.
That's why most of the time you change
things and then you reindex your data um
every day or every week because you tune
things in your catalog. Uh you don't
only tune the the query. So this is
something that's maybe not only specific
to that but that's yeah e-commerce is
known to have this kind of of
approaches.
More generically this is not something
that we see very frequently. Um
but yeah this is something that that was
not addressed by by auto here. So
>> can I add to that?
>> Yeah please.
>> So I do have a customer where they
looked at their 100 last 100 queries and
they found most of their search terms
were brand like Nike black shoes or they
are perfection
branding in the itself. So they
identified brand as a filter and very
expansion they applied the the brand as
a so again is doing the job of
identifying that DR is a brand and Nike
is a brand but then once you do that
then we can
>> but I think color is a very color and
gender is a very common
>> yeah I think it depends on the business
like it's very tailored to the business
like for example podcast online
application will apply by different
filters than an e-commerce um business.
Um highly it's highly subjective to
analy
>> Yes. Yeah. That's
an
>> Yeah. Yeah. Yeah. Yeah. That's
definitely part of the uh the headquis.
>> Yeah.
is contacting
part of such as
>> no that's that's on the LLM level that
we have in the background. So yeah it's
the agent that decides basically um how
to enrich the query uh what context to
use and so on.
>> Sure.
>> Thank you so much. Um I think we'll be
around if there is any further
questions.
Have a great day. Bye.
