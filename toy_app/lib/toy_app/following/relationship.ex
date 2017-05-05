defmodule ToyApp.Following.Relationship do
  use Ecto.Schema

  schema "following_relationships" do
    # follow user
    belongs_to :followed_user, ToyApp.Accounts.User, foreign_key: :follower_id
    # follower user
    belongs_to :follower, ToyApp.Accounts.User, foreign_key: :followed_id

    timestamps()
  end
end
