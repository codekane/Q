
// SEARCH ELEMENT
// Handles toggling display of the YouTube Search Element in the Queue




function searchYoutube() {
  event.preventDefault();
  console.log(event);
}


function popQueue() {
  let target = document.getElementById("queue-pop");
  if (target.classList.contains("hidden")) {
    target.classList.remove("hidden");
  } else {
    target.classList.add("hidden");
  }
}

// Search Feature
document.getElementById("searchSubmit").onclick = function(event) {
  event.preventDefault();
  let inputVal = document.getElementById("searchInput").value;
  clearResults();
  getVideos(inputVal);
}

function clearResults() {
  let target = document.getElementById("searchResults");
  if (target.children.length === 0) {
    return
  } else {
    while (target.firstChild) {
      target.removeChild(target.lastChild);
    }
  }
}

// Generates the DATA PAYLOAD OBJECTto include with API requests
function request(search, pagetoken) {
  if (pagetoken) {
    return {
      key: config.apiKey,
      q: search,
      part: 'snippet',
      maxResults: 50,
      type: 'video',
      videoEmbeddable: true,
      pageToken: pagetoken
    }
  } else {
    return {
      key: config.apiKey,
      q: search,
      part: 'snippet',
      maxResults: 50,
      type: 'video',
      videoEmbeddable: true,
    }
  }
}

function setPagination(query, data) {
  var previous = document.getElementById("previousPage");
  var next = document.getElementById("nextPage");
  previous.setAttribute("data-query", query);
  next.setAttribute("data-query", query);
  if (data.nextPageToken) {
    next.setAttribute("data-token", data.nextPageToken);
  }
  if (data.previousPageToken) {
    previous.setAttribute("data-token", data.previousPageToken);
  }
}


document.getElementById("nextPage").onclick = function(event) {
  var dataToken = event.target.getAttribute("data-token");
  var dataQuery = event.target.getAttribute("data-query");
  console.log("Token is" + dataToken);
  console.log("Query is" + dataQuery);
  clearResults();
  getVideos(dataQuery, dataToken);
}

document.getElementById("previousPage").onclick = function(event) {
  var dataToken = event.target.getAttribute("data-token");
  var dataQuery = event.target.getAttribute("data-query");
  console.log("Token is" + dataToken);
  console.log("Query is" + dataQuery);
  clearResults();
  getVideos(dataQuery, dataToken);
}

function getVideos(query, token) {
  var data = request(query, token);
  $.ajax({
    type: 'GET',
    url: 'https://www.googleapis.com/youtube/v3/search',
    data: data,
    success: function(data) {
      populateResultsCounter(data.pageInfo);
      populateResults(data);
      setPagination(query, data)
    },
    error: function(response) {
      console.log("Request Failed");
    }
  });
}

function populateResultsCounter(pageInfo) {
  var target = document.getElementById("responseData");
  var resultsPerPage = target.children[0].children[0];
  var totalResults = target.children[1].children[0];

  resultsPerPage.innerHTML = "Results Per Page: " + pageInfo.resultsPerPage;
  totalResults.innerHTML = "Total Results: " + pageInfo.totalResults;
}



function populateResults(data) {
  let target = document.getElementById("searchResults");
  for (let item in data.items) {
    var thisItem = data.items[item];

    // Creates the search card itself
    var card = document.createElement("div");
    card.className = "search-card";
    card.setAttribute("data-video-id", thisItem.id.videoId);
    card.onclick = function() {
      var videoID = this.getAttribute("data-video-id");
      player.loadVideoById(videoID);
    }

    // Create the image to go inside the card
    var thisImg = thisItem.snippet.thumbnails.default;
    var image = document.createElement("img");
    image.src = thisImg.url;
    image.width = thisImg.width;
    image.height = thisImg.height;
    card.appendChild(image);

    // Creates the container for the rest of the card
    var container = document.createElement("div");
    container.className = "container";

    // Adds the title row to that container
    var titleRow = document.createElement("div");
    titleRow.className = "row";

    // Create the title
    var title = document.createElement("b");
    title.innerHTML = thisItem.snippet.title;
    titleRow.appendChild(title);
    container.appendChild(titleRow);

    // Creates the 2nd (description) row
    var descriptionRow = document.createElement("div");
    descriptionRow.className = "row";

    // Create the description
    var description = document.createElement("p");
    description.innerHTML = thisItem.snippet.description;
    descriptionRow.appendChild(description);
    container.appendChild(descriptionRow);

    card.appendChild(container);

    // Adds the completed card to the queue list
    target.appendChild(card);
  }
}
