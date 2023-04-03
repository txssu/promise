defmodule Promise.Repo.Migrations.ChangeUsernamesSize do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :first_name, :string, size: 20
      modify :last_name, :string, size: 20
    end
  end
end
