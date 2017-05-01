defmodule DemoApp.Repo.Migrations.CreateDemoApp.Accounts.Micropost do
  use Ecto.Migration

  def change do
    create table(:accounts_microposts) do
      add :content, :string
      add :user_id, references(:accounts_users, on_delete: :nothing)

      timestamps()
    end

    create index(:accounts_microposts, [:user_id])
  end
end
