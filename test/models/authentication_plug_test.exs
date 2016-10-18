defmodule Storybook.AuthenticationPlugTest do
  use Storybook.ConnCase
  alias Storybook.AuthenticationPlug

  setup %{conn: conn} do
    conn =
      conn
      |> bypass_through(:browser)
      |> get("/")
    {:ok, %{conn: conn}}
  end

  test "call places user from session into assigns", %{conn: conn} do
    assert false
  end

  test "a call with no session sets current_user assign to nil", %{conn: conn} do
    assert false
  end

  test "require_authentication halts when no current_user exists", %{conn: conn} do
    assert false
  end

  test "require_authentication continues when the current_user exists", %{conn: conn} do
    assert false
  end

  test "add_user_to_session_and_conn puts the user in the session and conn", %{conn: conn} do
    assert false
  end

  test "logout removes the user from session and conn", %{conn: conn} do
    assert false
  end

  test "login with a valid username and pass", %{conn: conn} do
    assert false
  end

  test "login with a not found user gives error", %{conn: conn} do
    assert false
  end

  test "login with password mismatch gives error", %{conn: conn} do
    assert false
  end
end
