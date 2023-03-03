defmodule MotivNationWeb.Auth do
  alias MotivNation.Accounts
  alias MotivNation.Guardian

  import Plug.Conn

  def ensure_authorized(conn, _opts) do
    if conn.assigns[:current_user] do
      conn
    else
      halt_unauthorized(conn)
    end
  end

  def fetch_current_user(conn, _opts) do
    with {:get_auth, [auth_data]} <- {:get_auth, get_req_header(conn, "authorization")},
         {:fetch_token, {:ok, token}} <- {:fetch_token, fetch_token(auth_data)},
         {:fetch_claims, {:ok, %{"sub" => user_id}}} <-
           {:fetch_claims, Guardian.decode_and_verify(token)},
         user = Accounts.get_user(user_id) do
      assign(conn, :current_user, user)
    else
      {:get_auth, _} -> assign(conn, :current_user, nil)
      {error, _} when error in [:fetch_token, :fetch_claims] -> server_error(conn)
    end
  end

  defp fetch_token("Bearer " <> token), do: {:ok, token}
  defp fetch_token(_token), do: :error

  defp halt_unauthorized(conn) do
    conn
    |> send_resp(401, "Unauthorized")
    |> halt()
  end

  defp server_error(conn) do
    conn
    |> send_resp(500, "Internal server error")
    |> halt()
  end
end
