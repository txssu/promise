defmodule Promise.Repo.Migrations.CreateSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subscriptions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :object_id, references(:users, on_delete: :delete_all, type: :binary_id)
      add :subject_id, references(:users, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:subscriptions, [:object_id])
    create index(:subscriptions, [:subject_id])
    create unique_index(:subscriptions, [:object_id, :subject_id])
  end
end
