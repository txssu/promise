defmodule PromiseWeb.UserControllerTest do
  use PromiseWeb.ConnCase, async: true

  import Promise.AccountsFixtures

  alias Promise.Accounts.User

  @update_attrs %{
    first_name: "newfirstname",
    last_name: "newlastname",
    email: "some@updated.email",
    password: "newpasswrod",
    bio: "Some bio info",
    city: "London"
  }

  @invalid_attrs %{
    first_name: "With space",
    last_name: "With space",
    email: "wrong_email",
    password: "short"
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "unauthorized" do
    test "can't get", %{conn: conn} do
      conn = get(conn, ~p"/api/profile")

      assert response(conn, 401)
    end

    test "can't edit", %{conn: conn} do
      conn = put(conn, ~p"/api/profile")

      assert response(conn, 401)
    end

    test "can't delete", %{conn: conn} do
      conn = delete(conn, ~p"/api/profile")

      assert response(conn, 401)
    end
  end

  describe "show user" do
    setup [:create_user_and_auth]

    test "renders user", %{conn: conn, user: %User{id: id}} do
      conn = get(conn, ~p"/api/profile")
      assert %{
        "id" => ^id,
        "first_name" => _,
        "last_name" => _,
        "email" => _,
        "bio" => _,
        "city" => _,
        } = json_response(conn, 200)["data"]
    end
  end

  describe "update user" do
    setup [:create_user_and_auth]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id}} do
      conn = put(conn, ~p"/api/profile", user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/profile")

      assert %{
            "first_name" => "newfirstname",
            "last_name" => "newlastname",
            "email" => "some@updated.email",
            "bio" => "Some bio info",
            "city" => "London" } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = put(conn, ~p"/api/profile", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user_and_auth]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, ~p"/api/profile")
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, ~p"/api/users/#{user}")
      end)
    end
  end

  defp create_user_and_auth(%{conn: conn}) do
    user = user_fixture()
    conn = auth_user_by_password(conn, user)
    %{user: user, conn: conn}
  end
end
