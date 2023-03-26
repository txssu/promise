defmodule Promise.Repo.Migrations.CreateGoalSubscriptions do
  use Ecto.Migration

  def change do
    create table(:goal_subscriptions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :goal_id, references(:goals, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:goal_subscriptions, [:user_id])
    create index(:goal_subscriptions, [:goal_id])
  end
end
