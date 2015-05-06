-module(tnc_page_handler).
-author("shree@ybrantdigital.com").

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
	Url = "http://api.contentapi.ws/videos?channel=world_news&limit=1&skip=11&format=long",
	% io:format("movies url: ~p~n",[Url]), 
	{ok, "200", _, Response_mlb} = ibrowse:send_req(Url,[],get,[],[]),
	ResponseParams_mlb = jsx:decode(list_to_binary(Response_mlb)),	
	[Params] = proplists:get_value(<<"articles">>, ResponseParams_mlb),

	Video_Url = "http://api.contentapi.ws/videos?channel=world_news&limit=4&skip=2&format=long",
	{ok, "200", _, Response_videos} = ibrowse:send_req(Video_Url,[],get,[],[]),
	ResponseParams_videos = jsx:decode(list_to_binary(Response_videos)),	
	VideoParams = proplists:get_value(<<"articles">>, ResponseParams_videos),

	Latest_Video_Url = "http://api.contentapi.ws/videos?channel=world_news&limit=10&skip=6&format=short",
	{ok, "200", _, Response_latest_videos} = ibrowse:send_req(Latest_Video_Url,[],get,[],[]),
	ResponseParams_latest_videos = jsx:decode(list_to_binary(Response_latest_videos)),	
	LatestVideoParams = proplists:get_value(<<"articles">>, ResponseParams_latest_videos),
	
	{ok, Body} = tnc_dtl:render([{<<"videoParam">>,Params},{<<"videos">>,VideoParams},{<<"latestvideos">>,LatestVideoParams}]),
    {Body, Req, State}
.