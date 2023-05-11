defmodule Promise.GoalsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Promise.Goals` context.
  """

  @doc """
  Generate a goal.
  """
  def goal_fixture(user, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        title: "some title",
        deadline: ~U[2050-01-01 00:00:00.00Z],
        is_public: true
      })

    {:ok, goal} = Promise.Goals.create_goal(user, attrs)

    goal
  end

  @doc """
  Generate a join.
  """
  def join_fixture(user, goal, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        deadline: ~U[2050-01-01 00:00:00.00Z],
        is_public: true
      })

    {:ok, join} = Promise.Goals.create_join(user, goal, attrs)

    join
  end

  @doc """
  Generate a post.
  """
  def post_fixture(goal, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        text: "some text"
      })

    {:ok, post} = Promise.Goals.create_post(goal, attrs)
    post
  end
end
