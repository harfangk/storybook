defmodule Storybook.BookshelfTest do
  use Storybook.ModelCase

  alias Storybook.Bookshelf

  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Bookshelf.changeset(%Bookshelf{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Bookshelf.changeset(%Bookshelf{}, @invalid_attrs)
    refute changeset.valid?
  end
end
