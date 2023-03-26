defmodule Promise.GoalsTest do
  use Promise.DataCase

  alias Promise.Goals

  describe "goals" do
    alias Promise.Goals.Goal

    import Promise.GoalsFixtures

    @invalid_attrs %{title: nil}

    test "list_goals/0 returns all goals" do
      goal = goal_fixture()
      assert Goals.list_goals() == [goal]
    end

    test "get_goal!/1 returns the goal with given id" do
      goal = goal_fixture()
      assert Goals.get_goal!(goal.id) == goal
    end

    test "create_goal/1 with valid data creates a goal" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Goal{} = goal} = Goals.create_goal(valid_attrs)
      assert goal.title == "some title"
    end

    test "create_goal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Goals.create_goal(@invalid_attrs)
    end

    test "update_goal/2 with valid data updates the goal" do
      goal = goal_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Goal{} = goal} = Goals.update_goal(goal, update_attrs)
      assert goal.title == "some updated title"
    end

    test "update_goal/2 with invalid data returns error changeset" do
      goal = goal_fixture()
      assert {:error, %Ecto.Changeset{}} = Goals.update_goal(goal, @invalid_attrs)
      assert goal == Goals.get_goal!(goal.id)
    end

    test "delete_goal/1 deletes the goal" do
      goal = goal_fixture()
      assert {:ok, %Goal{}} = Goals.delete_goal(goal)
      assert_raise Ecto.NoResultsError, fn -> Goals.get_goal!(goal.id) end
    end

    test "change_goal/1 returns a goal changeset" do
      goal = goal_fixture()
      assert %Ecto.Changeset{} = Goals.change_goal(goal)
    end
  end

  describe "goal_joins" do
    alias Promise.Goals.Join

    import Promise.GoalsFixtures

    @invalid_attrs %{}

    test "list_goal_joins/0 returns all goal_joins" do
      join = join_fixture()
      assert Goals.list_goal_joins() == [join]
    end

    test "get_join!/1 returns the join with given id" do
      join = join_fixture()
      assert Goals.get_join!(join.id) == join
    end

    test "create_join/1 with valid data creates a join" do
      valid_attrs = %{}

      assert {:ok, %Join{} = join} = Goals.create_join(valid_attrs)
    end

    test "create_join/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Goals.create_join(@invalid_attrs)
    end

    test "update_join/2 with valid data updates the join" do
      join = join_fixture()
      update_attrs = %{}

      assert {:ok, %Join{} = join} = Goals.update_join(join, update_attrs)
    end

    test "update_join/2 with invalid data returns error changeset" do
      join = join_fixture()
      assert {:error, %Ecto.Changeset{}} = Goals.update_join(join, @invalid_attrs)
      assert join == Goals.get_join!(join.id)
    end

    test "delete_join/1 deletes the join" do
      join = join_fixture()
      assert {:ok, %Join{}} = Goals.delete_join(join)
      assert_raise Ecto.NoResultsError, fn -> Goals.get_join!(join.id) end
    end

    test "change_join/1 returns a join changeset" do
      join = join_fixture()
      assert %Ecto.Changeset{} = Goals.change_join(join)
    end
  end
end
