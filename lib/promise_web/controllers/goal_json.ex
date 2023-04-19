defmodule PromiseWeb.GoalJSON do
  alias Promise.Goals.Goal

  @doc """
  Renders a list of goals.
  """
  def index(%{goals: goals}) do
    %{data: for(goal <- goals, do: data(goal))}
  end

  @doc """
  Renders a single goal.
  """
  def show(%{goal: goal}) do
    %{data: data(goal)}
  end

  defp data(%Goal{} = goal) do
    %{
      id: goal.id,
      title: goal.title,
      deadline: goal.deadline,
      user_id: goal.user_id
    }
  end
end
