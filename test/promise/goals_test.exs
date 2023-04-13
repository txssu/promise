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

  describe "goal_subscriptions" do
    alias Promise.Goals.Subscription

    import Promise.GoalsFixtures

    @invalid_attrs %{}

    test "list_goal_subscriptions/0 returns all goal_subscriptions" do
      subscription = subscription_fixture()
      assert Goals.list_goal_subscriptions() == [subscription]
    end

    test "get_subscription!/1 returns the subscription with given id" do
      subscription = subscription_fixture()
      assert Goals.get_subscription!(subscription.id) == subscription
    end

    test "create_subscription/1 with valid data creates a subscription" do
      valid_attrs = %{}

      assert {:ok, %Subscription{} = subscription} = Goals.create_subscription(valid_attrs)
    end

    test "create_subscription/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Goals.create_subscription(@invalid_attrs)
    end

    test "update_subscription/2 with valid data updates the subscription" do
      subscription = subscription_fixture()
      update_attrs = %{}

      assert {:ok, %Subscription{} = subscription} = Goals.update_subscription(subscription, update_attrs)
    end

    test "update_subscription/2 with invalid data returns error changeset" do
      subscription = subscription_fixture()
      assert {:error, %Ecto.Changeset{}} = Goals.update_subscription(subscription, @invalid_attrs)
      assert subscription == Goals.get_subscription!(subscription.id)
    end

    test "delete_subscription/1 deletes the subscription" do
      subscription = subscription_fixture()
      assert {:ok, %Subscription{}} = Goals.delete_subscription(subscription)
      assert_raise Ecto.NoResultsError, fn -> Goals.get_subscription!(subscription.id) end
    end

    test "change_subscription/1 returns a subscription changeset" do
      subscription = subscription_fixture()
      assert %Ecto.Changeset{} = Goals.change_subscription(subscription)
    end
  end

  describe "goal_posts" do
    alias Promise.Goals.Post

    import Promise.GoalsFixtures

    @invalid_attrs %{text: nil}

    test "list_goal_posts/0 returns all goal_posts" do
      post = post_fixture()
      assert Goals.list_goal_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Goals.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{text: "some text"}

      assert {:ok, %Post{} = post} = Goals.create_post(valid_attrs)
      assert post.text == "some text"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Goals.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{text: "some updated text"}

      assert {:ok, %Post{} = post} = Goals.update_post(post, update_attrs)
      assert post.text == "some updated text"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Goals.update_post(post, @invalid_attrs)
      assert post == Goals.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Goals.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Goals.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Goals.change_post(post)
    end
  end
end
