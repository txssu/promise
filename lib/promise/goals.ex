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
  def list_goals(params \\ %{}) do
    Goal
    |> where([g], g.is_public == true)
    |> Flop.validate_and_run(params, for: Goal)
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

  def preload_goals(user) do
    user
    |> Repo.preload(:goals)
  end

  def get_goal_with_posts!(id) do
    query = from g in Goal,
            where: g.id == ^id,
            preload: [:posts]

    Repo.one!(query)
  end

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

  def load_subscriptions(%Goal{} = goal) do
    Repo.preload(goal, :user_subscriptions)
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
    query =
      from j in Join,
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

  alias Promise.Goals.Subscription

  def get_user_goal_subscription!(user, goal) do
    query =
      from s in Subscription,
        where: s.user_id == ^user.id and s.goal_id == ^goal.id

    Repo.one!(query)
  end

  @doc """
  Returns the list of goal_subscriptions.

  ## Examples

      iex> list_goal_subscriptions()
      [%Subscription{}, ...]

  """
  def list_goal_subscriptions do
    Repo.all(Subscription)
  end

  @doc """
  Gets a single subscription.

  Raises `Ecto.NoResultsError` if the Subscription does not exist.

  ## Examples

      iex> get_subscription!(123)
      %Subscription{}

      iex> get_subscription!(456)
      ** (Ecto.NoResultsError)

  """
  def get_subscription!(id), do: Repo.get!(Subscription, id)

  @doc """
  Creates a subscription.

  ## Examples

      iex> create_subscription(%{field: value})
      {:ok, %Subscription{}}

      iex> create_subscription(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_subscription(user, goal, _attrs \\ %{}) do
    user
    |> Repo.preload(:goal_subscriptions)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:goal_subscriptions, [goal])
    |> Repo.update!()
  end

  @doc """
  Updates a subscription.

  ## Examples

      iex> update_subscription(subscription, %{field: new_value})
      {:ok, %Subscription{}}

      iex> update_subscription(subscription, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_subscription(%Subscription{} = subscription, attrs) do
    subscription
    |> Subscription.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a subscription.

  ## Examples

      iex> delete_subscription(subscription)
      {:ok, %Subscription{}}

      iex> delete_subscription(subscription)
      {:error, %Ecto.Changeset{}}

  """
  def delete_subscription(%Subscription{} = subscription) do
    Repo.delete(subscription)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking subscription changes.

  ## Examples

      iex> change_subscription(subscription)
      %Ecto.Changeset{data: %Subscription{}}

  """
  def change_subscription(%Subscription{} = subscription, attrs \\ %{}) do
    Subscription.changeset(subscription, attrs)
  end

  alias Promise.Goals.Post

  @doc """
  Returns the list of goal_posts.

  ## Examples

      iex> list_goal_posts()
      [%Post{}, ...]

  """
  def list_goal_posts do
    Repo.all(Post)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(goal, attrs \\ %{}) do
    goal
    |> Ecto.build_assoc(:posts)
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end
end
