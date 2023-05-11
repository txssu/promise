defmodule PromiseWeb.PostControllerTest do
  use PromiseWeb.ConnCase

  import Promise.Setups

  alias Promise.Goals.Post

  @create_attrs %{
    text: "some text"
  }
  @update_attrs %{
    text: "some updated text"
  }
  @invalid_attrs %{
    text: ""
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "unauthorized" do
    test "can't get list of posts", %{conn: conn} do
      conn
      |> get(~p"/api/goals/some-goal-id/posts")
      |> response(401)
    end

    test "can't create post", %{conn: conn} do
      conn
      |> post(~p"/api/goals/some-goal-id/posts")
      |> response(401)
    end

    test "can't access certain post", %{conn: conn} do
      conn = get(conn, ~p"/api/goals/some-goal-id/posts/post-id")
      response(conn, 401)

      conn = put(conn, ~p"/api/goals/some-goal-id/posts/post-id")
      response(conn, 401)

      conn = delete(conn, ~p"/api/goals/some-goal-id/posts/post-id")
      response(conn, 401)
    end
  end

  describe "index" do
    setup [:create_user_and_auth, :create_goal, :create_post]

    test "lists all goal_posts", %{conn: conn, goal: goal, post: %Post{id: id}} do
      conn = get(conn, ~p"/api/goals/#{goal}/posts")

      assert %{"id" => ^id} = List.first(json_response(conn, 200)["data"])
    end
  end

  describe "create post" do
    setup [:create_user_and_auth, :create_goal]

    test "renders post when data is valid", %{conn: conn, goal: goal} do
      conn = post(conn, ~p"/api/goals/#{goal}/posts", post: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn,~p"/api/goals/#{goal}/posts/#{id}")

      assert %{
               "id" => ^id,
               "text" => "some text"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, goal: goal} do
      conn = post(conn, ~p"/api/goals/#{goal}/posts", post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update post" do
    setup [:create_user_and_auth, :create_goal, :create_post]

    test "renders post when data is valid", %{conn: conn, goal: goal, post: %Post{id: id} = post} do
      conn = put(conn, ~p"/api/goals/#{goal}/posts/#{post}", post: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/goals/#{goal}/posts/#{post}")

      assert %{
               "id" => ^id,
               "text" => "some updated text"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, goal: goal, post: post} do
      conn = put(conn, ~p"/api/goals/#{goal}/posts/#{post}", post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete post" do
    setup [:create_user_and_auth, :create_goal, :create_post]

    test "deletes chosen post", %{conn: conn, goal: goal, post: post} do
      conn = delete(conn, ~p"/api/goals/#{goal}/posts/#{post}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/goals/#{goal}/posts/#{post}")
      end
    end
  end
end
