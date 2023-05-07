defmodule Promise.Repo.Migrations.ChangeOnDeleteInJoins do
  use Ecto.Migration

  def change do
    alter table(:goal_joins) do
      modify :user_id, references(:users, on_delete: :delete_all, type: :binary_id),
        from: references(:users, on_delete: :nothing, type: :binary_id)

      modify :goal_id, references(:goals, on_delete: :delete_all, type: :binary_id),
        from: references(:goals, on_delete: :nothing, type: :binary_id)
    end
  end
end
