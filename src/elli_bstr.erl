%% @author Maas-Maarten Zeeman <mmzeeman@xs4all.nl>
%% @copyright 2013, Maas-Maarten Zeeman; 2018, elli-lib team
%%
%% @doc Binary String Helper Functions
%% @end
%%
%% Copyright 2013 Maas-Maarten Zeeman
%% Copyright 2018 elli-lib team
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(elli_bstr).

-export([
         to_lower/1,
         is_equal_ci/2,
         lchr/1,

         trim_left/1,
         trim_right/1,
         trim/1
        ]).


-define(IS_WS(C), (C =:= $\s orelse C=:=$\t orelse C=:= $\r orelse C =:= $\n)).


%%
%% Types
%%

-type ascii_char() :: 0..127.


%%
%% Functions
%%

%% @doc Convert ascii Bin to lowercase
-spec to_lower(Bin :: binary()) -> binary().
to_lower(Bin) ->
    << <<(lchr(C))>> || <<C>> <= Bin >>.


%% @doc Compare two binary values.
%% Return true iff they are equal by a caseless compare.
-spec is_equal_ci(binary(), binary()) -> boolean().
is_equal_ci(Bin, Bin) ->
    %% Quick match with an Erlang pattern match
    true;
is_equal_ci(Bin1, Bin2) when is_binary(Bin1) andalso is_binary(Bin2)
                             andalso size(Bin1) =:= size(Bin2) ->
    %% Both binaries are the same length, do a good check
    equal_ci(Bin1, Bin2);
is_equal_ci(_, _) ->
    false.


%% @doc convert character to lowercase.
-spec lchr(ascii_char()) -> ascii_char().
lchr($A) -> $a;
lchr($B) -> $b;
lchr($C) -> $c;
lchr($D) -> $d;
lchr($E) -> $e;
lchr($F) -> $f;
lchr($G) -> $g;
lchr($H) -> $h;
lchr($I) -> $i;
lchr($J) -> $j;
lchr($K) -> $k;
lchr($L) -> $l;
lchr($M) -> $m;
lchr($N) -> $n;
lchr($O) -> $o;
lchr($P) -> $p;
lchr($Q) -> $q;
lchr($R) -> $r;
lchr($S) -> $s;
lchr($T) -> $t;
lchr($U) -> $u;
lchr($V) -> $v;
lchr($W) -> $w;
lchr($X) -> $x;
lchr($Y) -> $y;
lchr($Z) -> $z;
lchr(Chr) -> Chr.


%% @doc Remove leading whitespace from Bin
-spec trim_left(binary()) -> binary().
trim_left(<<C, Rest/binary>>) when ?IS_WS(C) ->
    trim_left(Rest);
trim_left(Bin) ->
    Bin.


%% @doc Remove trailing whitespace from Bin
-spec trim_right(binary()) -> binary().
trim_right(<<>>) -> <<>>;
trim_right(Bin) ->
    case binary:last(Bin) of
        C when ?IS_WS(C) ->
            trim_right(binary:part(Bin, {0, size(Bin)-1}));
        _ ->
            Bin
    end.


%% @doc Remove leading and trailing whitespace.
-spec trim(binary()) -> binary().
trim(Bin) ->
    trim_left(trim_right(Bin)).


%%
%% Helpers
%%

-spec equal_ci(binary(), binary()) -> boolean().
equal_ci(<<>>, <<>>) ->
    true;
equal_ci(<<C, Rest1/binary>>, <<C, Rest2/binary>>) ->
    equal_ci(Rest1, Rest2);
equal_ci(<<C1, Rest1/binary>>, <<C2, Rest2/binary>>) ->
    case lchr(C1) =:= lchr(C2) of
        true ->
            equal_ci(Rest1, Rest2);
        false ->
            false
    end.
