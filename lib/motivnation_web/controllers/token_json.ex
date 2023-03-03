defmodule MotivNationWeb.TokenJSON do
  @moduledoc false
  @doc """
  Renders a single user.
  """
  def create(%{token: token, user: user}) do
    %{data: %{token: token, user_id: user.id}}
  end
end
