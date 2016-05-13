# Sse

A simple demo of [Server-sent Events (SSE)](https://en.wikipedia.org/wiki/Server-sent_events) using [Cowboy](https://github.com/ninenines/cowboy) and [Plug](https://github.com/elixir-lang/plug) in [Elixir](http://elixir-lang.org/).

Just a learning thing. Much help from these gists: [jeregrin](https://gist.github.com/jeregrine/8e962d04302f1869ec53), [rbishop](https://gist.github.com/rbishop/e7b1886d5e75b2f74d8b)

## Server sent events

TL;DR is that it's a simple technology for streaming data/events to a client over a long running HTTP connection.

## Running

Make sure you have Elixir installed.

1. `mix deps.get`
2. `mix run --no-halt`
3. The demo app should now be running and listening on `localhost:4000`.
  On `/events` you can get an infinite stream of events. Ex: `curl localhost:4000/events`
