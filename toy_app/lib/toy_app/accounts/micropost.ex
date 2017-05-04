defmodule ToyApp.Accounts.Micropost do
  use Ecto.Schema

  schema "accounts_microposts" do
    field :content, :string
    belongs_to :user, ToyApp.Accounts.User

    timestamps()
  end
end
