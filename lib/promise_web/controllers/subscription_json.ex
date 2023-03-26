defmodule PromiseWeb.SubscriptionJSON do
  alias Promise.Goals.Subscription

  @doc """
  Renders a list of goal_subscriptions.
  """
  def index(%{goal_subscriptions: goal_subscriptions}) do
    %{data: for(subscription <- goal_subscriptions, do: data(subscription))}
  end

  @doc """
  Renders a single subscription.
  """
  def show(%{subscription: subscription}) do
    %{data: data(subscription)}
  end

  defp data(%Subscription{} = subscription) do
    %{
      id: subscription.id
    }
  end
end
