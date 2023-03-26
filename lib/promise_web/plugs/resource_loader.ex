defmodule PromiseWeb.Plugs.ResourceLoader do
  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    key = Keyword.fetch!(opts, :key)
    loader = Keyword.fetch!(opts, :loader)

    resource = loader.load(conn, opts)

    assign(conn, key, resource)
  end
end
