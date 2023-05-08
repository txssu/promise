defmodule PromiseWeb.UserController do
  use PromiseWeb, :controller

  alias Promise.Accounts
  alias Promise.Accounts.User

  action_fallback(PromiseWeb.FallbackController)

  def index(conn, %{"name" => name} = params) do
    with {:ok, {users, meta}} <- Accounts.search_by_name(name, params) do
      render(conn, :index, users: users, total_count: meta.total_count)
    end
  end

  def index(conn, _params) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: PromiseWeb.ErrorJSON)
    |> render(:unprocessable_entity, message: "parameter name is required")
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.register_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/profile")
      |> render(:show_full, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user)
  end
end
