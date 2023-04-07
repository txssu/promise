defmodule PromiseWeb.UserController do
  use PromiseWeb, :controller

  alias Promise.Accounts
  alias Promise.Accounts.User

  action_fallback PromiseWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()

    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.register_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/profile")
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user)
  end
end
