defmodule MotivnationWeb.UserController do
  use MotivnationWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias Motivnation.Accounts
  alias Motivnation.Accounts.User

  action_fallback MotivnationWeb.FallbackController

  tags ["users"]

  operation :index, false
  operation :update, false
  operation :delete, false

  operation :create,
    summary: "Create user",
    request_body: {"User params", "application/json", Schemas.UserAuthData},
    responses: [
      created: {"Created user", "application/json", Schemas.UserResponse},
      bad_request: {"Bad request", "application/json", Schemas.GenericError}
    ]

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.register_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/profile")
      |> render(:show, user: user)
    end
  end

  operation :show,
    summary: "Get user data",
    parameters: [
      id: [
        in: :path,
        description: "User ID",
        type: :string,
        example: "3bf8ac00-fa03-43b5-86b1-d303d71b0075"
      ]
    ],
    responses: [
      ok: {"User data", "application/json", Schemas.UserResponse},
      not_found: {"There is no this user", "application/json", Schemas.GenericError}
    ]

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user)
  end
end
