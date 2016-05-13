defmodule Web.Endpoints do
  import Plug.Conn
  use Plug.Router

  plug :match
  plug :dispatch

  def init(options) do
    options
  end

  def start_link() do
    {:ok, _} = Plug.Adapters.Cowboy.http Web.Endpoints, [port: 4000]
  end

  get "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{"response"=> %{"value" => "Hello world from /"}}))
  end

  get "/events" do
    conn
    |> put_resp_content_type("text/event-stream")
    |> send_chunked(200)
    |> connected_event()
    |> events_for_days()
  end

  defp connected_event(conn) do
    {:ok, conn} = chunk(conn, ["data: ", welcome_event() |> Poison.encode!, "\n\n"])
    conn
  end

  defp welcome_event() do
    %{"event" => "connected", "data" => "Connected to stream"}
  end

  defp events_for_days(conn) do
    {:ok, conn} = chunk(conn, ["data: ", event() |> Poison.encode!, "\n\n"])
    :timer.sleep(2000)
    events_for_days(conn)
  end

  defp event() do
    msgs = ["Iron is a naturally occurring metallic element",
      "Wrought iron is the purest form of iron generally encountered or produced in quantity.",
      "Steel is a mixture of Iron and between 0.3% to 1.7% Carbon by weight.",
      "Cast iron is iron that contains between 2.0% to 6% Carbon by weight.",
      "Gold, silver, and copper all occur in nature in their native states, as reasonably pure metals."]
    %{"event" => "message", "data" => Enum.random(msgs)}
  end
end
