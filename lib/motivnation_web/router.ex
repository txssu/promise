defmodule MotivnationWeb.Router do
  use MotivnationWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MotivnationWeb.Layouts, :root}
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug OpenApiSpex.Plug.PutApiSpec, module: MotivnationWeb.ApiSpec
  end

  pipeline :ensure_authorized do
    plug MotivnationWeb.AuthPipeline, key: :motivnation
  end

  scope "/", MotivnationWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/" do
    pipe_through :browser

    get "/swaggerui", OpenApiSpex.Plug.SwaggerUI, path: "/api/openapi"
  end

  scope "/api" do
    pipe_through :api
    get "/openapi", OpenApiSpex.Plug.RenderSpec, []
  end

  scope "/api/tokens", MotivnationWeb do
    pipe_through :api

    post "/", TokenController, :create
  end

  scope "/api/users", MotivnationWeb do
    pipe_through :api

    get "/:id", UserController, :show
    post "/", UserController, :create
  end

  scope "/api/profile", MotivnationWeb do
    pipe_through [:api, :ensure_authorized]

    get "/", ProfileController, :show
    put "/", ProfileController, :update
    delete "/", ProfileController, :delete
  end

  scope "/api/goals", MotivnationWeb do
    pipe_through [:api, :ensure_authorized]

    get "/", GoalController, :index
    post "/", GoalController, :create

    get "/:id", GoalController, :show
    put "/:id", GoalController, :update
    delete "/:id", GoalController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", MotivnationWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:motivnation, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MotivnationWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
