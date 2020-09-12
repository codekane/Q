// Websocket Stuff

var ws_controller_path = "/socket"; // change to '/controller/path'
var ws_uri = (self.location.protocol.match(/https/) ? 'wss' : 'ws') + '://' +
  self.document.location.host + ws_controller_path;
// websocket variable.
var websocket = NaN;
// count failed attempts
var websocket_fail_count = 0;
// to limit failed reconnection attempts, set this to a number.
var websocket_fail_limit = NaN;
// to offer some space between reconnection attempts, set this interval in
// miliseconds.
var websocket_reconnect_interval = 250;

function init_websocket() {
  if (websocket && websocket.readyState == 1)
    return true; // console.log('no need to renew socket connection');
  websocket = new WebSocket(ws_uri);
  websocket.onopen = function(e) {
    // reset the count.
    websocket_fail_count = 0;
    // what do you want to do now?
  };

  websocket.onclose = function(e) {
    // If the websocket repeatedly you probably want to report an error
    if (!isNaN(websocket_fail_limit) &&
      websocket_fail_count >= websocket_fail_limit) {
      // What to do if we can't reconnect so many times?
      return;
    };
    // you probably want to reopen the websocket if it closes.
    if (isNaN(websocket_fail_limit) ||
      (websocket_fail_count <= websocket_fail_limit)) {
      // update the count
      websocket_fail_count += 1;
      // try to reconect
      setTimeout(init_websocket, websocket_reconnect_interval);
    };
  };
  websocket.onerror = function(e) {
    // update the count.
    websocket_fail_count += 1;
    // what do you want to do now?
  };
  websocket.onmessage = function(e) {
    // what do you want to do now?
    console.log(e.data);
    // to use JSON, use:
    // msg = JSON.parse(e.data); // remember to use JSON also in your Plezi
    // controller.
  };
}

function flipConnect() {
  var target = document.getElementById("connectSocket");
  var classes = target.classList.value.split(" ");
  if (classes.includes("btn-success")) {
    target.classList.remove("btn-success");
    target.classList.add("btn-danger");
    target.innerText = "Disconnect";
  } else if (classes.includes("btn-danger")) {
    target.classList.remove("btn-danger");
    target.classList.add("btn-success");
    target.innerText = "Connect";
  }
}

function connectSocket() {
  init_websocket();
  flipConnect();
}

 // Initializes the websocket upon pressing the button
 document.getElementById("connectSocket").onclick = function(event) {
   init_websocket();
   flipConnect();
 }

// Auto-populates the socket- name input with a randomly generated placeholder
document.addEventListener("DOMContentLoaded", function(event) {
  let target = document.getElementById("socket-name");
  let number = Math.round(Math.random() * 100);
  let android = "android " + number;
  target.placeholder = android;
});


// PLAYER CODE
// 2. This code loads the IFrame Player API code asynchronously.
var tag = document.createElement('script');

tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

// 3. This function creates an <iframe> (and YouTube player)
//    after the API code downloads.
var player;
function onYouTubeIframeAPIReady() {
  player = new YT.Player('player', {
    height: '390',
    width: '640',
    videoId: 'M7lc1UVf-VE',
    events: {
      'onReady': onPlayerReady,
      'onStateChange': onPlayerStateChange
    }
  });
}

// 4. The API will call this function when the video player is ready.
function onPlayerReady(event) {
  event.target.playVideo();
}

// 5. The API calls this function when the player's state changes.
//    The function indicates that when playing a video (state=1),
//    the player should play for six seconds and then stop.
var done = false;
function onPlayerStateChange(event) {
  if (event.data == YT.PlayerState.PLAYING && !done) {
    setTimeout(stopVideo, 6000);
    done = true;
  }
}
function stopVideo() {
  player.stopVideo();
}
