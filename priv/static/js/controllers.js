var app = angular.module('starStyle', ['ui.bootstrap']);

app.factory('starStyleHomePageService', function ($http) {
	return {		

		getChannelPictures: function (category, count, skip) {
			return $http.get('/api/lateststories/channel?c=' + category + '&l=' + count + '&skip=' + skip).then(function (result) {
				// return result.data.rows;
				return result.data.articles;
			});
		},

		getChannelVideos: function (category, count, skip) {
			return $http.get('/api/latestvideos/channel?c=' + category + '&l=' + count + '&skip=' + skip).then(function (result) {
				// return result.data.rows;
				return result.data.articles;
			});
		},

		getChannelGallery: function (category, count, skip) {
			return $http.get('/api/latestpictures/channel?c=' + category + '&l=' + count + '&skip=' + skip).then(function (result) {
				// return result.data.rows;
				return result.data.articles;
			});
		},
		

		getChannelInterviews: function (category, count, skip) {
			return $http.get('/api/latestinterviews/channel?c=' + category + '&l=' + count + '&skip=' + skip).then(function (result) {
				// return result.data.rows;
				return result.data.articles;
			});
		}
	};
});
// flowplayer-flash factory
 app.factory("flowplayer", function(){
 	return flowplayer;
 });


app.controller('StarstyleHome', function ($scope, starStyleHomePageService) {
 	var video = "http://video.contentapi.ws/"+$('#video_val').val() 	
 	// start of code for generating cb,pagetit,pageurl
 	var vastURI = 'http://vast.optimatic.com/vast/getVast.aspx?id=m0713sn36r&zone=vpaidtag&pageURL=[INSERT_PAGE_URL]&pageTitle=[INSERT_PAGE_TITLE]&cb=[CACHE_BUSTER]';
	function updateURL(vastURI){
	// Generate a huge random number
	var ord=Math.random(), protocol, host, port, path, pageUrl, updatedURI;
	var parsedFragments = parseUri(vastURI);
	ord = ord * 10000000000000000000;
	// Protocol of VAST URI
	protocol = parsedFragments.protocol;
	// VAST URI hostname
	host = parsedFragments.host;
	// VAST URI Path
	path = parsedFragments.path;
	//VAST Page Url
	pageUrl = parsedFragments.queryKey.pageUrl
	var fragmentString ='';
	//Updated URI
	for(var key in parsedFragments.queryKey){//console.log("abhii");console.log();
		// For Cache buster add a large random number
		if(key == 'cb'){
			fragmentString = fragmentString + key + '=' + ord + '&';	
		}
		// for referring Page URL, get the current document URL and encode the URI
		else if(key == 'pageURL'){
			var currentUrl = document.URL;
			//var currentUrl = "http://test.com";
			fragmentString = fragmentString + key + '=' + currentUrl + '&';	
		}else if(key == 'pageTitle'){
			var page_title=document.title;
			fragmentString = fragmentString + key + '=' + page_title + '&';	
		}
		else{
			fragmentString = fragmentString + key + '=' + parsedFragments.queryKey[key] + '&';
		}
		
	}

	updatedURI = protocol + '://' + host + path + '?' + fragmentString ;
	
	// Remove the trailing & and return the updated URL
	return updatedURI.slice(0,-1);
	}

	// Parse URI to get qeury string like cb for cache buster and pageurl
	function parseUri (str) {
		var	o   = parseUri.options,
			m   = o.parser[o.strictMode ? "strict" : "loose"].exec(str),
			uri = {},
			i   = 14;

		while (i--) uri[o.key[i]] = m[i] || "";

		uri[o.q.name] = {};
		uri[o.key[12]].replace(o.q.parser, function ($0, $1, $2) {
			if ($1) uri[o.q.name][$1] = $2;
		});

		return uri;
	};

	parseUri.options = {
		strictMode: false,
		key: ["source","protocol","authority","userInfo","user","password","host","port","relative","path","directory","file","query","anchor"],
		q:   {
			name:   "queryKey",
			parser: /(?:^|&)([^&=]*)=?([^&]*)/g
		},
		parser: {
			strict: /^(?:([^:\/?#]+):)?(?:\/\/((?:(([^:@]*)(?::([^:@]*))?)?@)?([^:\/?#]*)(?::(\d*))?))?((((?:[^?#\/]*\/)*)([^?#]*))(?:\?([^#]*))?(?:#(.*))?)/,
			loose:  /^(?:(?![^:@]+:[^:@\/]*@)([^:\/?#.]+):)?(?:\/\/)?((?:(([^:@]*)(?::([^:@]*))?)?@)?([^:\/?#]*)(?::(\d*))?)(((\/(?:[^?#](?![^?#\/]*\.[^?#\/.]+(?:[?#]|$)))*\/?)?([^?#\/]*))(?:\?([^#]*))?(?:#(.*))?)/
		}
	};
	// end of code for generating cb,pagetit,pageurl
	$scope.adVidoe = function(){
		$(document).ready(function() {
			jwplayer('trailor').setup({
                  "flashplayer": "http://player.longtailvideo.com/player.swf",
                  "playlist": [
                    {
                      "file": video
                    }
                  ],
                  "width": '100%',
                  "height": '100%',
                  stretching: "exactfit",
                  skin: "http://content.longtailvideo.com/skins/glow/glow.zip",
                  autostart: true,
                  "controlbar": {
                    "position": "bottom"
                  },
                  "plugins": {
                  	 "autoPlay": true,
                    "ova-jw": {
                      "ads": {
                        "schedule": [
                          {
                            "position": "pre-roll",
                            "tag": updateURL(vastURI)
                            //"tag": "http://vast.optimatic.com/vast/getVast.aspx?id=w984i078l984&zone=vpaidtag&pageURL=[INSERT_PAGE_URL]&pageTitle=[INSERT_PAGE_TITLE]&cb=[CACHE_BUSTER]"
                          }
                        ]
                      },
                      "debug": {
                        "levels": "none"
                      }
                    }
                  }
                });
		})
	
	};
	//the clean and simple way
	$scope.latestStories    = starStyleHomePageService.getChannelPictures('starstyle_view',5,0);
	$scope.latestVideos     = starStyleHomePageService.getChannelVideos('full_composite_article',4,1);	
	$scope.latestPictures   = starStyleHomePageService.getChannelGallery('image_gallery_view',10,0);
	$scope.latestInterviews = starStyleHomePageService.getChannelInterviews('interviews_view',12,0);

});




