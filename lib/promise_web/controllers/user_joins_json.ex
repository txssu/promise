defmodule PromiseWeb.UserJoinsJSON do
  alias Promise.Goals.Join

  @doc """
  Renders a list of goal_joins.
  """
  def index(%{goal_joins: goal_joins, total_count: total_count}) do
    %{total_count: total_count, data: for(join <- goal_joins, do: data(join))}
  end

  @doc """
  Renders a single join.
  """
  def show(%{join: join}) do
    %{data: data(join)}
  end

  defp data(%Join{} = join) do
    %{
      user_id: join.user_id,
      goal_id: join.goal_id,
      deadline: join.deadline,
      is_public: join.is_public,
      inserted_at: join.inserted_at
    }
  end
end
