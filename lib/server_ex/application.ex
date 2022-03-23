defmodule ServerEx.Application do
  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: ServerEx.Router,
        options: [ip: {0, 0, 0, 0}, port: 8080]
      )
    ]

    opts = [strategy: :one_for_one, name: ServerEx.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
