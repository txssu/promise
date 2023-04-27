defmodule Promise.Repo.Migrations.ChangeAllOnDelete do
  use Ecto.Migration

  def change do
    alter table(:goals) do
        modify :user_id, references(:users, on_delete: :delete_all, type: :binary_id),
          from: references(:users, on_delete: :nothing, type: :binary_id)
    end

    alter table(:goal_posts) do
      modify :goal_id, references(:goals, on_delete: :delete_all, type: :binary_id),
        from: references(:goals, on_delete: :nothing, type: :binary_id)
    end
  end
end
