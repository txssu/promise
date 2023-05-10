defmodule Promise.GoalsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Promise.Goals` context.
  """

  @doc """
  Generate a goal.
  """
  def goal_fixture(user, attrs \\ %{}) do
    attrs = Enum.into(attrs, %{
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
  def join_fixture(attrs \\ %{}) do
    {:ok, join} =
      attrs
      |> Enum.into(%{})
      |> Promise.Goals.create_join()

    join
  end

  @doc """
  Generate a subscription.
  """
  def subscription_fixture(attrs \\ %{}) do
    {:ok, subscription} =
      attrs
      |> Enum.into(%{})
      |> Promise.Goals.create_subscription()

    subscription
  end

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        text: "some text"
      })
      |> Promise.Goals.create_post()

    post
  end
end
