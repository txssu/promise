defmodule Promise.Goals.Goal do
  alias Promise.Accounts.User
  alias Promise.Goals.Join
  alias Promise.Goals.Subscription
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "goals" do
    field :title, :string

    belongs_to :user, User

    many_to_many :user_joins, User, join_through: Join
    many_to_many :user_subscriptions, User, join_through: Subscription

    timestamps()
  end

  @doc false
  def changeset(goal, attrs) do
    goal
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
