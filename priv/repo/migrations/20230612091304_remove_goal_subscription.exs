defmodule Promise.Repo.Migrations.RemoveGoalSubscription do
  use Ecto.Migration

  def change do
    drop table(:goal_subscriptions)
  end
end
