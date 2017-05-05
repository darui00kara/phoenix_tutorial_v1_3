defmodule ToyApp.Repo.Migrations.CreateToyApp.Accounts.Relationship do
  use Ecto.Migration
  @disable_ddl_transaction true

  def change do
    create table(:following_relationships) do
      add :follower_id, references(:accounts_users, on_delete: :nothing), null: false
      add :followed_id, references(:accounts_users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:following_relationships, [:follower_id], concurrently: true)
    create index(:following_relationships, [:followed_id], concurrently: true)
    create index(:following_relationships, [:follower_id, :followed_id], unique: true, concurrently: true)
  end
end
