defmodule Storybook.BookshelfBookTest do
  use Storybook.ModelCase

  alias Storybook.BookshelfBook

  @valid_attrs %{bookshelf_id: 1, book_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = BookshelfBook.changeset(%BookshelfBook{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = BookshelfBook.changeset(%BookshelfBook{}, @invalid_attrs)
    refute changeset.valid?
  end
end
