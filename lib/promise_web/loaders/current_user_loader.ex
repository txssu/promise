defmodule PromiseWeb.Loaders.CurrentUserLoader do
  alias PromiseWeb.Loaders.GenLoader
  @behaviour GenLoader

  @impl true
  def load(conn, _opts) do
    Guardian.Plug.current_resource(conn, key: :promise)
  end
end
