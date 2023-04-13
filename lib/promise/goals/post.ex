defmodule Promise.Goals.Post do
  use Ecto.Schema
  alias Promise.Goals.Goal
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "goal_posts" do
    field :text, :string

    belongs_to :goal, Goal

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:text])
    |> validate_required([:text])
    |> validate_length(:text, max: 2000)
  end
end
