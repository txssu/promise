defmodule Promise.Repo.Migrations.CreateGoals do
  use Ecto.Migration

  def change do
    create table(:goals, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:goals, [:user_id])
  end
end
