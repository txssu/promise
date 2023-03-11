defmodule MotivNationWeb.UserController do
  use MotivNationWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias MotivNation.Accounts
  alias MotivNation.Accounts.User

  action_fallback MotivNationWeb.FallbackController

  tags ["users"]

  operation :index, false

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, :index, users: users)
  end

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
      |> put_resp_header("location", ~p"/api/users/#{user}")
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

  security [%{}, %{"authorization" => ["authorization"]}]

  operation :update,
    summary: "Edit user data",
    parameters: [
      id: [
        in: :path,
        description: "User ID",
        type: :string,
        example: "3bf8ac00-fa03-43b5-86b1-d303d71b0075"
      ]
    ],
    request_body: {"User params", "application/json", Schemas.UserAuthData},
    responses: [
      ok: {"User data", "application/json", Schemas.UserResponse},
      not_found: {"There is no this user", "application/json", Schemas.GenericError}
    ]

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = conn.private.guardian_default_resource

    if user.id == id do
      with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
        render(conn, :show, user: user)
      end
    else
      send_resp(conn, :bad_request, "")
    end
  end

  operation :delete,
    summary: "Delete user",
    parameters: [
      id: [
        in: :path,
        description: "User ID",
        type: :string,
        example: "3bf8ac00-fa03-43b5-86b1-d303d71b0075"
      ]
    ],
    responses: [
      no_content: "Deleted succesfully",
      not_found: {"There is no this user", "application/json", Schemas.GenericError}
    ]

  def delete(conn, %{"id" => id}) do
    user = conn.private.guardian_default_resource

    if user.id == id do
      with {:ok, %User{}} <- Accounts.delete_user(user) do
        send_resp(conn, :no_content, "")
      end
    else
      send_resp(conn, :bad_request, "")
    end
  end
end
