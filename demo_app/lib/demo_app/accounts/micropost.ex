defmodule DemoApp.Accounts.Micropost do
  use Ecto.Schema

  schema "accounts_microposts" do
    field :content, :string
    belongs_to :user, DemoApp.Accounts.User

    timestamps()
  end
end
