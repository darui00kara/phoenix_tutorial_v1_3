defmodule ToyApp.Repo.Migrations.CreateToyApp.Accounts.Micropost do
  use Ecto.Migration

  def change do
    create table(:accounts_microposts) do
      add :content, :string, null: false
      add :user_id, references(:accounts_users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:accounts_microposts, [:user_id])
  end
end
