defmodule MotivNation.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MotivNationWeb.Telemetry,
      # Start the Ecto repository
      MotivNation.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: MotivNation.PubSub},
      # Start Finch
      {Finch, name: MotivNation.Finch},
      # Start the Endpoint (http/https)
      MotivNationWeb.Endpoint
      # Start a worker by calling: MotivNation.Worker.start_link(arg)
      # {MotivNation.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MotivNation.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MotivNationWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
