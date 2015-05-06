-module(starstyle_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	Dispatch = cowboy_router:compile([
		{'_',[
                {"/", home_page_handler, []},
                {"/api/lateststories/channel", channel_lateststories_handler, []},
                {"/api/latestvideos/channel", channel_latestvideos_handler, []},
                {"/api/latestpictures/channel", channel_latestpictures_handler, []},
                {"/api/latestinterviews/channel",channel_latestinterviews_handler,[]},
                {"/api/latestinterviewslist/channel",channel_latestinterviews_list_handler,[]},                
                {"/news/:id", news_handler, []},
                {"/interviews/:id", interviews_handler, []},
                {"/videos/:id", videos_handler, []},
                {"/playvideo/:id", play_video_handler, []},
                {"/morenews", all_news_handler, []},
                {"/music", gallery_handler, []},
                {"/morevideos", all_videos_handler, []},
                {"/morecelebrities", all_interviews_handler, []},
                {"/api/news/count", news_count_handler, []},
                {"/api/videos/count", videos_count_handler, []},
                {"/api/interviews/count", interviews_count_handler, []},
                {"/termsandconditions", tnc_page_handler, []},
                {"/api/interviews/limit_skip", interviews_limit_skip_handler, []},
                %%
                %% Release Routes
                %%
    			{"/css/[...]", cowboy_static, {priv_dir, starstyle, "static/css"}},
    			{"/images/[...]", cowboy_static, {priv_dir, starstyle, "static/images"}},
    			{"/js/[...]", cowboy_static, {priv_dir, starstyle, "static/js"}},
				{"/fonts/[...]", cowboy_static, {priv_dir, starstyle, "static/fonts"}}
				% % %%
				%% Dev Routes
				%%
			 %    {"/css/[...]", cowboy_static, {dir, "priv/static/css"}},
    %             {"/images/[...]", cowboy_static, {dir, "priv/static/images"}},
    %             {"/js/[...]", cowboy_static, {dir,"priv/static/js"}},
				% {"/fonts/[...]", cowboy_static, {dir, "priv/static/fonts"}}
        ]}		
	]), 
    

	{ok, _} = cowboy:start_http(http,100, [{port, 9913}],[{env, [{dispatch, Dispatch}]},
                                                          {onresponse, fun error_hook_responder:respond/4 },
                                                          {onrequest, fun request_hook_responder:set_cors/1}
                                                          
              ]),
    starstyle_sup:start_link().

stop(_State) ->
    ok.
