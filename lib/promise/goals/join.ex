defmodule Promise.Goals.Join do
  use Ecto.Schema
  import Ecto.Changeset

  alias Promise.Accounts.User
  alias Promise.Goals.Goal

  require PromiseWeb.Gettext

  @derive {
    Flop.Schema,
    filterable: [],
    sortable: [:inserted_at],
    default_limit: 20,
    max_limit: 100,
    default_order: %{
      order_by: [:inserted_at],
      order_directions: [:desc]
    }
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "goal_joins" do
    field :deadline, :utc_datetime
    field :is_public, :boolean

    belongs_to :user, User
    belongs_to :goal, Goal

    timestamps()
  end

  @doc false
  def changeset(join, attrs) do
    join
    |> cast(attrs, [:deadline, :is_public])
    |> unique_constraint([:user_id, :goal_id],
      message: PromiseWeb.Gettext.dgettext("errors", "user has already been joined")
    )
    |> Goal.validate_deadline()
    |> validate_required([:is_public])
  end
end
