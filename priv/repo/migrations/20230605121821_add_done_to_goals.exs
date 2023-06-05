defmodule Promise.Repo.Migrations.AddDoneToGoals do
  use Ecto.Migration

  def change do
    alter table(:goals) do
      add :done, :boolean, null: false, default: false
    end
  end
end
