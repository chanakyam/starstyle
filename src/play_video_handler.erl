-module(play_video_handler).
-author("chanakyam@koderoom.com").

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
	{[{_,Value}], Req2} = cowboy_req:bindings(Req),

	Url = "http://api.contentapi.ws/videos?channel=world_news&limit=1&skip=11&format=long",
	% io:format("movies url: ~p~n",[Url]), 
	{ok, "200", _, Response_mlb} = ibrowse:send_req(Url,[],get,[],[]),
	ResponseParams_mlb = jsx:decode(list_to_binary(Response_mlb)),	
	[Params] = proplists:get_value(<<"articles">>, ResponseParams_mlb),

	Video_Url = "http://api.contentapi.ws/videos?channel=world_news&limit=4&skip=8&format=long",
	{ok, "200", _, Response_videos} = ibrowse:send_req(Video_Url,[],get,[],[]),
	ResponseParams_videos = jsx:decode(list_to_binary(Response_videos)),	
	VideoParams = proplists:get_value(<<"articles">>, ResponseParams_videos),

	Url_news = string:concat("http://api.contentapi.ws/v?id=",binary_to_list(Value) ), 
	
	{ok, "200", _, ResponseNews} = ibrowse:send_req(Url_news,[],get,[],[]),
	ResNews = string:sub_string(ResponseNews, 1, string:len(ResponseNews) -1 ),
	ParamsNews = jsx:decode(list_to_binary(ResNews)),

	Url_all_news ="http://api.contentapi.ws/videos?channel=world_news&limit=8&format=short&skip=0",
	% io:format("all news : ~p~n",[Url_all_news]),
	{ok, "200", _, ResponseAllNews} = ibrowse:send_req(Url_all_news,[],get,[],[]),
	ResponseParams = jsx:decode(list_to_binary(ResponseAllNews)),
	ResAllNews = proplists:get_value(<<"articles">>, ResponseParams),

	% Latest_Stories_Url = "http://api.contentapi.ws/news?channel=entertainment_film&limit=10&skip=1&format=short",
	Latest_Stories_Url = "http://contentapi.ws:5984/contentapi_text_maxcdn/_design/yb_entertainment_film/_view/by_id_title_desc_thumb_date?descending=true&limit=10&skip=1",
	{ok, "200", _, Response_Latest_Stories} = ibrowse:send_req(Latest_Stories_Url,[],get,[],[]),
	ResponseParams_Latest_Stories = jsx:decode(list_to_binary(Response_Latest_Stories)),	
	LatestStoriesParams = proplists:get_value(<<"rows">>, ResponseParams_Latest_Stories),

	{ok, Body} = playvideo_dtl:render([{<<"videoParam">>,Params},{<<"newsParam">>,ParamsNews},{<<"videos">>,VideoParams},{<<"allnews">>,ResAllNews},{<<"lateststories">>,LatestStoriesParams}]),
    {Body, Req2, State}.


