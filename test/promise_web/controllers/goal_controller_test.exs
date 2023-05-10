defmodule PromiseWeb.GoalControllerTest do
  use PromiseWeb.ConnCase

  import Promise.AccountsFixtures
  import Promise.GoalsFixtures
  import Promise.AuthHelper

  alias Promise.Goals.Goal

  @create_attrs %{
    title: "some title",
    deadline: ~U[2050-01-01 00:00:00.00Z],
    is_public: true
  }
  @update_attrs %{
    title: "some updated title",
    deadline: ~U[2051-01-01 00:00:00.00Z],
    is_public: false
  }
  @invalid_attrs %{
    title: "",
    deadline: ~U[2003-01-01 00:00:00.00Z]
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "unauthorized" do
    test "can't list goals", %{conn: conn} do
      conn = get(conn, ~p"/api/goals")
      response(conn, 401)

      conn = get(conn, ~p"/api/goals/public")
      response(conn, 401)
    end

    test "can't create goals", %{conn: conn} do
      conn = post(conn, ~p"/api/goals", @create_attrs)
      response(conn, 401)
    end

    test "can't access certain goal", %{conn: conn} do
      conn = get(conn, ~p"/api/goals/fake-id")
      response(conn, 401)

      conn = put(conn, ~p"/api/goals/fake-id", @update_attrs)
      response(conn, 401)

      conn = delete(conn, ~p"/api/goals/fake-id")
      response(conn, 401)
    end
  end

  describe "index" do
    setup [:create_user_and_auth, :create_goal]

    test "lists all current user goals", %{conn: conn, goal: goal} do
      goal_id = goal.id
      conn = get(conn, ~p"/api/goals")

      assert %{"id" => ^goal_id} = List.first(json_response(conn, 200)["data"])
    end
  end

  describe "feed" do
    setup [:create_user_and_auth, :create_goal]

    test "lists all goals", %{conn: conn} do
      second_user = user_fixture()
      goal_fixture(second_user, title: "second")

      conn = get(conn, ~p"/api/goals/public")

      assert json_response(conn, 200)["total_count"] == 2
    end
  end

  describe "create goal" do
    setup [:create_user_and_auth]

    test "renders goal when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/goals", goal: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/goals/#{id}")

      assert %{
               "id" => ^id,
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/goals", goal: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update goal" do
    setup [:create_user_and_auth, :create_goal]

    test "renders goal when data is valid", %{conn: conn, goal: %Goal{id: id} = goal} do
      conn = put(conn, ~p"/api/goals/#{goal}", goal: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/goals/#{id}")

      assert %{
               "id" => ^id,
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, goal: goal} do
      conn = put(conn, ~p"/api/goals/#{goal}", goal: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete goal" do
    setup [:create_user_and_auth, :create_goal]

    test "deletes chosen goal", %{conn: conn, goal: goal} do
      conn = delete(conn, ~p"/api/goals/#{goal}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/goals/#{goal}")
      end
    end
  end

  defp create_goal(%{user: user}) do
    goal = goal_fixture(user)
    %{goal: goal}
  end
end
