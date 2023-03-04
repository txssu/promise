defmodule MotivNationWeb.AuthErrorHandler do
  @moduledoc false
  @behaviour Guardian.Plug.ErrorHandler

  import Plug.Conn

  @impl true
  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> send_resp(:unauthorized, [])
    |> halt()
  end
end
