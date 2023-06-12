defmodule PromiseWeb.SubscriptionController do
  use PromiseWeb, :controller

  alias Promise.Accounts
  alias Promise.Accounts.Subscription

  alias PromiseWeb.Loaders

  plug PromiseWeb.Plugs.ResourceLoader,
    key: :subject,
    loader: Loaders.CurrentUserLoader

  plug PromiseWeb.Plugs.ResourceLoader,
    key: :object,
    loader: Loaders.GenLoader,
    resource: {Accounts, :get_user!}

  action_fallback PromiseWeb.FallbackController

  def index(conn, _params) do
    %{subject: subject, object: object} = conn.assigns

    Accounts.get_subscription(subject, object)

    send_resp(conn, :ok, "")
  end

  def create(conn, _params) do
    %{subject: subject, object: object} = conn.assigns

    with {:ok, %Subscription{}} <- Accounts.subscribe(subject, object) do
      send_resp(conn, :created, "")
    end
  end

  def delete(conn, _params) do
    %{subject: subject, object: object} = conn.assigns

    with {:ok, %Subscription{}} <- Accounts.unsubscribe(subject, object) do
      send_resp(conn, :no_content, "")
    end
  end
end
