# msndevopsbot

Oh hi.



Everything below here is auto-generated and probably not yet accurate.
----


msndevopsbot is a chat bot built on the [Hubot][hubot] framework. It was
initially generated by [generator-hubot][generator-hubot], and configured to be
deployed on [Heroku][heroku] to get you up and running as quick as possible.

### Running msndevopsbot Locally

    % make build
    % make dev


There may be some weird permissions issues here that I still need to work out.


### Brain

We're using a file based brain vs redis...mostly for simplicity. Also the redis
brain is just a single key with a json blob as the value anyway.
