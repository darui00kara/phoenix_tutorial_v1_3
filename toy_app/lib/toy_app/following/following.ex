defmodule ToyApp.Following do
  @moduledoc """
  The boundary for the Following system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias ToyApp.Repo

  alias ToyApp.Following.Relationship

  def follow!(signin_id, followed_id) do
    create_relationship(%{follower_id: signin_id, followed_id: followed_id})
  end

  def following?(signin_id, followed_id) do
    relationship = get_relationship(signin_id, followed_id)
    not is_nil(relationship)
  end

  def unfollow!(signin_id, followed_id) do
    get_relationship(signin_id, followed_id)
    |> delete_relationship
  end

  def get_relationship(signin_id, followed_id) do
    query = from(r in Relationship,
              where: r.follower_id == ^signin_id
                 and r.followed_id == ^followed_id,
              limit: 1)

    case Repo.all(query) do
      [relationship] -> relationship
                   _ -> nil
    end
  end

  defp relationship_changeset(%Relationship{} = relationship, attrs) do
    relationship
    |> cast(attrs, [:follower_id, :followed_id])
    |> validate_required([:follower_id, :followed_id])
  end

  defp create_relationship(attrs) do
    %Relationship{}
    |> relationship_changeset(attrs)
    |> Repo.insert()
  end

  defp delete_relationship(%Relationship{} = relationship) do
    Repo.delete(relationship)
  end
end
