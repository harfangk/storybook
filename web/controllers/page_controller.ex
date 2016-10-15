defmodule Storybook.PageController do
  use Storybook.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
