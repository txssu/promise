defmodule Promise.Goals do
  @moduledoc """
  The Goals context.
  """

  import Ecto.Query, warn: false
  alias Promise.Repo

  alias Promise.Goals.Goal

  @doc """
  Returns the list of goals.

  ## Examples

      iex> list_goals()
      [%Goal{}, ...]

  """
  def list_goals do
    Repo.all(Goal)
  end

  @doc """
  Gets a single goal.

  Raises `Ecto.NoResultsError` if the Goal does not exist.

  ## Examples

      iex> get_goal!(123)
      %Goal{}

      iex> get_goal!(456)
      ** (Ecto.NoResultsError)

  """
  def get_goal!(id), do: Repo.get!(Goal, id)
  def get_goal(id), do: Repo.get(Goal, id)

  @doc """
  Creates a goal.

  ## Examples

      iex> create_goal(%{field: value})
      {:ok, %Goal{}}

      iex> create_goal(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_goal(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:goals)
    |> Goal.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a goal.

  ## Examples

      iex> update_goal(goal, %{field: new_value})
      {:ok, %Goal{}}

      iex> update_goal(goal, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_goal(%Goal{} = goal, attrs) do
    goal
    |> Goal.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a goal.

  ## Examples

      iex> delete_goal(goal)
      {:ok, %Goal{}}

      iex> delete_goal(goal)
      {:error, %Ecto.Changeset{}}

  """
  def delete_goal(%Goal{} = goal) do
    Repo.delete(goal)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking goal changes.

  ## Examples

      iex> change_goal(goal)
      %Ecto.Changeset{data: %Goal{}}

  """
  def change_goal(%Goal{} = goal, attrs \\ %{}) do
    Goal.changeset(goal, attrs)
  end

  def load_joins(%Goal{} = goal) do
    Repo.preload(goal, :user_joins)
  end

  alias Promise.Goals.Join

  @doc """
  Returns the list of goal_joins.

  ## Examples

      iex> list_goal_joins()
      [%Join{}, ...]

  """
  def list_goal_joins do
    Repo.all(Join)
  end

  @doc """
  Gets a single join.

  Raises `Ecto.NoResultsError` if the Join does not exist.

  ## Examples

      iex> get_join!(123)
      %Join{}

      iex> get_join!(456)
      ** (Ecto.NoResultsError)

  """
  def get_join!(id), do: Repo.get!(Join, id)

  def get_user_goal_join!(user, goal) do
    query = from j in Join,
      where: j.user_id == ^user.id and j.goal_id == ^goal.id

    Repo.one!(query)
  end

  @doc """
  Creates a join.

  ## Examples

      iex> create_join(%{field: value})
      {:ok, %Join{}}

      iex> create_join(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_join(user, goal, _attrs \\ %{}) do
    user
    |> Repo.preload(:goal_joins)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:goal_joins, [goal])
    |> Repo.update!()
  end

  @doc """
  Updates a join.

  ## Examples

      iex> update_join(join, %{field: new_value})
      {:ok, %Join{}}

      iex> update_join(join, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_join(%Join{} = join, attrs) do
    join
    |> Join.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a join.

  ## Examples

      iex> delete_join(join)
      {:ok, %Join{}}

      iex> delete_join(join)
      {:error, %Ecto.Changeset{}}

  """
  def delete_join(%Join{} = join) do
    Repo.delete(join)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking join changes.

  ## Examples

      iex> change_join(join)
      %Ecto.Changeset{data: %Join{}}

  """
  def change_join(%Join{} = join, attrs \\ %{}) do
    Join.changeset(join, attrs)
  end
end
