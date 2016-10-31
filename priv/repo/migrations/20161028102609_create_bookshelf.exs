defmodule Storybook.Repo.Migrations.CreateBookshelf do
  use Ecto.Migration

  def change do
    create table(:bookshelves) do
      add :name, :string
      add :description, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
    create index(:bookshelves, [:user_id])

  end
end
