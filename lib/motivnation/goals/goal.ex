defmodule Motivnation.Goals.Goal do
  alias Motivnation.Accounts.User
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "goals" do
    field :title, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(goal, attrs) do
    goal
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
