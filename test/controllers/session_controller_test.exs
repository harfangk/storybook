defmodule Storybook.SessionControllerTest do
  use Storybook.ConnCase
  import Storybook.Factory
  alias Storybook.AuthenticationPlug

  test "new session renders new session page", %{conn: conn} do
    conn = get conn, "/session/new"
    assert html_response(conn, 200) =~ "Login"
  end

  test "successful login shows flash and redirect to user page", %{conn: conn} do
    insert(:user, email: "example@example.com", password: "password")
    AuthenticationPlug.login_by_email_and_pass(conn, "example@example.com", "password", [repo: Storybook.Repo])
    assert conn.status == 200
    assert get_flash(conn) =~ "Successful login" 
    assert redirected_to(conn) == "/session/new"
  end

  test "failed login shows error flash", %{conn: conn} do
    insert(:user)
    AuthenticationPlug.login_by_email_and_pass(conn, "invalid@email.com", "wrong_pass", [repo: Storybook.Repo])
    assert get_flash(conn) =~ "Failed login"
  end

  test "logout removes current user information and redirects to root page", %{conn: conn} do
    user = insert(:user, email: "example@example.com", password: "password")
    AuthenticationPlug.login_by_email_and_pass(conn, "example@example.com", "password", [repo: Storybook.Repo])
    AuthenticationPlug.drop_session_and_remove_user(user)
    assert conn.status == 200
    assert get_session(conn, user.id) == nil
    assert redirected_to(conn) == "/"
  end
end
