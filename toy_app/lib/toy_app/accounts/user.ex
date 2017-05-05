defmodule ToyApp.Accounts.User do
  use Ecto.Schema

  schema "accounts_users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_digest, :string

    # Having Micropost
    has_many :microposts, ToyApp.Accounts.Micropost

    # follow user
    has_many :followed_users, ToyApp.Following.Relationship, foreign_key: :follower_id
    has_many :relationships, through: [:followed_users, :followed_user]

    # follower user
    has_many :followers, ToyApp.Following.Relationship, foreign_key: :followed_id
    has_many :reverse_relationships, through: [:followers, :follower]

    timestamps()
  end
end
