defmodule ServerExTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts ServerEx.Router.init([])

  test "health returns ok" do
    # Create a test connection
    conn = conn(:get, "/health")

    # Invoke the plug
    conn = ServerEx.Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "ok"
  end

  test "post returns correct response" do
    # Create a test connection
    conn = conn(:post, "/")

    # Invoke the plug
    conn = ServerEx.Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200

    %{text: val} = conn.resp_body |> Poison.decode!(%{keys: :atoms!})

    assert val =~ "POST"
  end
end
