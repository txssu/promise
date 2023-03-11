defmodule MotivNationWeb.TokenController do
  @moduledoc false
  use MotivNationWeb, :controller
  use OpenApiSpex.ControllerSpecs

  import Guardian.Plug.Keys, only: [token_key: 1]

  alias MotivNation.Accounts
  alias MotivNation.Accounts.User
  alias MotivNation.Guardian

  action_fallback(MotivNationWeb.FallbackController)

  @token_cookie_opts [
    http_only: true
  ]

  @internal_server_error_text """
  This happens when the server fails to generate a token, \
  this usually does not occur
  """

  tags(["tokens"])

  operation(:create,
    summary: "Get token",
    request_body: {"User params", "application/json", Schemas.UserAuthData},
    responses: [
      created: Schemas.TokenResponse.response(),
      unauthorized:
        {"Possibly wrong email or password", "application/json", Schemas.GenericError},
      unprocessable_entity: {"Wrong data format", "application/json", Schemas.GenericError},
      internal_server_error:
        {@internal_server_error_text, "application/json", Schemas.GenericError}
    ]
  )

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

  defp put_token_as_cookie(conn, token, opts) do
    key =
      :motivnation
      |> token_key()
      |> to_string()

    conn
    |> put_resp_cookie(key, token, opts ++ @token_cookie_opts)
  end
end
