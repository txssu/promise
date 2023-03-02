defmodule MotivNationWeb.TokenJSON do
  @doc """
  Renders a single user.
  """
  def create(%{token: token}) do
    %{data: %{token: token}}
  end
end
