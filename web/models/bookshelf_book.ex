defmodule Storybook.BookshelfBook do
  use Storybook.Web, :model

  @primary_key false
  schema "bookshelf_books" do
    belongs_to :bookshelf, Storybook.Bookshelf
    belongs_to :book, Storybook.Book

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:bookshelf_id, :book_id])
    |> validate_required([:bookshelf_id, :book_id])
  end
end
