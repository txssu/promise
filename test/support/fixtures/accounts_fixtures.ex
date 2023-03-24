defmodule Motivnation.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Motivnation.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        password_hash: "some password_hash"
      })
      |> Motivnation.Accounts.create_user()

    user
  end
end
