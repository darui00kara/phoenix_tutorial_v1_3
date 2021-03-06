defmodule ToyApp.Web.Router do
  use ToyApp.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ToyApp.Web do
    pipe_through :browser # Use the default browser stack

    # Default
    get "/", PageController, :index

    # StaticPage
    get "/home",    StaticPageController, :home
    get "/help",    StaticPageController, :help
    get "/about",   StaticPageController, :about
    get "/contact", StaticPageController, :contact

    # User
    resources "/users",               UserController, except: [:new]
    get       "/signup",              UserController, :new
    get       "/users/:id/following", UserController, :following
    get       "/users/:id/followers", UserController, :followers

    # Session
    get    "/signin",  SessionController, :new
    post   "/session", SessionController, :create
    delete "/signout", SessionController, :delete

    # Micropost
    resources "/posts", MicropostController, only: [:create, :delete]

    # Relationship
    resources "/relationship", RelationshipController, only: [:create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", ToyApp.Web do
  #   pipe_through :api
  # end
end
