defmodule Reze.Server.Router do
  use Plug.Router

  alias Reze.Message.Handler
  alias Reze.Message

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json, :urlencoded],
    json_decoder: Poison
  )

  plug(:dispatch)

  post "/messages" do
    %{"content" => content} = conn.body_params

    {:ok, result} =
      %Message.User{content: content}
      |> Handler.handle()

    send_resp(conn, 200, Poison.encode!(result))
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
