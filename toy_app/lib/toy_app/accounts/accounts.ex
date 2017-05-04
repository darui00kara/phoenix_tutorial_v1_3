defmodule ToyApp.Accounts do
  @moduledoc """
  The boundary for the Accounts system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias ToyApp.Repo

  alias ToyApp.Accounts.{User, Micropost}
  alias ToyApp.Helpers.Encryption
  alias ToyApp.Helpers.Signin

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> user_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> user_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    user_changeset(user, %{})
  end

  defp user_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :password_digest])
    |> validate_required([:name, :email, :password])
    |> validate_format(:email, ~r/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
    |> unique_constraint(:name)
    |> unique_constraint(:email)
    |> validate_length(:name, min: 1)
    |> validate_length(:email, max: 50)
    |> set_user_password_digest
  end

  def set_user_password_digest(changeset) do
    password = get_change changeset, :password

    case password do
      nil ->
        changeset
        _ ->
        changeset |> put_change(:password_digest, password |> Encryption.encrypt)
    end
  end

  def user_signin(email, password) do
    Repo.get_by(User, email: email) |> Signin.check(password)
  end

  def pagenate_list_users(params) do
    from(u in User, order_by: [asc: :name])
    |> Repo.paginate(params)
  end

  def change_micropost(%Micropost{} = micropost) do
    micropost_changeset(micropost, %{})
  end

  defp micropost_changeset(%Micropost{} = micropost, attrs) do
    micropost
    |> cast(attrs, [:content, :user_id])
    |> validate_required([:content, :user_id])
    |> validate_length(:content, min: 1)
    |> validate_length(:content, max: 140)
  end

  defp build_micropost(user, content) do
    Ecto.build_assoc(user, :microposts, content: content)
  end

  def create_micropost(user, content) do
    build_micropost(user, content)
    |> change_micropost
    |> Repo.insert
  end

  def delete_micropost(%Micropost{} = micropost) do
    Repo.delete(micropost)
  end

  def get_micropost!(id) do
    Repo.get! Micropost, id
  end

  ## def assoc_post(user) do
  ##   Ecto.assoc(user, :microposts) |> Repo.all
  ## end

  def paginate_assoc_posts(user, params) do
    from(m in Micropost,
      where: m.user_id == ^user.id,
        order_by: [desc: :inserted_at])
    |> Repo.paginate(params)
  end
end
