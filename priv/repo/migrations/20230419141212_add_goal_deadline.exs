defmodule Promise.Repo.Migrations.AddGoalDeadline do
  use Ecto.Migration

  def change do
    alter table(:goals) do
      add :deadline, :utc_datetime
    end
  end
end
