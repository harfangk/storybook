defmodule Storybook.UserBookTest do
  use Storybook.ModelCase

  alias Storybook.UserBook

  @valid_attrs %{user_id: 1, book_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserBook.changeset(%UserBook{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserBook.changeset(%UserBook{}, @invalid_attrs)
    refute changeset.valid?
  end
end
