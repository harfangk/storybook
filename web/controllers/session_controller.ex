defmodule Storybook.SessionController do
  use Storybook.Web, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case Storybook.AuthenticationPlug.login_by_email_and_pass(conn, email, pass, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: user_path(conn, :show, conn.assigns.current_user.id))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid username or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Storybook.AuthenticationPlug.drop_session_and_remove_user()
    |> redirect(to: "/")
  end
end
