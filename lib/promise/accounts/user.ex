defmodule Promise.Accounts.User do
  @moduledoc false
  alias __MODULE__
  alias Promise.Goals.Goal
  alias Promise.Goals.Join
  alias Promise.Accounts.Subscription
  use Ecto.Schema
  import Ecto.Changeset

  @derive {
    Flop.Schema,
    filterable: [], sortable: [:inserted_at], default_limit: 5, max_limit: 20
  }

  @basic_keys [
    :first_name,
    :last_name,
    :bio,
    :city,
    :email
  ]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :bio, :string
    field :city, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :goals, Goal

    many_to_many :goal_joins, Goal, join_through: Join
    many_to_many :subscriptions, User, join_through: Subscription, join_keys: [subject_id: :id, object_id: :id]

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @basic_keys)
    |> basic_pipe()
  end

  def registration(user, attrs) do
    user
    |> cast(attrs, [:password | @basic_keys])
    |> basic_pipe()
    |> validate_password()
    |> put_password_hash()
  end

  defp basic_pipe(changeset) do
    changeset
    |> validate_names()
    |> validate_email()
    |> validate_city()
    |> validate_bio()
  end

  defp validate_names(changeset) do
    changeset
    |> validate_name(:first_name)
    |> validate_name(:last_name)
  end

  defp validate_name(changeset, key) do
    changeset
    |> validate_required([key])
    |> validate_format(key, ~r/^[\p{L}\-']+$/u)
    |> validate_length(key, max: 20)
  end

  defp validate_city(changeset) do
    changeset
    |> validate_format(:city, ~r/^[\p{L}\-']+$/u)
    |> validate_length(:city, max: 20)
  end

  defp validate_bio(changeset) do
    changeset
    |> validate_change(:bio, fn :bio, text ->
      if String.starts_with?(text, [" ", "\n"]) or String.ends_with?(text, [" ", "\n"]) do
        [bio: "Cannot contains trailing or leading spaces"]
      else
        []
      end
    end)
    |> validate_length(:bio, max: 500)
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/.+@.+/u)
    |> unique_constraint(:email)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 8)
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ),
       do: change(changeset, Argon2.add_hash(password))

  defp put_password_hash(changeset), do: changeset
end
