defmodule PromiseWeb.GoalController do
  use PromiseWeb, :controller

  alias Promise.Goals
  alias Promise.Goals.Goal

  alias PromiseWeb.Loaders

  plug PromiseWeb.Plugs.ResourceLoader,
       [key: :current_user, loader: Loaders.CurrentUserLoader]

  plug PromiseWeb.Plugs.ResourceLoader,
       [key: :goal, loader: Loaders.GenLoader, resource: {Goals, :get_goal!}]
       when action in [:show, :update, :delete]

  plug PromiseWeb.Plugs.AccessRules,
    [rule: :owner_only, resource_key: :goal, can_be_public: true]
    when action in [:show, :update, :delete]

  action_fallback PromiseWeb.FallbackController

  def index(conn, _params) do
    user =
      conn.assigns.current_user
      |> Goals.preload_goals()
    goals = user.goals
    render(conn, :index, goals: goals)
  end

  def index_public(conn, params) do
    with  {:ok, {goals, _meta}}  <- Goals.list_goals(params) do
      render(conn, :index, goals: goals)
    end
  end

  def show(conn, _params) do
    render(conn, :show, goal: conn.assigns.goal)
  end

  def create(conn, %{"goal" => goal_params}) do
    user = conn.assigns.current_user

    with {:ok, %Goal{} = goal} <- Goals.create_goal(user, goal_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/goals/#{goal}")
      |> render(:show, goal: goal)
    end
  end

  def update(conn, %{"goal" => goal_params}) do
    goal = conn.assigns.goal

    with {:ok, %Goal{} = goal} <- Goals.update_goal(goal, goal_params) do
      render(conn, :show, goal: goal)
    end
  end

  def delete(conn, _params) do
    goal = conn.assigns.goal

    with {:ok, %Goal{}} <- Goals.delete_goal(goal) do
      send_resp(conn, :no_content, "")
    end
  end
end
