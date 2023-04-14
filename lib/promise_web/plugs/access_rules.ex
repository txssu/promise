defmodule PromiseWeb.Plugs.AccessRules do
  import Plug.Conn
  import Phoenix.Controller

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    rule = Keyword.fetch!(opts, :rule)

    apply(__MODULE__, rule, [conn, opts])
  end

  def owner_only(conn, opts) do
    resource_key = Keyword.fetch!(opts, :resource_key)

    %{:current_user => user, ^resource_key => resource} = conn.assigns

    if user.id == resource.user_id do
      conn
    else
      conn
      |> put_status(:forbidden)
      |> put_view(json: PromiseWeb.ErrorJSON)
      |> render("403.json", message: "You are not the owner of the resource")
      |> halt()
    end
  end
end
