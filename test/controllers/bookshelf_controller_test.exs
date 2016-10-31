defmodule Storybook.BookshelfControllerTest do
  use Storybook.ConnCase

  alias Storybook.Bookshelf
  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, bookshelf_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing bookshelves"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, bookshelf_path(conn, :new)
    assert html_response(conn, 200) =~ "New bookshelf"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, bookshelf_path(conn, :create), bookshelf: @valid_attrs
    assert redirected_to(conn) == bookshelf_path(conn, :index)
    assert Repo.get_by(Bookshelf, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, bookshelf_path(conn, :create), bookshelf: @invalid_attrs
    assert html_response(conn, 200) =~ "New bookshelf"
  end

  test "shows chosen resource", %{conn: conn} do
    bookshelf = Repo.insert! %Bookshelf{}
    conn = get conn, bookshelf_path(conn, :show, bookshelf)
    assert html_response(conn, 200) =~ "Show bookshelf"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, bookshelf_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    bookshelf = Repo.insert! %Bookshelf{}
    conn = get conn, bookshelf_path(conn, :edit, bookshelf)
    assert html_response(conn, 200) =~ "Edit bookshelf"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    bookshelf = Repo.insert! %Bookshelf{}
    conn = put conn, bookshelf_path(conn, :update, bookshelf), bookshelf: @valid_attrs
    assert redirected_to(conn) == bookshelf_path(conn, :show, bookshelf)
    assert Repo.get_by(Bookshelf, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    bookshelf = Repo.insert! %Bookshelf{}
    conn = put conn, bookshelf_path(conn, :update, bookshelf), bookshelf: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit bookshelf"
  end

  test "deletes chosen resource", %{conn: conn} do
    bookshelf = Repo.insert! %Bookshelf{}
    conn = delete conn, bookshelf_path(conn, :delete, bookshelf)
    assert redirected_to(conn) == bookshelf_path(conn, :index)
    refute Repo.get(Bookshelf, bookshelf.id)
  end
end
