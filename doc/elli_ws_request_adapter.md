

# Module elli_ws_request_adapter #
* [Description](#description)
* [Data Types](#types)
* [Function Index](#index)
* [Function Details](#functions)

Elli WebSocket Request Adapter.

Copyright (c) 2013, Maas-Maarten Zeeman; 2018, elli-lib team

__Authors:__ Maas-Maarten Zeeman ([`mmzeeman@xs4all.nl`](mailto:mmzeeman@xs4all.nl)).

<a name="types"></a>

## Data Types ##




### <a name="type-req">req()</a> ###


<pre><code>
req() = #req_adapter{req = <a href="http://raw.github.com/elli-lib/elli/develop/doc/elli.md#type-req">elli:req()</a>, resp_compress = boolean(), resp_headers = <a href="http://raw.github.com/elli-lib/elli/develop/doc/elli.md#type-headers">elli:headers()</a>, sent_upgrade_reply = boolean(), websocket_version = undefined | integer(), websocket_compress = boolean()}
</code></pre>

<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#ensure_response-2">ensure_response/2</a></td><td>Mimics cowboy_req:ensure_response/2.</td></tr><tr><td valign="top"><a href="#get-2">get/2</a></td><td>Mimics cowboy_req:get/2.</td></tr><tr><td valign="top"><a href="#header-2">header/2</a></td><td>Mimics cowboy_req:header/2.</td></tr><tr><td valign="top"><a href="#init-2">init/2</a></td><td>Initialize the request helper.</td></tr><tr><td valign="top"><a href="#maybe_reply-2">maybe_reply/2</a></td><td>Mimics cowboy_req:maybe_reply/2.</td></tr><tr><td valign="top"><a href="#messages-1">messages/1</a></td><td>Atoms used to identify messages in {active, once | true} mode.</td></tr><tr><td valign="top"><a href="#parse_header-2">parse_header/2</a></td><td>Mimics cowboy_req:parse_header/3 {ok, ParsedHeaders, Req}.</td></tr><tr><td valign="top"><a href="#set_meta-3">set_meta/3</a></td><td>Mimics cowboy_req:set_meta/3.</td></tr><tr><td valign="top"><a href="#upgrade_reply-3">upgrade_reply/3</a></td><td></td></tr><tr><td valign="top"><a href="#websocket_handler_callback-5">websocket_handler_callback/5</a></td><td>Calls websocket_info en websocket_handle callbacks.</td></tr><tr><td valign="top"><a href="#websocket_handler_handle_event-5">websocket_handler_handle_event/5</a></td><td>Report an event...</td></tr><tr><td valign="top"><a href="#websocket_handler_init-3">websocket_handler_init/3</a></td><td>Call the websocket_init callback of the websocket handler.</td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="ensure_response-2"></a>

### ensure_response/2 ###

<pre><code>
ensure_response(ReqAdapter::<a href="#type-req">req()</a>, X2::400) -&gt; ok
</code></pre>
<br />

Mimics cowboy_req:ensure_response/2

<a name="get-2"></a>

### get/2 ###

<pre><code>
get(L::atom() | list(), ReqAdapter::<a href="#type-req">req()</a>) -&gt; any() | list()
</code></pre>
<br />

Mimics cowboy_req:get/2

<a name="header-2"></a>

### header/2 ###

`header(X1, Req_adapter) -> any()`

Mimics cowboy_req:header/2

<a name="init-2"></a>

### init/2 ###

<pre><code>
init(Req::<a href="http://raw.github.com/elli-lib/elli/develop/doc/elli.md#type-req">elli:req()</a>, RespCompress::boolean()) -&gt; <a href="#type-req">req()</a>
</code></pre>
<br />

Initialize the request helper

<a name="maybe_reply-2"></a>

### maybe_reply/2 ###

<pre><code>
maybe_reply(X1::400, ReqAdapter::<a href="#type-req">req()</a>) -&gt; ok
</code></pre>
<br />

Mimics cowboy_req:maybe_reply/2

<a name="messages-1"></a>

### messages/1 ###

<pre><code>
messages(RA::<a href="#type-req">req()</a>) -&gt; {tcp, tcp_closed, tcp_error} | {ssl, ssl_closed, ssl_error}
</code></pre>
<br />

Atoms used to identify messages in {active, once | true} mode.

<a name="parse_header-2"></a>

### parse_header/2 ###

`parse_header(X1, Req_adapter) -> any()`

Mimics cowboy_req:parse_header/3 {ok, ParsedHeaders, Req}

<a name="set_meta-3"></a>

### set_meta/3 ###

`set_meta(X1, Version, ReqAdapter) -> any()`

Mimics cowboy_req:set_meta/3

<a name="upgrade_reply-3"></a>

### upgrade_reply/3 ###

<pre><code>
upgrade_reply(X1::101, Headers::<a href="http://raw.github.com/elli-lib/elli/develop/doc/elli.md#type-headers">elli:headers()</a>, Req_adapter::<a href="#type-req">req()</a>) -&gt; {ok, <a href="#type-req">req()</a>}
</code></pre>
<br />

<a name="websocket_handler_callback-5"></a>

### websocket_handler_callback/5 ###

<pre><code>
websocket_handler_callback(Req, Handler, Callback, Message, HandlerState) -&gt; Result
</code></pre>

<ul class="definitions"><li><code>Req = <a href="#type-req">req()</a></code></li><li><code>Handler = module()</code></li><li><code>Callback = websocket_info | websocket_handle</code></li><li><code>Message = any()</code></li><li><code>HandlerState = any()</code></li><li><code>Result = {ok, <a href="#type-req">req()</a>, any()} | {ok, <a href="#type-req">req()</a>, any(), hibernate} | {reply, <a href="elli_ws_protocol.md#type-frame">elli_ws_protocol:frame()</a> | [<a href="elli_ws_protocol.md#type-frame">elli_ws_protocol:frame()</a>], <a href="#type-req">req()</a>, any()} | {reply, <a href="elli_ws_protocol.md#type-frame">elli_ws_protocol:frame()</a> | [<a href="elli_ws_protocol.md#type-frame">elli_ws_protocol:frame()</a>], <a href="#type-req">req()</a>, any(), hibernate} | {shutdown, <a href="#type-req">req()</a>, any()}</code></li></ul>

Calls websocket_info en websocket_handle callbacks.

<a name="websocket_handler_handle_event-5"></a>

### websocket_handler_handle_event/5 ###

<pre><code>
websocket_handler_handle_event(Req_adapter::<a href="#type-req">req()</a>, Handler::module(), Name::atom(), EventArgs::list(), HandlerOpts::any()) -&gt; ok
</code></pre>
<br />

Report an event...

<a name="websocket_handler_init-3"></a>

### websocket_handler_init/3 ###

<pre><code>
websocket_handler_init(Req_adapter::<a href="#type-req">req()</a>, Handler::module(), HandlerState::any()) -&gt; {shutdown, <a href="#type-req">req()</a>} | {ok, <a href="#type-req">req()</a>, any()} | {ok, <a href="#type-req">req()</a>, any(), hibernate} | {ok, <a href="#type-req">req()</a>, any(), Timeout::non_neg_integer()} | {ok, <a href="#type-req">req()</a>, any(), Timeout::non_neg_integer(), hibernate}
</code></pre>
<br />

Call the websocket_init callback of the websocket handler.

calls websocket_init(Req, HandlerOpts) ->
{ok, Headers, HandlerState}
We can upgrade, headers are added to the upgrade response.
{ok, Headers, hibernate, HandlerState}
We can upgrade, but this process will hibernate, headers
are added to the upgrade response
{ok, Headers, Timeout, HandlerState}
We can upgrade, we will timout, headers are added to the upgrade respose.
{ok, Headers, hibernate, Timeout, HandlerState}
We can upgrade, set a timeout and hibernate.
Headers are added to the response.
{shutdown, Headers}
We can't upgrade, a bad request response will be sent to the client.

