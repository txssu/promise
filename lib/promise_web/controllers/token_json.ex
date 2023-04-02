defmodule PromiseWeb.TokenJSON do
  @doc """
  Renders a token.
  """
  def show(%{token: token}) do
    %{data: %{token: token}}
  end
end
