defmodule MotivnationWeb.ProfileController do
  use MotivnationWeb, :controller
  use OpenApiSpex.ControllerSpecs

  import Guardian.Plug.Keys, only: [token_key: 1]

  alias Motivnation.Accounts
  alias Motivnation.Accounts.User

  plug :put_view, json: MotivnationWeb.UserJSON

  action_fallback MotivnationWeb.FallbackController

  tags ["profile"]
  security [%{}, %{"authorization" => ["authorization"]}]

  operation :index, false
  operation :create, false

  operation :show,
    summary: "Get profile",
    responses: [
      ok: {"User data", "application/json", Schemas.UserResponse}
    ]

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn, key: :motivnation)
    IO.inspect(user)
    render(conn, :show, user: user)
  end

  operation :update,
    summary: "Edit profile data",
    request_body: {"User params", "application/json", Schemas.UserAuthData},
    responses: [
      ok: {"User data", "application/json", Schemas.UserResponse}
    ]

  def update(conn, %{"user" => user_params}) do
    user = Guardian.Plug.current_resource(conn, key: :motivnation)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  operation :delete,
    summary: "Delete profile",
    responses: [
      no_content: "Deleted succesfully"
    ]

  def delete(conn, _params) do
    user = Guardian.Plug.current_resource(conn, key: :motivnation)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      conn
      |> delete_token_cookie()
      |> send_resp(:no_content, "")
    end
  end

  defp delete_token_cookie(conn) do
    key =
      :motivnation
      |> token_key()
      |> to_string()

    delete_resp_cookie(conn, key)
  end
end
