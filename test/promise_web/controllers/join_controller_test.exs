defmodule PromiseWeb.JoinControllerTest do
  use PromiseWeb.ConnCase

  import Promise.GoalsFixtures

  alias Promise.Goals.Join

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all goal_joins", %{conn: conn} do
      conn = get(conn, ~p"/api/goal_joins")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create join" do
    test "renders join when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/goal_joins", join: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/goal_joins/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/goal_joins", join: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update join" do
    setup [:create_join]

    test "renders join when data is valid", %{conn: conn, join: %Join{id: id} = join} do
      conn = put(conn, ~p"/api/goal_joins/#{join}", join: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/goal_joins/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, join: join} do
      conn = put(conn, ~p"/api/goal_joins/#{join}", join: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete join" do
    setup [:create_join]

    test "deletes chosen join", %{conn: conn, join: join} do
      conn = delete(conn, ~p"/api/goal_joins/#{join}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/goal_joins/#{join}")
      end
    end
  end

  defp create_join(_) do
    join = join_fixture()
    %{join: join}
  end
end
