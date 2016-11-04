defmodule Storybook.Repo.Migrations.CreateBookshelfBook do
  use Ecto.Migration

  def change do
    create table(:bookshelf_books) do
      add :bookshelf_id, references(:bookshelves, on_delete: :nothing)
      add :book_id, references(:books, on_delete: :nothing)

      timestamps()
    end
    create index(:bookshelf_books, [:bookshelf_id])
    create index(:bookshelf_books, [:book_id])

  end
end
