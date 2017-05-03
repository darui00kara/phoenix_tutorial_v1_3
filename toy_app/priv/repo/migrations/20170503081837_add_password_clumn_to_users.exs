defmodule ToyApp.Repo.Migrations.AddPasswordClumnToUsers do
  use Ecto.Migration

  def change do
    alter table(:accounts_users) do
      add :password, :string
      add :password_digest, :string, null: false
    end
  end
end
