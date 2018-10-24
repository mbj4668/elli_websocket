# elli_websocket

*A WebSocket handler for [elli][]*

[![Hex.pm][hex badge]][hex package]
[![Erlang][erlang badge]][erlang downloads]
[![Travis CI][travis badge]][travis builds]
[![Coverage Status][coveralls badge]][coveralls link]
[![Apache License][license badge]](LICENSE)

[elli]: https://github.com/elli-lib/elli
[hex badge]: https://img.shields.io/hexpm/v/elli_websocket.svg
[hex package]: https://hex.pm/packages/elli_websocket
[erlang badge]: https://img.shields.io/badge/erlang-%E2%89%A518.0-red.svg
[erlang downloads]: http://www.erlang.org/downloads
[travis builds]: https://travis-ci.org/elli-lib/elli_websocket
[travis badge]: https://travis-ci.org/elli-lib/elli_websocket.svg
[coveralls badge]: https://coveralls.io/repos/github/elli-lib/elli_websocket/badge.svg?branch=develop
[coveralls link]: https://coveralls.io/github/elli-lib/elli_websocket?branch=develop
[license badge]: https://img.shields.io/hexpm/l/elli_websocket.svg


## Installation

You can add `elli_websocket` to your application by adding it as a dependency alongside [elli][].

```erlang
{deps, [
  {elli, "3.1.0"},
  {elli_websocket, "0.1.1"}
]}.
```


## Examples

### Callback Module

See [elli_example_websocket.erl](./src/elli_example_websocket.erl) for details.

```erlang
-module(elli_echo_websocket_handler).

-export([websocket_init/1,
         websocket_handle/3,
         websocket_info/3,
         websocket_handle_event/3]).


websocket_init(Req, Opts) ->
    State = undefined,
    {ok, [], State}.


websocket_handle(_Req, {text, Data}, State) ->
    {reply, {text, Data}, State};
websocket_handle(_Req, {binary, Data}, State) ->
    {reply, {binary, Data}, State};
websocket_handle(_Req, _Frame, State) ->
    {ok, State}.


websocket_info(Req, Message, State) ->
    {ok, State}.


websocket_handle_event(Name, EventArgs, State) ->
    ok.
```


### Upgrading to a WebSocket Connection

```erlang
-module(elli_echo_websocket).

-export([init/2, handle/2, handle_event/3]).

-include_lib("elli/include/elli.hrl").

-behaviour(elli_handler).


init(Req, Args) ->
    Method = case elli_request:get_header(<<"Upgrade">>, Req) of
        <<"websocket">> ->
            init_ws(elli_request:path(Req), Req, Args);
        _ ->
            ignore
    end.


handle(Req, Args) ->
    Method = case elli_request:get_header(<<"Upgrade">>, Req) of
        <<"websocket">> ->
            websocket;
        _ ->
            elli_request:method(Req)
    end,
    handle(Method, elli_request:path(Req), Req, Args).


handle_event(_Event, _Data, _Args) ->
    ok.


%%
%% Helpers
%%

init_ws([<<"echo_websocket">>], _Req, _Args) ->
    {ok, handover};
init_ws(_, _, _) ->
    ignore.


handle('websocket', [<<"echo_websocket">>], Req, Args) ->
    %% Upgrade to a websocket connection.
    elli_websocket:upgrade(Req, Args),

    %% websocket is closed.
    {close, <<>>};
handle('GET', [<<"echo_websocket">>], _Req, _Args) ->
    %% We got a normal request, request was not upgraded.
    {200, [], <<"Use an upgrade request">>};
handle(_,_,_,_) ->
    ignore.
```
