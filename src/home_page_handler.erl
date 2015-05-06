-module(home_page_handler).
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
	
	Url = "http://api.contentapi.ws/videos?channel=world_news&limit=1&skip=1&format=long",
	% io:format("movies url: ~p~n",[Url]),
	{ok, "200", _, Response_mlb} = ibrowse:send_req(Url,[],get,[],[]),
	ResponseParams_mlb = jsx:decode(list_to_binary(Response_mlb)),	
	[Params] = proplists:get_value(<<"articles">>, ResponseParams_mlb),

	% Video_Url = "http://api.contentapi.ws/videos?channel=movies&limit=4&skip=2&format=long",
	Video_Url = "http://api.contentapi.ws/videos?channel=world_news&limit=4&skip=2&format=long",
	{ok, "200", _, Response_videos} = ibrowse:send_req(Video_Url,[],get,[],[]),
	ResponseParams_videos = jsx:decode(list_to_binary(Response_videos)),	
	VideoParams = proplists:get_value(<<"articles">>, ResponseParams_videos),

	% Latest_Video_Url = "http://api.contentapi.ws/videos?channel=movies&limit=4&skip=6&format=short",
	Latest_Video_Url = "http://api.contentapi.ws/videos?channel=world_news&limit=4&skip=6&format=short",
	{ok, "200", _, Response_latest_videos} = ibrowse:send_req(Latest_Video_Url,[],get,[],[]),
	ResponseParams_latest_videos = jsx:decode(list_to_binary(Response_latest_videos)),	
	LatestVideoParams = proplists:get_value(<<"articles">>, ResponseParams_latest_videos),

	% Most_Popular_Url = "http://api.contentapi.ws/news?channel=starstyle&limit=1&skip=0&format=short",
	% Most_Popular_Url = "http://api.contentapi.ws/news?channel=entertainment_film&limit=1&skip=0&format=short",
	Most_Popular_Url = "http://contentapi.ws:5984/contentapi_text_maxcdn/_design/yb_entertainment_film/_view/by_id_title_desc_thumb_date?descending=true&limit=1",
	
	{ok, "200", _, Response_Most_Popular} = ibrowse:send_req(Most_Popular_Url,[],get,[],[]),
	ResponseParams_Most_Popular = jsx:decode(list_to_binary(Response_Most_Popular)),	
	[MostPopularParams] = proplists:get_value(<<"rows">>, ResponseParams_Most_Popular),

	% Gallery_Url = "http://api.contentapi.ws/news?channel=image_galleries&limit=2&skip=0&format=short",
	% {ok, "200", _, Response_Gallery} = ibrowse:send_req(Gallery_Url,[],get,[],[]),
	% ResponseParams_Gallery = jsx:decode(list_to_binary(Response_Gallery)),	
	% GalleryParams = proplists:get_value(<<"articles">>, ResponseParams_Gallery),

	% Music_Url = "http://api.contentapi.ws/news?channel=entertainment_music&limit=1&skip=0&format=short",
	Music_Url = "http://contentapi.ws:5984/contentapi_text_maxcdn/_design/yb_entertainment_music/_view/short?descending=true&limit=1",
	{ok, "200", _, Response_Music} = ibrowse:send_req(Music_Url,[],get,[],[]),
	ResponseParams_Music = jsx:decode(list_to_binary(Response_Music)),	
	MusicParams = proplists:get_value(<<"rows">>, ResponseParams_Music),

	% Latest_Stories_Url = "http://api.contentapi.ws/news?channel=starstyle&limit=2&skip=1&format=short",
	% Latest_Stories_Url = "http://api.contentapi.ws/news?channel=entertainment_film&limit=2&skip=1&format=short",
	Latest_Stories_Url = "http://contentapi.ws:5984/contentapi_text_maxcdn/_design/yb_entertainment_film/_view/by_id_title_desc_thumb_date?descending=true&limit=2&skip=1",
	{ok, "200", _, Response_Latest_Stories} = ibrowse:send_req(Latest_Stories_Url,[],get,[],[]),
	ResponseParams_Latest_Stories = jsx:decode(list_to_binary(Response_Latest_Stories)),	
	LatestStoriesParams = proplists:get_value(<<"rows">>, ResponseParams_Latest_Stories),

	% Interviews_Url = "http://api.contentapi.ws/news?channel=interviews&limit=4&skip=0&format=short",
	Interviews_Url = "http://contentapi.ws:5984/contentapi_text_maxcdn/_design/yb_entertainment_people/_view/short?descending=true&limit=4",
	{ok, "200", _, Response_Interviews} = ibrowse:send_req(Interviews_Url,[],get,[],[]),
	ResponseParams_Interviews = jsx:decode(list_to_binary(Response_Interviews)),	
	InterviewsParams = proplists:get_value(<<"rows">>, ResponseParams_Interviews),

	{ok, Body} = index_dtl:render([{<<"videoParam">>,Params},{<<"videos">>,VideoParams},{<<"latestvideos">>,LatestVideoParams},{<<"mostpopular">>,MostPopularParams},{<<"music">>,MusicParams},{<<"lateststories">>,LatestStoriesParams},{<<"interviews">>,InterviewsParams}]),
    {Body, Req, State}.
