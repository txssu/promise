defmodule PromiseWeb.JoinController do
  use PromiseWeb, :controller

  alias Promise.Goals
  alias Promise.Goals.Join

  alias PromiseWeb.Loaders

  plug PromiseWeb.Plugs.ResourceLoader,
    key: :current_user,
    loader: Loaders.CurrentUserLoader

  plug PromiseWeb.Plugs.ResourceLoader,
    key: :goal,
    loader: Loaders.GenLoader,
    resource: {Goals, :get_goal!}

  action_fallback PromiseWeb.FallbackController

  def index(conn, _params) do
    goal = Goals.load_joins(conn.assigns.goal)

    conn
    |> put_view(json: PromiseWeb.UserJSON)
    |> render(:index, users: goal.user_joins)
  end

  def create(conn, _params) do
    %{current_user: user, goal: goal} = conn.assigns

    with _ <- Goals.create_join(user, goal) do
      send_resp(conn, :no_content, "")
    end
  end

  def delete(conn, _params) do
    %{current_user: user, goal: goal} = conn.assigns

    join = Goals.get_user_goal_join!(user, goal)

    with {:ok, %Join{}} <- Goals.delete_join(join) do
      send_resp(conn, :no_content, "")
    end
  end
end
