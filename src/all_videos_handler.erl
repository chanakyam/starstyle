-module(all_videos_handler).
-author("chanakyam@koderoom.com").
-include("includes.hrl").
-export([init/3]).

-export([content_types_provided/2]).
-export([welcome/2]).
-export([terminate/3]).

%% Init
init(_Transport, _Req, []) ->
	{upgrade, protocol, cowboy_rest}.

%% Callbacks
content_types_provided(Req, State) ->
	{[		
		{<<"text/html">>, welcome}	
	], Req, State}.

terminate(_Reason, _Req, _State) ->
	ok.

%% API
welcome(Req, State) ->
	% {PageBinary, _} = cowboy_req:qs_val(<<"p">>, Req),
	% PageNum = list_to_integer(binary_to_list(PageBinary)),
	% SkipItems = (PageNum-1) * ?NEWS_PER_PAGE,
	% {CategoryBinary, _} = cowboy_req:qs_val(<<"c">>, Req),
	% Category = binary_to_list(CategoryBinary),
	
	Url = "http://api.contentapi.ws/videos?channel=world_news&limit=1&skip=7&format=long",
	% io:format("movies url: ~p~n",[Url]), 
	{ok, "200", _, Response_mlb} = ibrowse:send_req(Url,[],get,[],[]),
	ResponseParams_mlb = jsx:decode(list_to_binary(Response_mlb)),	
	[Params] = proplists:get_value(<<"articles">>, ResponseParams_mlb),

	Video_Url = "http://api.contentapi.ws/videos?channel=world_news&limit=4&skip=2&format=long",
	{ok, "200", _, Response_videos} = ibrowse:send_req(Video_Url,[],get,[],[]),
	ResponseParams_videos = jsx:decode(list_to_binary(Response_videos)),	
	VideoParams = proplists:get_value(<<"articles">>, ResponseParams_videos),

	% Most_Popular_Url = "http://api.contentapi.ws/news?channel=entertainment_film&limit=1&skip=0&format=short",
	Most_Popular_Url = "http://contentapi.ws:5984/contentapi_text_maxcdn/_design/yb_entertainment_film/_view/by_id_title_desc_thumb_date?descending=true&limit=1&skip=0",
	{ok, "200", _, Response_Most_Popular} = ibrowse:send_req(Most_Popular_Url,[],get,[],[]),
	ResponseParams_Most_Popular = jsx:decode(list_to_binary(Response_Most_Popular)),	
	[MostPopularParams] = proplists:get_value(<<"rows">>, ResponseParams_Most_Popular),

	% Gallery_Url = "http://api.contentapi.ws/news?channel=image_galleries&limit=4&skip=0&format=short",
	% {ok, "200", _, Response_Gallery} = ibrowse:send_req(Gallery_Url,[],get,[],[]),
	% ResponseParams_Gallery = jsx:decode(list_to_binary(Response_Gallery)),	
	% GalleryParams = proplists:get_value(<<"articles">>, ResponseParams_Gallery),

	% Music_Url = "http://api.contentapi.ws/news?channel=entertainment_music&limit=1&skip=0&format=short",
	Music_Url = "http://contentapi.ws:5984/contentapi_text_maxcdn/_design/yb_entertainment_music/_view/short?descending=true&limit=1",
	{ok, "200", _, Response_Music} = ibrowse:send_req(Music_Url,[],get,[],[]),
	ResponseParams_Music = jsx:decode(list_to_binary(Response_Music)),	
	MusicParams = proplists:get_value(<<"rows">>, ResponseParams_Music),

	% Url_all_news = string:concat("http://api.contentapi.ws/videos?channel=world_news&limit=16&format=short&skip=", integer_to_list(SkipItems)),
	Url_all_news = "http://api.contentapi.ws/videos?channel=world_news&limit=16&format=short&skip=0",
	% io:format("all news : ~p~n",[Url_all_news]),
	{ok, "200", _, ResponseAllNews} = ibrowse:send_req(Url_all_news,[],get,[],[]),
	ResponseParams = jsx:decode(list_to_binary(ResponseAllNews)),
	ResAllNews = proplists:get_value(<<"articles">>, ResponseParams),

	% Url_all_news_int = "http://api.contentapi.ws/news?channel=entertainment_people&limit=5&format=short&skip=0",
	Url_all_news_int = "http://contentapi.ws:5984/contentapi_text_maxcdn/_design/yb_entertainment_people/_view/short?descending=true&limit=5",
	% io:format("all news : ~p~n",[Url_all_news]),
	{ok, "200", _, ResponseAllNewsInt} = ibrowse:send_req(Url_all_news_int,[],get,[],[]),
	ResponseParamsInt = jsx:decode(list_to_binary(ResponseAllNewsInt)),
	ResAllNewsInt = proplists:get_value(<<"rows">>, ResponseParamsInt),

	{ok, Body} = all_videos_paginated_dtl:render([{<<"videoParam">>,Params},{<<"allnews">>,ResAllNews},{<<"mostpopular">>,MostPopularParams},{<<"videos">>,VideoParams},{<<"music">>,MusicParams},{<<"latestints">>,ResAllNewsInt}]),
    {Body, Req, State}.




