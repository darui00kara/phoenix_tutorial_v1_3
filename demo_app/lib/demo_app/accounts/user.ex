defmodule DemoApp.Accounts.User do
  use Ecto.Schema

  schema "accounts_users" do
    field :email, :string
    field :name, :string

    has_many :microposts, DemoApp.Accounts.Micropost

    timestamps()
  end
end
