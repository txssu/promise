defmodule PromiseWeb.TokenController do
  @moduledoc false
  use PromiseWeb, :controller

  import Guardian.Plug.Keys, only: [token_key: 1]

  alias Promise.Accounts
  alias Promise.Accounts.User
  alias Promise.Guardian

  action_fallback PromiseWeb.FallbackController

  @token_cookie_opts [
    http_only: true
  ]

  def create(conn, params) do
    create_user_token(conn, params)
  end

  defp create_user_token(conn, %{"user" => %{"email" => email, "password" => password}}) do
    with {:getting_user, {:ok, %User{} = user}} <-
           {:getting_user, Accounts.get_user_by_email_and_password(email, password)},
         {:token_creating, {:ok, token, %{"iat" => iat, "exp" => exp}}} <-
           {:token_creating, Guardian.encode_and_sign(user, %{"typ" => "refresh"})} do
      conn
      |> put_status(:created)
      |> put_token_as_cookie(token, max_age: exp - iat)
      |> send_resp(:created, "")
    else
      tag_with_error -> handle_errors(conn, tag_with_error)
    end
  end

  defp create_user_token(conn, _data) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: PromiseWeb.ErrorJSON)
    |> render("422.json")
  end

  defp handle_errors(conn, {:getting_user, _error}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(json: PromiseWeb.ErrorJSON)
    |> render("401.json", message: "Wrong email or password")
  end

  defp handle_errors(conn, {:token_creating, _error}) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(json: PromiseWeb.ErrorJSON)
    |> render("500.json")
  end

  defp put_token_as_cookie(conn, token, opts) do
    key =
      :promise
      |> token_key()
      |> to_string()

    conn
    |> put_resp_cookie(key, token, opts ++ @token_cookie_opts)
  end
end
