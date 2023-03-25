defmodule MotivnationWeb.Loaders.CurrentUserLoader do
  alias MotivnationWeb.Loaders.GenLoader
  @behaviour GenLoader

  @impl true
  def load(conn, _opts) do
    Guardian.Plug.current_resource(conn, key: :motivnation)
  end
end
