defmodule PromiseWeb.GoalJoinsControllerTest do
  use PromiseWeb.ConnCase

  import Promise.Setups

  alias Promise.Goals.Goal
  alias Promise.Goals.Join

  @create_attrs %{
    deadline: ~U[2050-01-01 00:00:00.00Z],
    is_public: true
  }
  @update_attrs %{
    deadline: ~U[2051-01-01 00:00:00.00Z],
    is_public: false
  }
  @invalid_attrs %{
    deadline: ~U[2003-01-01 00:00:00.00Z]
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "unauthorized" do
    test "can't get list of joins", %{conn: conn} do
      conn
      |> get(~p"/api/goals/some-goal-id/joins")
      |> response(401)
    end

    test "can't join to goals", %{conn: conn} do
      conn = post(conn, ~p"/api/goals/some-goal-id/join")
      response(conn, 401)

      conn = get(conn, ~p"/api/goals/some-goal-id/join")
      response(conn, 401)

      conn = delete(conn, ~p"/api/goals/some-goal-id/join")
      response(conn, 401)
    end
  end

  describe "index" do
    setup [:create_user_and_auth, :create_goal, :create_join]

    test "lists all current user goals", %{conn: conn, goal: %Goal{id: goal_id}} do
      conn = get(conn, ~p"/api/goals/#{goal_id}/joins")

      assert %{"goal_id" => ^goal_id} = List.first(json_response(conn, 200)["data"])
    end
  end

  describe "create join" do
    setup [:create_user_and_auth, :create_goal]

    test "renders join when data is valid", %{conn: conn, goal: %Goal{id: goal_id}} do
      conn = post(conn, ~p"/api/goals/#{goal_id}/join", join: @create_attrs)

      assert %{"goal_id" => ^goal_id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/goals/#{goal_id}/join")

      assert %{
               "goal_id" => ^goal_id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, goal: %Goal{id: goal_id}} do
      conn = post(conn, ~p"/api/goals/#{goal_id}/join", join: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update join" do
    setup [:create_user_and_auth, :create_goal, :create_join]

    test "renders join when data is valid", %{conn: conn, join: %Join{goal_id: goal_id}} do
      conn = put(conn, ~p"/api/goals/#{goal_id}/join", join: @update_attrs)

      assert %{"goal_id" => ^goal_id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/goals/#{goal_id}/join")

      assert %{
               "goal_id" => ^goal_id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, join: %Join{goal_id: goal_id}} do
      conn = put(conn, ~p"/api/goals/#{goal_id}/join", join: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete join" do
    setup [:create_user_and_auth, :create_goal, :create_join]

    test "deletes chosen join", %{conn: conn, join: %Join{goal_id: goal_id}} do
      conn = delete(conn, ~p"/api/goals/#{goal_id}/join")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/goals/#{goal_id}/join")
      end
    end
  end
end
