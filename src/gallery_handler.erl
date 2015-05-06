-module(gallery_handler).
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
	% {CategoryBinary, _} = cowboy_req:qs_val(<<"c">>, Req),
	% Category = binary_to_list(CategoryBinary),

	Url = "http://api.contentapi.ws/videos?channel=world_news&limit=1&skip=8&format=long",
 
	{ok, "200", _, Response_mlb} = ibrowse:send_req(Url,[],get,[],[]),
	ResponseParams_mlb = jsx:decode(list_to_binary(Response_mlb)),	
	[Params] = proplists:get_value(<<"articles">>, ResponseParams_mlb),

	Video_Url = "http://api.contentapi.ws/videos?channel=world_news&limit=4&skip=2&format=long",
	{ok, "200", _, Response_videos} = ibrowse:send_req(Video_Url,[],get,[],[]),
	ResponseParams_videos = jsx:decode(list_to_binary(Response_videos)),	
	VideoParams = proplists:get_value(<<"articles">>, ResponseParams_videos),

	Latest_Video_Url = "http://api.contentapi.ws/videos?channel=world_news&limit=4&skip=6&format=short",
	{ok, "200", _, Response_latest_videos} = ibrowse:send_req(Latest_Video_Url,[],get,[],[]),
	ResponseParams_latest_videos = jsx:decode(list_to_binary(Response_latest_videos)),	
	LatestVideoParams = proplists:get_value(<<"articles">>, ResponseParams_latest_videos),

	% Most_Popular_Url = "http://api.contentapi.ws/news?channel=entertainment_film&limit=1&skip=0&format=short",
	Most_Popular_Url = "http://contentapi.ws:5984/contentapi_text_maxcdn/_design/yb_entertainment_film/_view/by_id_title_desc_thumb_date?descending=true&limit=1&skip=0",
	{ok, "200", _, Response_Most_Popular} = ibrowse:send_req(Most_Popular_Url,[],get,[],[]),
	ResponseParams_Most_Popular = jsx:decode(list_to_binary(Response_Most_Popular)),	
	[MostPopularParams] = proplists:get_value(<<"rows">>, ResponseParams_Most_Popular),

	% Music_Url = "http://api.contentapi.ws/news?channel=entertainment_music&limit=1&skip=0&format=short",
	Music_Url = "http://contentapi.ws:5984/contentapi_text_maxcdn/_design/yb_entertainment_music/_view/short?descending=true&limit=1",
	{ok, "200", _, Response_Music} = ibrowse:send_req(Music_Url,[],get,[],[]),
	ResponseParams_Music = jsx:decode(list_to_binary(Response_Music)),	
	MusicParams = proplists:get_value(<<"rows">>, ResponseParams_Music),

	% Url_all_news = "http://api.contentapi.ws/news?channel=entertainment_music&limit=15&format=short&skip=0",
	Url_all_news = "http://contentapi.ws:5984/contentapi_text_maxcdn/_design/yb_entertainment_music/_view/short?descending=true&limit=15",

	{ok, "200", _, ResponseAllNews} = ibrowse:send_req(Url_all_news,[],get,[],[]),
	ResponseParams = jsx:decode(list_to_binary(ResponseAllNews)),
	ResAllNews = proplists:get_value(<<"rows">>, ResponseParams),	

	{ok, Body} = gallery_dtl:render([{<<"videoParam">>,Params},{<<"allnews">>,ResAllNews},{<<"videos">>,VideoParams},{<<"latestvideos">>,LatestVideoParams},{<<"mostpopular">>,MostPopularParams},{<<"music">>,MusicParams}]),
    {Body, Req, State}.




