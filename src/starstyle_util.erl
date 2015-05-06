-module(starstyle_util).
-include("includes.hrl").

-export([newsdb_url/0,
		videosdb_url/0,		 		  
		 thumb_title_count/3,
		 thumb_title_video_count/3,
		 thumb_title_pircture_count/3,
		 photo_gallery_list/1,
		 thumb_title_interview_count/3,
		 news_top_text_news_by_category_with_limit_and_skip/3,
		 videos_top_text_news_by_category_with_limit_and_skip/3,
		 interviews_top_text_news_by_category_with_limit_and_skip/3,
		 news_count/1,
		 videos_count/1,
		 interviews_count/1,
		 interviews_list_count/1,
		 news_item_url/1,
		 interviews_item_url/1,
		 videos_item_url/1,
		 play_video_item_url/1,
		 more_interviews/2
		]).

newsdb_url() ->
	string:concat(?COUCHDB_URL, ?COUCHDB_TEXT_GRAPHICS)
.
videosdb_url() ->
	string:concat(?COUCHDB_URL, ?COUCHDB_TEXT_GRAPHICS_VIDEOS)
.
thumb_title_count(Category, Limit, Skip) ->
	%http://couchdb.speakglobally.net/wildridge_latest/_design/slideshow/_view/us_nba?descending=true&limit=2
	Url1 = string:concat(?MODULE:newsdb_url(),"_design/starstyle_design/_view/"),
	Url2 = string:concat(Url1, Category),
	Url3 = string:concat(Url2, "?descending=true&limit="),
	Url4 = string:concat(Url3, Limit),
	Url5 = string:concat(Url4, "&skip="),
	string:concat(Url5, Skip)
.
thumb_title_video_count(Category, Limit, Skip) ->
	%http://couchdb.speakglobally.net/wildridge_latest/_design/slideshow/_view/us_nba?descending=true&limit=2
	Url1 = string:concat(?MODULE:videosdb_url(),"_design/video_movies/_view/"),
	Url2 = string:concat(Url1, Category),
	Url3 = string:concat(Url2, "?descending=true&limit="),
	Url4 = string:concat(Url3, Limit),
	Url5 = string:concat(Url4, "&skip="),
	string:concat(Url5, Skip)
.
thumb_title_pircture_count(Category, Limit, Skip) ->
	%http://couchdb.speakglobally.net/wildridge_latest/_design/slideshow/_view/us_nba?descending=true&limit=2
	Url1 = string:concat(?MODULE:newsdb_url(),"_design/image_gallery_design/_view/"),
	Url2 = string:concat(Url1, Category),
	Url3 = string:concat(Url2, "?descending=true&limit="),
	Url4 = string:concat(Url3, Limit),
	Url5 = string:concat(Url4, "&skip="),
	string:concat(Url5, Skip)
.
photo_gallery_list(Category) ->
	%% http://localhost:5984/reconlive/_design/get_count/_view/<category>
	Url1 = string:concat(?MODULE:newsdb_url(), "_design/image_gallery_design/_view/"),
	Url2 = string:concat(Url1, Category),	
	string:concat(Url2, "?descending=true&limit=50")
.

thumb_title_interview_count(Category, Limit, Skip) ->
	%http://couchdb.speakglobally.net/wildridge_latest/_design/slideshow/_view/us_nba?descending=true&limit=2
	Url1 = string:concat(?MODULE:newsdb_url(),"_design/interviews_design/_view/"),
	Url2 = string:concat(Url1, Category),
	Url3 = string:concat(Url2, "?descending=true&limit="),
	Url4 = string:concat(Url3, Limit),
	Url5 = string:concat(Url4, "&skip="),
	string:concat(Url5, Skip)
.
news_top_text_news_by_category_with_limit_and_skip(Category, Limit, Skip) ->
	%% http://localhost:5984/reconlive/_design/news_by_category/_view/us_news?descending=true&limit=10
	Url  = string:concat(?MODULE:newsdb_url(), "_design/starstyle_design/_view/"), 
	Url1 = string:concat(Url,Category ),	
	Url3 = string:concat(Url1, "?descending=true&limit="),
	Url4 = string:concat(Url3, Limit),
	Url5 = string:concat(Url4, "&skip="),
	string:concat(Url5, Skip)	
.
videos_top_text_news_by_category_with_limit_and_skip(Category, Limit, Skip) ->
	%% http://localhost:5984/reconlive/_design/news_by_category/_view/us_news?descending=true&limit=10
	Url  = string:concat(?MODULE:videosdb_url(), "_design/video_movies/_view/"), 
	Url1 = string:concat(Url,Category ),	
	Url3 = string:concat(Url1, "?descending=true&limit="),
	Url4 = string:concat(Url3, Limit),
	Url5 = string:concat(Url4, "&skip="),
	string:concat(Url5, Skip)	
.
interviews_top_text_news_by_category_with_limit_and_skip(Category, Limit, Skip) ->
	%% http://localhost:5984/reconlive/_design/news_by_category/_view/us_news?descending=true&limit=10
	Url  = string:concat(?MODULE:newsdb_url(), "_design/interviews_design/_view/"), 
	Url1 = string:concat(Url,Category ),	
	Url3 = string:concat(Url1, "?descending=true&limit="),
	Url4 = string:concat(Url3, Limit),
	Url5 = string:concat(Url4, "&skip="),
	string:concat(Url5, Skip)	
.

news_count(Category) ->
	%% http://localhost:5984/reconlive/_design/get_count/_view/<category>
	Url1 = string:concat(?MODULE:newsdb_url(), "_design/starstyle_design/_view/"),
	Url2 = string:concat(Url1, Category),	
	string:concat(Url2, "?descending=true&limit=1")
.
videos_count(Category) ->
	%% http://localhost:5984/reconlive/_design/get_count/_view/<category>
	Url1 = string:concat(?MODULE:videosdb_url(), "_design/video_movies/_view/"),
	Url2 = string:concat(Url1, Category),	
	string:concat(Url2, "?descending=true&limit=1")
.
interviews_count(Category) ->
	%% http://localhost:5984/reconlive/_design/get_count/_view/<category>
	Url1 = string:concat(?MODULE:newsdb_url(), "_design/interviews_design/_view/"),
	Url2 = string:concat(Url1, Category),	
	string:concat(Url2, "?descending=true&limit=1")
.
interviews_list_count(Category) ->
	%% http://localhost:5984/reconlive/_design/get_count/_view/<category>
	Url1 = string:concat(?MODULE:newsdb_url(), "_design/interviews_design/_view/"),
	Url2 = string:concat(Url1, Category),	
	string:concat(Url2, "?descending=true")
.
more_interviews(Limit, Skip) ->
	Url  = string:concat(?MODULE:newsdb_url(), "_design/interviews_design/_view/"), 
	Url1 = string:concat(Url,"interviews_view"),	
	Url3 = string:concat(Url1, "?descending=true&limit="),
	Url4 = string:concat(Url3, Limit),
	Url5 = string:concat(Url4, "&skip="),
	string:concat(Url5, Skip).

news_item_url(Id) ->
	string:concat(?MODULE:newsdb_url(),Id)
.
interviews_item_url(Id) ->
	string:concat(?MODULE:newsdb_url(),Id)
.
videos_item_url(Id) ->
	string:concat(?MODULE:videosdb_url(),Id)
.
play_video_item_url(Id) ->
	string:concat(?MODULE:videosdb_url(),Id)
.
