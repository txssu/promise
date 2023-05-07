defmodule Promise.Repo.Migrations.EditJoins do
  use Ecto.Migration

  def change do
    alter table(:goal_joins) do
      add :is_public, :boolean, null: false, default: false
      add :deadline, :utc_datetime
    end

    create unique_index(:goal_joins, [:user_id, :goal_id])
  end
end
