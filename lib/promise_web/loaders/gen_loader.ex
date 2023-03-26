defmodule PromiseWeb.Loaders.GenLoader do
  @callback load(Plug.Conn.t(), keyword()) :: term()

  def load(conn, opts) do
    {context, fun} = Keyword.fetch!(opts, :resource)
    param_key = Keyword.get(opts, :param_key, "id")
    resource_id = conn.params[param_key]

    apply(context, fun, [resource_id])
  end
end
