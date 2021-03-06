defmodule Storybook.BookControllerTest do
  use Storybook.ConnCase

  alias Storybook.Book
  @valid_attrs %{Publisher: "some content", authors: [], description: "some content", image_regular: "some content", image_thumbnail: "some content", isbn10: "some content", isbn13: "some content", published_date: "some content", title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, book_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing books"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, book_path(conn, :create), book: @valid_attrs
    assert redirected_to(conn) == book_path(conn, :index)
    assert Repo.get_by(Book, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, book_path(conn, :create), book: @invalid_attrs
    assert html_response(conn, 200) =~ "New book"
  end

  test "shows chosen resource", %{conn: conn} do
    book = Repo.insert! %Book{}
    conn = get conn, book_path(conn, :show, book)
    assert html_response(conn, 200) =~ "Show book"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, book_path(conn, :show, -1)
    end
  end
end
