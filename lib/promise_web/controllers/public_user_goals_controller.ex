defmodule PromiseWeb.PublicUserGoalsController do
  use PromiseWeb, :controller

  alias Promise.Goals

  plug :put_view, json: PromiseWeb.GoalJSON

  action_fallback PromiseWeb.FallbackController

  def index(conn, %{"id" => user_id}) do
    with {:ok, {goals, meta}} <- Goals.list_user_goals(user_id) do
      render(conn, :index, goals: goals, total_count: meta.total_count)
    end
  end
end
