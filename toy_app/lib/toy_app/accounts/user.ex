defmodule ToyApp.Accounts.User do
  use Ecto.Schema

  schema "accounts_users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_digest, :string
    has_many :microposts, ToyApp.Accounts.Micropost

    timestamps()
  end
end
