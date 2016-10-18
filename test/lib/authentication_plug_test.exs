defmodule Storybook.AuthenticationPlugTest do
  use Storybook.ConnCase
  import Storybook.Factory
  alias Storybook.AuthenticationPlug
  alias Storybook.Repo

  setup %{conn: conn} do
    conn =
      conn
      |> bypass_through(Storybook.Router, :browser)
      |> get("/")
    {:ok, %{conn: conn}}
  end

  test "call places user from session into assigns", %{conn: conn} do
    user = insert(:user)
    conn =
      conn
      |> put_session(:user_id, user.id)
      |> AuthenticationPlug.call(Repo)

    assert conn.assigns.current_user.id == user.id
  end

  test "a call with no session sets current_user assign to nil", %{conn: conn} do
    conn = AuthenticationPlug.call(conn, Repo)
    assert conn.assigns.current_user == nil
  end

  test "require_authentication halts conn when no current_user exists", %{conn: conn} do
    conn = AuthenticationPlug.require_authentication(conn, [])
    assert conn.halted()
  end

  test "require_authentication continues when the current_user exists", %{conn: conn} do
    user = build(:user)
    conn = 
      conn
      |> assign(:current_user, user)
      |> AuthenticationPlug.require_authentication([])

    refute conn.halted()
  end

  test "add_user_to_session_and_conn puts the user in the session and conn", %{conn: conn} do
    user = build(:user)
    login_conn =
      conn
      |> AuthenticationPlug.add_user_to_session_and_conn(user)

    next_conn = get(login_conn, "/")
    assert get_session(next_conn, :user_id) == user.id
  end

  test "drop_session removes the user from session and conn", %{conn: conn} do
    user = build(:user)
    login_conn =
      conn
      |> AuthenticationPlug.add_user_to_session_and_conn(user)

    AuthenticationPlug.drop_session_and_remove_user(login_conn)

    assert get_session(login_conn, :user_id) == nil
  end

  test "login with a valid username and pass sets current_use", %{conn: conn} do
    user = insert(:user, %{email: "example@example.com", password: nil})
    
    {:ok, conn} = AuthenticationPlug.login_by_email_and_pass(conn, "example@example.com", "password", repo: Repo)  

    assert conn.assigns.current_user == user
  end

  test "login with a not found user gives error", %{conn: conn} do
    assert {:error, :not_found, _conn} = AuthenticationPlug.login_by_email_and_pass(conn, "example@example.com", "password", repo: Repo)
  end

  test "login with password mismatch gives error", %{conn: conn} do
    _user = insert(:user, %{email: "example@example.com", password: "password"})

    assert {:error, :unauthorized, _conn} = AuthenticationPlug.login_by_email_and_pass(conn, "example@example.com", "wrong_password", repo: Repo)
  end
end
