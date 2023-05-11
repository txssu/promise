defmodule Promise.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Promise.Accounts` context.
  """

  use PromiseWeb.ConnCase

  @default_password "some-password"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    n = :rand.uniform(1_000_000)

    {:ok, user} =
      attrs
      |> Enum.into(%{
        first_name: "SomeName",
        last_name: "SomeLastName",
        email: "some#{n}@email.com",
        password: @default_password
      })
      |> Promise.Accounts.register_user()

    user
  end

  def auth_user_by_password(conn, user, password \\ @default_password) do
    auth_user(conn, %{email: user.email, password: password})
  end

  def auth_user(conn, attrs) do
    conn = post(conn, ~p"/api/tokens", user: attrs)

    assert %{"token" => token} = json_response(conn, 201)["data"]

    conn
    |> recycle()
    |> put_req_header("authorization", "Bearer #{token}")
  end
end
