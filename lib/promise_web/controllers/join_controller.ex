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

  # plug PromiseWeb.Plugs.AccessRules,
  #   [rule: :owner_only, resource_key: :goal, can_be_public: true]
  #   when action in [:show, :delete]

  action_fallback PromiseWeb.FallbackController

  def index(conn, _params) do
    goal = conn.assigns.goal
    with  {:ok, {goal_joins, meta}}  <- Goals.get_goal_joins(goal) do
      render(conn, :index, goal_joins: goal_joins, total_count: meta.total_count)
    end
  end

  def show(conn, _params) do
    %{current_user: user, goal: goal} = conn.assigns

    {join} = Goals.get_user_goal_join!(user, goal)

    render(conn, :show, join: join)
  end

  def create(conn, %{"join" => join_params}) do
    %{current_user: user, goal: goal} = conn.assigns

    with {:ok, %Join{} = join} <- Goals.create_join(user, goal, join_params) do
      render(conn, :show, join: join)
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
