defmodule TeacherWeb.Router do
  use TeacherWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :flag_ui do
    plug :accepts, ["html"]
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope path: "/feature-flags" do
    pipe_through :flag_ui
    forward "/", FunWithFlags.UI.Router, namespace: "feature-flags"
  end

  scope "/", TeacherWeb do
    pipe_through :browser # Use the default browser stack

    get "/", MovieController, :index
    get "/review", MovieController, :review
    resources "/movies", MovieController
    resources "/registrations", UserController, only: [:create, :new]

    get "/sign-in", SessionController, :new
    post "/sign-in", SessionController, :create
    delete "/sign-out", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", TeacherWeb do
  #   pipe_through :api
  # end
end
