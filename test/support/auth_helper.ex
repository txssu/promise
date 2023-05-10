defmodule Promise.AuthHelper do
  import Promise.AccountsFixtures

  def create_user_and_auth(%{conn: conn}) do
    user = user_fixture()
    conn = auth_user_by_password(conn, user)
    %{user: user, conn: conn}
  end
end
