defmodule Motivnation.Repo do
  use Ecto.Repo,
    otp_app: :motivnation,
    adapter: Ecto.Adapters.Postgres
end
