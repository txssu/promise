defmodule Motivnation.GoalsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Motivnation.Goals` context.
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
      |> Motivnation.Goals.create_goal()

    goal
  end
end
