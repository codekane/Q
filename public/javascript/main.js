// Handles toggling display of the YouTube Search Element in the Queue

document.getElementById("queue-popper").onclick = function(event) {
  let target = document.getElementById("queue-pop");
  if (target.classList.contains("hidden")) {
    console.log(target);
    target.classList.remove("hidden");
  } else {
    target.classList.add("hidden");
  }
}

// Launches/focuses the player window
//  function launchQueue() {
//    console.log("test");
//    window.open('/queue, 'Queue', 'width=720,height=400').focus();
//  }
//  
// document.getElementById("launchQueue").onclick = function(event) {
//   event.preventDefault();
//   let w = window.open('/queue', 'Queue', 'width=720,height=400').focus();
// }
// END BROKEN SHIT FUCK

document.getElementById("searchSubmit").onclick = function(event) {
  event.preventDefault();
  let inputVal = document.getElementById("searchInput").value;
  getVideos(inputVal);
}

// Hits the YouTube Data API to pull in a batch of search results, and populate 
// the queue with cards.
function getVideos(search) {
  $.ajax({
    type: 'GET',
    url: 'https://www.googleapis.com/youtube/v3/search',
    data: {
      key: 'AIzaSyCwKyWI7WeJ6XPRUM4-9TrZsg0YKbk2zAI',
      q: search,
      part: 'snippet',
      maxResults: 100,
      type: 'video',
      videoEmbeddable: true,
    },
    success: function(data) {
      let target = document.getElementById("searchResults");
      for (let item in data.items) {
        // Helper to find where we are.
        var thisItem = data.items[item];

        // Creates the search card itself
        var card = document.createElement("div");
        card.className = "search-card";

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

        console.log(container);
        card.appendChild(container);

        // Adds the completed card to the queue list
        target.appendChild(card);
      }
    },
    error: function(response) {
      console.log("Request Failed");
    }
  });
}
