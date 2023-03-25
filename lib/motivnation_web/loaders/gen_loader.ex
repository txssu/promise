defmodule MotivnationWeb.Loaders.GenLoader do
  @callback load(Plug.Conn.t(), keyword()) :: term()

  def load(conn, opts) do
    {context, fun} = Keyword.fetch!(opts, :resource)
    resource_id = conn.params["id"]

    apply(context, fun, [resource_id])
  end
end
