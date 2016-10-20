defmodule Storybook.PageControllerTest do
  use Storybook.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Storybook"
  end
end
