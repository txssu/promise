defmodule MotivNationWeb.TokenController do
  @moduledoc false
  use MotivNationWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias MotivNation.Accounts
  alias MotivNation.Accounts.User
  alias MotivNation.Guardian

  action_fallback MotivNationWeb.FallbackController

  @internal_server_error_text """
  This happens when the server fails to generate a token, \
  this usually does not occur
  """

  tags ["tokens"]

  operation :create,
    summary: "Update user",
    request_body: {"User params", "application/json", Schemas.UserAuthData},
    responses: [
      ok: {"Token and user id", "application/json", Schemas.TokenResponse},
      unauthorized: {"Possibly wrong email or password", "application/json", Schemas.GenericError},
      unprocessable_entity: {"Wrong data format", "application/json", Schemas.GenericError},
      internal_server_error: {@internal_server_error_text, "application/json", Schemas.GenericError}
    ]

  def create(conn, params) do
    create_user_token(conn, params)
  end

  defp create_user_token(conn, %{"user" => %{"email" => email, "password" => password}}) do
    with {:getting_user, {:ok, %User{} = user}} <-
           {:getting_user, Accounts.get_user_by_email_and_password(email, password)},
         {:token_creating, {:ok, token, _claims}} <-
           {:token_creating, Guardian.encode_and_sign(user)} do
      conn
      |> put_status(:created)
      |> render(:create, token: token, user: user)
    else
      tag_with_error -> handle_errors(conn, tag_with_error)
    end
  end

  defp create_user_token(conn, _data) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: MotivNationWeb.ErrorJSON)
    |> render("422.json")
  end

  defp handle_errors(conn, {:getting_user, _error}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(json: MotivNationWeb.ErrorJSON)
    |> render("401.json", message: "Wrong email or password")
  end

  defp handle_errors(conn, {:token_creating, _error}) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(json: MotivNationWeb.ErrorJSON)
    |> render("500.json")
  end
end
