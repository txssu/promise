defmodule PromiseWeb.JoinJSON do
  alias Promise.Goals.Join

  @doc """
  Renders a list of goal_joins.
  """
  def index(%{goal_joins: goal_joins}) do
    %{data: for(join <- goal_joins, do: data(join))}
  end

  @doc """
  Renders a single join.
  """
  def show(%{join: join}) do
    %{data: data(join)}
  end

  defp data(%Join{} = join) do
    %{
      id: join.id,
      user_id: join.user_id
    }
  end
end
