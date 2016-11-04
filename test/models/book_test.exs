defmodule Storybook.BookTest do
  use Storybook.ModelCase

  alias Storybook.Book

  @valid_attrs %{Publisher: "some content", authors: [], description: "some content", image_regular: "some content", image_thumbnail: "some content", isbn10: "some content", isbn13: "some content", published_date: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Book.changeset(%Book{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Book.changeset(%Book{}, @invalid_attrs)
    refute changeset.valid?
  end
end
