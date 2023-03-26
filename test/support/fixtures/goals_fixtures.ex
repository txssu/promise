defmodule Promise.GoalsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Promise.Goals` context.
  """

  @doc """
  Generate a goal.
  """
  def goal_fixture(attrs \\ %{}) do
    {:ok, goal} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> Promise.Goals.create_goal()

    goal
  end

  @doc """
  Generate a join.
  """
  def join_fixture(attrs \\ %{}) do
    {:ok, join} =
      attrs
      |> Enum.into(%{

      })
      |> Promise.Goals.create_join()

    join
  end
end
