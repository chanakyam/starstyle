$(document).ready(function() {
  // var video = "http://video1.contentapi.ws/"+$('#video_val').val()
  var video = "http://newscdn.lycos.com/world_news/"+$('#video_val').val()
  var vastURI = 'http://vast.optimatic.com/vast/getVast.aspx?id=m0713sn36r&zone=vpaidtag&pageURL=[INSERT_PAGE_URL]&pageTitle=[INSERT_PAGE_TITLE]&cb=[CACHE_BUSTER]';  

    // is_already_paused = false;
   jwplayer("trailor").setup({
    file: video,
    startparam: "start",
    autostart:true,
    primary: "flash",
    
   "width": '100%',
   "height": '100%',
   stretching: "exactfit",
   advertising: {
        client: "vast",
        tag: updateURL(vastURI)
        // tag: "http://vast.optimatic.com/vast/getVast.aspx?id=w984i078l984&zone=vpaidtag&pageURL=[INSERT_PAGE_URL]&pageTitle=[INSERT_PAGE_TITLE]&cb=[CACHE_BUSTER]"
      },
//    events:{
//     onPlay: function() {
//       jwplayer('trailor').start();
//     },
//     onTime: function(object) {
//       if(object.position >= 10 && !is_already_paused ) {
//         jwplayer().stop(true);
//         //this.pause();
//         is_already_paused = true;
//     }
    
      

//     }
// }
  });
   
  // jwplayer('trailor').setup({
  //            "flashplayer": '/js/jwplayer.flash.swf',
  //            // "flashplayer": "http://player.longtailvideo.com/player.swf",
  //             "playlist": [
  //               {
  //                 "file": video
  //               }
  //             ],
  //             "width": '100%',
  //             "height": '100%',
  //             "stretching": "exactfit",
  //             // skin: "http://content.longtailvideo.com/skins/glow/glow.zip",
  //            "autostart": true,
  //             "controlbar": {
  //               "position": "bottom"
  //             },
  //             "plugins": {
  //                "autoPlay": true,
  //               "ova-jw": {
  //                 "ads": {
  //                   "schedule": [
  //                     {
  //                       "position": "pre-roll",
  //                       "tag": updateURL(vastURI)
  //                       //"tag": "http://vast.optimatic.com/vast/getVast.aspx?id=w984i078l984&zone=vpaidtag&pageURL=[INSERT_PAGE_URL]&pageTitle=[INSERT_PAGE_TITLE]&cb=[CACHE_BUSTER]"
  //                     }
  //                   ]
  //                 },
  //                 "debug": {
  //                   "levels": "none"
  //                 }
  //               }
  //             }
  //           });
        // var t={
        //   adWatched:false,
        // };
          
        //   jwplayer('trailor').onAdComplete(function(){
        //     t.adWatched=true;
        //   });
          
        //   jwplayer('trailor').onPlay(function(){
        //     if(t.adWatched==false){
        //       console.log('ad completed')
        //         jwplayer('trailor').stop(true);
        //         t.adWatched="none";
        //       }
        //     if(t.adWatched==true){
        //         jwplayer('trailor').stop(true);
        //         t.adWatched=false
        //       }
        //   });
          
            
        //   jwplayer('trailor').onPlaylistItem(function(){
        //     t.adWatched=false;
        //   });
})

function play_video(video,video_title,video_date) {
  $('#video_title').html(video_title);
  $('#video_date').html(video_date);

  // start of code for generating cb,pagetit,pageurl
  var vastURI = 'http://vast.optimatic.com/vast/getVast.aspx?id=m0713sn36r&zone=vpaidtag&pageURL=[INSERT_PAGE_URL]&pageTitle=[INSERT_PAGE_TITLE]&cb=[CACHE_BUSTER]';        

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
  $(document).ready(function() {
    jwplayer("trailor").setup({
    file: video,
    startparam: "start",
    autostart:true,
    primary: "flash",
    
   "width": '100%',
   "height": '100%',
   stretching: "exactfit",
   advertising: {
        client: "vast",
        tag: updateURL(vastURI)
        // tag: "http://vast.optimatic.com/vast/getVast.aspx?id=w984i078l984&zone=vpaidtag&pageURL=[INSERT_PAGE_URL]&pageTitle=[INSERT_PAGE_TITLE]&cb=[CACHE_BUSTER]"
      }
//    events:{
//     // onPlay: function() {
//     //   jwplayer('trailor').start();
//     // },
//     onTime: function(object) {
//       if(object.position >= 10 && !is_already_paused ) {
//         jwplayer().stop(true);
//         //this.pause();
//         is_already_paused = true;
//     }
    
      

//     }
// }
  });
    // jwplayer('trailor').setup({
    //             //"flashplayer": '/js/jwplayer.flash.swf',
    //             "flashplayer": "http://player.longtailvideo.com/player.swf",
    //             "playlist": [
    //               {
    //                 "file": video
    //               }
    //             ],
    //             "width": '100%',
    //             "height": '100%',
    //             stretching: "exactfit",
    //             skin: "http://content.longtailvideo.com/skins/glow/glow.zip",
    //             primary: 'html5',
    //             autostart:true,
    //             "controlbar": {
    //               "position": "bottom"
    //             },
    //             "plugins": {
    //               "ova-jw": {
    //                 "ads": {
    //                   // "companions": {
    //                   //   "regions": [
    //                   //     {
    //                   //       "id": "companion",
    //                   //       "width": 80,
    //                   //       "height": 300
    //                   //     }
    //                   //   ]
    //                   // },
    //                   "schedule": [
    //                     {
    //                       "position": "pre-roll",
    //                       "tag": updateURL(vastURI)
    //                     }
    //                   ]
    //                 },
    //                 "debug": {
    //                   "levels": "none"
    //                 }
    //               }
    //             }
    //           });
        // var t={
        //   adWatched:false,
        // };
          
        //   // jwplayer('myElement').onAdComplete(function(){
        //   //   t.adWatched=true;
        //   // });
          
        //   jwplayer('trailor').onPlay(function(){
        //     if(t.adWatched==false){
        //         jwplayer('trailor').stop(true);
        //         t.adWatched="none";
        //       }
        //     if(t.adWatched==true){
        //         jwplayer('trailor').stop(true);
        //         t.adWatched=false
        //       }
        //   });
          
            
        //   jwplayer('trailor').onPlaylistItem(function(){
        //     t.adWatched=false;
        //   });
  })
  
}

function updateURL(vastURI) {
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
  for(var key in parsedFragments.queryKey){
    // For Cache buster add a large random number
    if(key == 'cb'){
      fragmentString = fragmentString + key + '=' + ord + '&';  
    }
    // for referring Page URL, get the current document URL and encode the URI
    else if(key == 'pageURL'){
      var currentUrl = document.URL;
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
    var o   = parseUri.options,
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