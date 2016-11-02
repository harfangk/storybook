defmodule Storybook.BookshelfController do
  use Storybook.Web, :controller
  plug :require_authentication when action in [:new, :create, :edit, :update, :delete]

  alias Storybook.Bookshelf
  alias Storybook.User

  def index(conn, params) do
    user = Repo.get(User, params["user_id"])
    bookshelves = Repo.all(assoc(user, :bookshelves))
    conn
    |> render("index.html", user: user, bookshelves: bookshelves)
  end

  def new(conn, _params) do
    user = conn.assigns.current_user
    changeset = 
      user
      |> build_assoc(:bookshelves)
      |> Bookshelf.changeset()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bookshelf" => bookshelf_params}) do
    user = conn.assigns.current_user
    changeset = 
      user
      |> build_assoc(:bookshelves)
      |> Bookshelf.changeset(bookshelf_params)

    case Repo.insert(changeset) do
      {:ok, _bookshelf} ->
        conn
        |> put_flash(:info, "Bookshelf created successfully.")
        |> redirect(to: user_bookshelf_path(conn, user.id, :index))
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
    conn
    |> require_authorization(conn.assigns.current_user.id)
    |> render("edit.html", bookshelf: bookshelf, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bookshelf" => bookshelf_params}) do
    bookshelf = Repo.get!(Bookshelf, id)
    changeset = Bookshelf.changeset(bookshelf, bookshelf_params)

    conn
    |> require_authorization(conn.assigns.current_user.id)
    |> handle_update(changeset, bookshelf)
  end

  def delete(conn, %{"id" => id}) do
    bookshelf = Repo.get!(Bookshelf, id)

    conn
    |> require_authorization(conn.assigns.current_user.id)
    |> handle_delete(bookshelf)
  end

  defp handle_update(conn, changeset, bookshelf) do
    case Repo.update(changeset) do
      {:ok, bookshelf} ->
        conn
        |> put_flash(:info, "Bookshelf updated successfully.")
        |> redirect(to: bookshelf_path(conn, :show, bookshelf))
      {:error, changeset} ->
        render(conn, "edit.html", bookshelf: bookshelf, changeset: changeset)
    end
  end

  defp handle_delete(conn, bookshelf) do
    Repo.delete!(bookshelf)
    conn
    |> put_flash(:info, "Bookshelf deleted successfully.")
    |> redirect(to: user_bookshelf_path(conn, bookshelf.user.id, :index))
  end
end
