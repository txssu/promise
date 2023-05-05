defmodule PromiseWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use PromiseWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: PromiseWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :not_goal_author}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(html: PromiseWeb.ErrorHTML, json: PromiseWeb.ErrorJSON)
    |> render(:unauthorized)
  end

  def call(conn, {:error, %Flop.Meta{}}) do
    send_resp(conn, :unprocessable_entity, "")
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: PromiseWeb.ErrorHTML, json: PromiseWeb.ErrorJSON)
    |> render(:"404")
  end
end
