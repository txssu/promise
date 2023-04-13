defmodule Promise.Repo.Migrations.CreateGoalPosts do
  use Ecto.Migration

  def change do
    create table(:goal_posts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :text, :string, size: 2000
      add :goal_id, references(:goals, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:goal_posts, [:goal_id])
  end
end
