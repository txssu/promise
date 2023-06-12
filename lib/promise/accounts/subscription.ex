defmodule Promise.Accounts.Subscription do
  alias Promise.Accounts.User
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "subscriptions" do
    belongs_to :object, User
    belongs_to :subject, User

    timestamps()
  end

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [])
    |> validate_required([])
    |> unique_constraint([:object_id, :subject_id])
  end
end
