defmodule ServerEx.Router do
  @doc """
  Application router
  """
  use Plug.Router
  use Plug.Debugger
  require Logger

  plug(Plug.Logger, log: :debug)
  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison
  )

  plug(:dispatch)

  get "/health" do
    send_resp(conn, 200, "ok")
  end

  post("/") do
    {:ok, message} = ServerEx.handle_post()
    send_resp(conn, 200, JSON.encode!(message))
  end

  get("/") do
    {:ok, message} = ServerEx.handle_get()
    send_resp(conn, 200, JSON.encode!(message))
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
