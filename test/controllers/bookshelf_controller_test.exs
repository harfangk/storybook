defmodule Storybook.BookshelfControllerTest do
  use Storybook.ConnCase
  import Storybook.Factory

  alias Storybook.Bookshelf
  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{description: "some content", name: nil}

  setup %{conn: conn} = config do
    if username = config[:login_as] do
      user = insert(:user, %{username: username})
      conn = assign(build_conn(), :current_user, user)
      {:ok, conn: conn, user: user}
    else
      {:ok, conn: conn}
    end
  end

  @tag login_as: "foxy"
  test "lists all of current_user's bookshelves on index", %{conn: conn, user: user} do
    user_bookshelf = insert(:bookshelf, %{user: user})
    other_bookshelf = insert(:bookshelf)

    conn = get conn, user_bookshelf_path(conn, :index, user)
    assert html_response(conn, 200) =~ "Listing bookshelves"
    assert String.contains?(conn.resp_body, user_bookshelf.name)
    refute String.contains?(conn.resp_body, other_bookshelf.name)
  end

  @tag login_as: "foxy"
  test "renders form for new resources", %{conn: conn, user: user} do
    conn = get conn, user_bookshelf_path(conn, :new, user.id)
    assert html_response(conn, 200) =~ "New bookshelf"
  end

  @tag login_as: "foxy"
  test "creates resource and redirects when data is valid", %{conn: conn, user: user} do
    conn = post conn, user_bookshelf_path(conn, :create, user.id), bookshelf: @valid_attrs
    assert redirected_to(conn) == user_bookshelf_path(conn, :index, user.id)
    assert Repo.get_by(Bookshelf, @valid_attrs)
  end

  @tag login_as: "foxy"
  test "does not create resource and renders errors when data is invalid", %{conn: conn, user: user} do
    conn = post conn, user_bookshelf_path(conn, :create, user.id), bookshelf: @invalid_attrs
    assert html_response(conn, 200) =~ "New bookshelf"
  end

  test "shows chosen resource", %{conn: conn} do
    bookshelf = insert(:bookshelf)
    conn = get conn, bookshelf_path(conn, :show, bookshelf)
    assert html_response(conn, 200) =~ "Show bookshelf"
    assert String.contains?(conn.resp_body, bookshelf.name)
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, bookshelf_path(conn, :show, -1)
    end
  end

  @tag login_as: "foxy"
  test "renders form for editing chosen resource", %{conn: conn, user: user} do
    bookshelf = insert(:bookshelf, %{user: user})
    conn = get conn, bookshelf_path(conn, :edit, bookshelf)
    assert html_response(conn, 200) =~ "Edit bookshelf"
  end

  @tag login_as: "foxy"
  test "updates chosen resource and redirects when data is valid", %{conn: conn, user: user} do
    bookshelf = insert(:bookshelf, %{user: user})
    conn = put conn, bookshelf_path(conn, :update, bookshelf), bookshelf: @valid_attrs
    assert redirected_to(conn) == bookshelf_path(conn, :show, bookshelf)
    assert Repo.get_by(Bookshelf, @valid_attrs)
  end

  @tag login_as: "foxy"
  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, user: user} do
    bookshelf = insert(:bookshelf, %{user: user})
    conn = put conn, bookshelf_path(conn, :update, bookshelf), bookshelf: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit bookshelf"
  end

  @tag login_as: "foxy"
  test "deletes chosen resource", %{conn: conn, user: user} do
    bookshelf = insert(:bookshelf, %{user: user})
    conn = delete conn, bookshelf_path(conn, :delete, bookshelf)
    assert redirected_to(conn) == user_bookshelf_path(conn, :index, user.id)
    refute Repo.get(Bookshelf, bookshelf.id)
  end
end
