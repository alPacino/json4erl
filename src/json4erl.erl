%%% @author Nikolay Mavrenkov <koluch@koluch.ru>
%%% @copyright (C) 2013, Nikolay Mavrenkov
%%% @doc
%%%
%%% @end
%%% Created :  6 Oct 2013 by Nikolay Mavrenkov <koluch@koluch.ru>

-module(json4erl).
-export([parse_file/1,parse_file/2, parse_binary/1, parse_binary/2]).

-define(DEFAULT_OPTIONS, [{encoding,utf8}]).

%% Interface

parse_file(FileName) -> parse_file(FileName, ?DEFAULT_OPTIONS).
parse_file(FileName, Options) ->
    {ok, Binary} = file:read_file(FileName),
    parse_binary(Binary, Options).

parse_binary(Binary) -> parse_binary(Binary, ?DEFAULT_OPTIONS).
parse_binary(Binary, Options) -> 
    call_encoding_module(Binary,  proplists:get_value(encoding, Options)).

%% Internal functions
call_encoding_module(Binary, utf8) ->
    {Parsed, {_RestBin, _Line, _Column}} = json4erl_parser_utf8:parse({0,0}, Binary, next_el, nil),
    Parsed.

