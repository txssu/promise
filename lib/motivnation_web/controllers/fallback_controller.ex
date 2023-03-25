defmodule MotivnationWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use MotivnationWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: MotivnationWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :not_goal_author}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(html: MotivnationWeb.ErrorHTML, json: MotivnationWeb.ErrorJSON)
    |> render(:unauthorized)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: MotivnationWeb.ErrorHTML, json: MotivnationWeb.ErrorJSON)
    |> render(:"404")
  end
end
