defmodule Promise.Setups do
  import Promise.AccountsFixtures
  import Promise.GoalsFixtures

  def create_user_and_auth(%{conn: conn}) do
    user = user_fixture()
    conn = auth_user_by_password(conn, user)
    %{user: user, conn: conn}
  end

  def create_goal(%{user: user}) do
    %{goal: goal_fixture(user)}
  end

  def create_post(%{goal: goal}) do
    %{post: post_fixture(goal)}
  end
end
