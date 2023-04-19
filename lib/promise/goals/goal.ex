defmodule Promise.Goals.Goal do
  alias Promise.Accounts.User
  alias Promise.Goals.Join
  alias Promise.Goals.Subscription
  alias Promise.Goals.Post

  use Ecto.Schema
  import Ecto.Changeset
  import EctoCommons.DateTimeValidator

  require PromiseWeb.Gettext

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "goals" do
    field :title, :string
    field :deadline, :utc_datetime

    belongs_to :user, User

    many_to_many :user_joins, User, join_through: Join
    many_to_many :user_subscriptions, User, join_through: Subscription

    has_many :posts, Post

    timestamps()
  end

  @doc false
  def changeset(goal, attrs) do
    goal
    |> cast(attrs, [:title, :deadline])
    |> validate_deadline()
    |> validate_required([:title])
    |> validate_length(:title, max: 255)
  end

  def validate_deadline(changeset) do
    changeset
    |> validate_required([:deadline])
    |> validate_datetime(:deadline, after: :utc_now, message: PromiseWeb.Gettext.dgettext("errors", "should be after %{after}."))
  end
end
