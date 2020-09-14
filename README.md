# Q
Heavily a Work In Progress.

This is sitting at two weeks of effort, partially feature-complete.

YouTube Search API Integration is done.

WebSocket communication between client and server IS working...

It's just not doing anything yet. Ultimately goal is a shared YouTube-queue
between all members of a video chat room. I have conveniently embedded another
video chat-room in the site, so as to not have to worry about that part right
now.

![Whiteboarding](https://i.imgur.com/MCFQGsW.jpg)

Current plans are to incorporate all of the App functionality to be routed
through this "dongle" to the right of the screen.

Current challenges include how can I get the App functional with a minimum of
efforts. So far:

  - Very little styling, utilizing bootstrap... If anyone feels like
      contributing, this would be a good target... Take something ugly, and then
      make it pretty out of less components, utilizing flexbox rather than
      bootstrap.
  - How much am I going to cheese the authentication. The answer is Very Cheesy.

My next step will be integrating a Database, which seems to be the simplest way
to reliably get the room data out to the clients...

Tests have been implemented for most current functionality. Primarily
regression testing, styled in the form of an end-to-end JavaScript feature
test.


## Architecture
[Sinatra](https://github.com/sinatra/sinatra)  
[Rspec](https://github.com/rspec/rspec/) and
[Capybara](https://github.com/teamcapybara/capybara) for the test suite.  
[Iodine](https://github.com/boazsegev/iodine) as a server.
It's also a required dependency of [Plezi](https://github.com/boazsegev/plezi),
which handles WebSockets on the Ruby End.

## Contributing
If you want to contribute, that's probably best left to discuss with me in
person. I can be reached at ryan.horricks@gmail.com, or through any other
personal channel. You're also welcome to try to run the project locally, but I
don't have the iota to guide you through that process today.
