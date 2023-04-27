defmodule Promise.Repo.Migrations.AddIsPublicToGoals do
  use Ecto.Migration

  def change do
    alter table(:goals) do
      add :is_public, :boolean, null: false, default: false
    end
  end
end
