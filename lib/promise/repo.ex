defmodule Promise.Repo do
  use Ecto.Repo,
    otp_app: :promise,
    adapter: Ecto.Adapters.Postgres
end
