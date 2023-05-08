defmodule PromiseWeb.Router do
  use PromiseWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PromiseWeb.Layouts, :root}
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :ensure_authorized do
    plug PromiseWeb.AuthPipeline, key: :promise
  end

  scope "/", PromiseWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/" do
    pipe_through :browser
  end

  scope "/api/tokens", PromiseWeb do
    pipe_through :api

    post "/", TokenController, :create
  end

  scope "/api", PromiseWeb do
    pipe_through :api
    post "/users", UserController, :create
  end

  scope "/api", PromiseWeb do
    pipe_through [:api, :ensure_authorized]

    get "/users", UserController, :index
    get "/users/:id", UserController, :show

    get "/profile", ProfileController, :show
    put "/profile", ProfileController, :update
    delete "/profile", ProfileController, :delete
  end

  scope "/api", PromiseWeb do
    pipe_through [:api, :ensure_authorized]

    get "/goals", GoalController, :index
    get "/goals/public", GoalController, :index_public
    post "/goals", GoalController, :create

    get "/goals/:id", GoalController, :show
    put "/goals/:id", GoalController, :update
    delete "/goals/:id", GoalController, :delete
  end

  scope "/api/goals/:goal_id", PromiseWeb do
    pipe_through [:api, :ensure_authorized]

    get "/posts", PostController, :index
    post "/posts", PostController, :create

    get "/posts/:id", PostController, :show
    put "/posts/:id", PostController, :update
    delete "/posts/:id", PostController, :delete
  end

  scope "/api", PromiseWeb do
    pipe_through [:api, :ensure_authorized]

    get "/goals/:id/joins", JoinController, :index

    get "/goals/:id/join", JoinController, :show
    post "/goals/:id/join", JoinController, :create
    delete "/goals/:id/join", JoinController, :delete
  end

  # scope "/api", PromiseWeb do
  #   pipe_through [:api, :ensure_authorized]

  #   get "/goals/:id/subscriptions", SubscriptionController, :index

  #   post "/goals/:id/subscription", SubscriptionController, :create
  #   delete "/goals/:id/subscription", SubscriptionController, :delete
  # end

  # Other scopes may use custom stacks.
  # scope "/api", PromiseWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:promise, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PromiseWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
