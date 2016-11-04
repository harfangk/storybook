defmodule Storybook.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string, null: false
      add :authors, {:array, :string}
      add :publisher, :string
      add :published_date, :string
      add :description, :string
      add :isbn10, :string
      add :isbn13, :string
      add :image_thumbnail, :string
      add :image_regular, :string

      timestamps()
    end
    create index(:books, [:isbn10])
    create index(:books, [:isbn13])

  end
end
