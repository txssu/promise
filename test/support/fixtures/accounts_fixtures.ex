defmodule MotivNation.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MotivNation.Accounts` context.
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
      |> MotivNation.Accounts.create_user()

    user
  end
end
