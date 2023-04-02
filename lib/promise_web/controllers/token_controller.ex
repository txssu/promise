defmodule PromiseWeb.TokenController do
  @moduledoc false
  use PromiseWeb, :controller

  alias Promise.Accounts
  alias Promise.Accounts.User
  alias Promise.Guardian

  action_fallback PromiseWeb.FallbackController

  def create(conn, params) do
    create_user_token(conn, params)
  end

  defp create_user_token(conn, %{"user" => %{"email" => email, "password" => password}}) do
    with {:getting_user, {:ok, %User{} = user}} <-
           {:getting_user, Accounts.get_user_by_email_and_password(email, password)},
         {:token_creating, {:ok, token, _claims}} <-
           {:token_creating, Guardian.encode_and_sign(user, %{"typ" => "refresh"})} do
      conn
      |> put_status(:created)
      |> render(:show, token: token)
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
end
