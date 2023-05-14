defmodule PromiseWeb.UserJoinsController do
  use PromiseWeb, :controller

  alias Promise.Goals

  alias PromiseWeb.Loaders

  plug PromiseWeb.Plugs.ResourceLoader,
    key: :current_user,
    loader: Loaders.CurrentUserLoader

  action_fallback PromiseWeb.FallbackController

  def index(conn, params) do
    user = conn.assigns.current_user

    with {:ok, {goal_joins, meta}} <- Goals.list_user_joins(user, params) do
      render(conn, :index, goal_joins: goal_joins, total_count: meta.total_count)
    end
  end
end
