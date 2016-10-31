defmodule Storybook.BookshelfController do
  use Storybook.Web, :controller

  alias Storybook.Bookshelf

  def index(conn, _params) do
    bookshelves = Repo.all(Bookshelf)
    render(conn, "index.html", bookshelves: bookshelves)
  end

  def new(conn, _params) do
    changeset = Bookshelf.changeset(%Bookshelf{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bookshelf" => bookshelf_params}) do
    changeset = 
      Bookshelf.changeset(%Bookshelf{}, bookshelf_params)

    case Repo.insert(changeset) do
      {:ok, _bookshelf} ->
        conn
        |> put_flash(:info, "Bookshelf created successfully.")
        |> redirect(to: user_bookshelf_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bookshelf = Repo.get!(Bookshelf, id)
    render(conn, "show.html", bookshelf: bookshelf)
  end

  def edit(conn, %{"id" => id}) do
    bookshelf = Repo.get!(Bookshelf, id)
    changeset = Bookshelf.changeset(bookshelf)
    render(conn, "edit.html", bookshelf: bookshelf, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bookshelf" => bookshelf_params}) do
    bookshelf = Repo.get!(Bookshelf, id)
    changeset = Bookshelf.changeset(bookshelf, bookshelf_params)

    case Repo.update(changeset) do
      {:ok, bookshelf} ->
        conn
        |> put_flash(:info, "Bookshelf updated successfully.")
        |> redirect(to: bookshelf_path(conn, :show, bookshelf))
      {:error, changeset} ->
        render(conn, "edit.html", bookshelf: bookshelf, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bookshelf = Repo.get!(Bookshelf, id)
    Repo.delete!(bookshelf)

    conn
    |> put_flash(:info, "Bookshelf deleted successfully.")
    |> redirect(to: bookshelf_path(conn, :index))
  end
end
