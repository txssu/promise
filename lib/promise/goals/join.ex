defmodule Promise.Goals.Join do
  use Ecto.Schema
  import Ecto.Changeset

  alias Promise.Accounts.User
  alias Promise.Goals.Goal

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
