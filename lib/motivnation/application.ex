defmodule Motivnation.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MotivnationWeb.Telemetry,
      # Start the Ecto repository
      Motivnation.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Motivnation.PubSub},
      # Start Finch
      {Finch, name: Motivnation.Finch},
      # Start the Endpoint (http/https)
      MotivnationWeb.Endpoint
      # Start a worker by calling: Motivnation.Worker.start_link(arg)
      # {Motivnation.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Motivnation.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MotivnationWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
