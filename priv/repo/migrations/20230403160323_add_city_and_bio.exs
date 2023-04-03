defmodule Promise.Repo.Migrations.AddCityAndBio do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :bio, :string, size: 400
      add :city, :string, size: 20
    end
  end
end
