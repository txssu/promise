defmodule Promise.Repo.Migrations.CreateGoalJoins do
  use Ecto.Migration

  def change do
    create table(:goal_joins, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :goal_id, references(:goals, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:goal_joins, [:user_id])
    create index(:goal_joins, [:goal_id])
  end
end
