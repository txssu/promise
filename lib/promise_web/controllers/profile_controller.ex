defmodule PromiseWeb.ProfileController do
  use PromiseWeb, :controller

  import Guardian.Plug.Keys, only: [token_key: 1]

  alias Promise.Accounts
  alias Promise.Accounts.User

  plug :put_view, json: PromiseWeb.UserJSON

  plug PromiseWeb.Plugs.ResourceLoader,
    key: :current_user,
    loader: PromiseWeb.Loaders.CurrentUserLoader

  action_fallback PromiseWeb.FallbackController

  def show(conn, _params) do
    render(conn, :show, user: conn.assigns.current_user)
  end

  def update(conn, %{"user" => user_params}) do
    user = conn.assigns.current_user

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, _params) do
    user = conn.assigns.current_user

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      conn
      |> delete_token_cookie()
      |> send_resp(:no_content, "")
    end
  end

  defp delete_token_cookie(conn) do
    key =
      :promise
      |> token_key()
      |> to_string()

    delete_resp_cookie(conn, key)
  end
end
