defmodule Promise.Goals.Join do
  use Ecto.Schema
  import Ecto.Changeset

  alias Promise.Accounts.User
  alias Promise.Goals.Goal

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
    belongs_to :user, User
    belongs_to :goal, Goal

    timestamps()
  end

  @doc false
  def changeset(join, attrs) do
    join
    |> cast(attrs, [])
    |> validate_required([])
  end
end
