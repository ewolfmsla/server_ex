defmodule ServerEx do
  @moduledoc """
  Documentation for `ServerEx`.
  """

  def handle_post do
    message = %{text: "POST handler"}
    {:ok, message}
  end

  def handle_get do
    message = %{text: "GET handler"}
    {:ok, message}
  end
end
