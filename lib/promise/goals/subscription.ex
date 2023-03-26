defmodule Promise.Goals.Subscription do
  alias Promise.Accounts.User
  alias Promise.Goals.Goal
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "goal_subscriptions" do
    belongs_to :user, User
    belongs_to :goal, Goal

    timestamps()
  end

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [])
    |> validate_required([])
  end
end
