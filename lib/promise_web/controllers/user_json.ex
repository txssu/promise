defmodule PromiseWeb.UserJSON do
  @moduledoc false
  alias Promise.Accounts.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users, total_count: total_count}) do
    %{total_count: total_count, data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      bio: user.bio,
      city: user.city
    }
  end
end
