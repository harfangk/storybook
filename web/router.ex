defmodule Storybook.Router do
  use Storybook.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Storybook.AuthenticationPlug, repo: Storybook.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Storybook do
    pipe_through :browser # Use the default browser stack

    resources "/users", UserController, only: [:index, :show, :new, :create] do
      resources "/bookshelves", BookshelfController, only: [:index, :new, :create]
    end
    resources "/bookshelves", BookshelfController, only: [:show, :edit, :update, :delete]
    resources "/books", BookController, only: [:index, :show, :new, :create]
    resources "/session", SessionController, only: [:new, :create, :delete]
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Storybook do
  #   pipe_through :api
  # end
end
