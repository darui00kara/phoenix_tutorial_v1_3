defmodule ToyApp.Repo.Migrations.CreateToyApp.Accounts.User do
  use Ecto.Migration
  @disable_ddl_transaction true

  def change do
    create table(:accounts_users) do
      add :name, :string
      add :email, :string

      timestamps()
    end

    create unique_index :accounts_users, [:name],  concurrently: true
    create unique_index :accounts_users, [:email], concurrently: true
  end
end
