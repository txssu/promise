defmodule PromiseWeb.SubscriptionController do
  use PromiseWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias Promise.Goals
  alias Promise.Goals.Subscription

  alias PromiseWeb.Loaders

  plug PromiseWeb.Plugs.ResourceLoader,
    key: :current_user,
    loader: Loaders.CurrentUserLoader

  plug PromiseWeb.Plugs.ResourceLoader,
    key: :goal,
    loader: Loaders.GenLoader,
    resource: {Goals, :get_goal!}

  action_fallback PromiseWeb.FallbackController

  tags ["goals"]
  security [%{}, %{"authorization" => ["cookieAuth"]}]

  operation :show, false
  operation :update, false

  operation :index,
    summary: "Users' subscriptions",
    parameters: [
      id: [
        in: :path,
        description: "Goal ID",
        type: :string,
        example: "3bf8ac00-fa03-43b5-86b1-d303d71b0075"
      ]
    ],
    responses: [
      ok: {"Users array", "application/json", Schemas.UserResponse}
    ]

  def index(conn, _params) do
    goal = Goals.load_subscriptions(conn.assigns.goal)

    conn
    |> put_view(json: PromiseWeb.UserJSON)
    |> render(:index, users: goal.user_subscriptions)
  end

  operation :create,
    summary: "Subscribe goal",
    parameters: [
      id: [
        in: :path,
        description: "Goal ID",
        type: :string,
        example: "3bf8ac00-fa03-43b5-86b1-d303d71b0075"
      ]
    ],
    responses: [
      no_content: "Subscribed"
    ]

  def create(conn, _params) do
    %{current_user: user, goal: goal} = conn.assigns

    with _ <- Goals.create_subscription(user, goal) do
      send_resp(conn, :no_content, "")
    end
  end

  operation :delete,
    summary: "Unsubscribe goal",
    parameters: [
      id: [
        in: :path,
        description: "Goal ID",
        type: :string,
        example: "3bf8ac00-fa03-43b5-86b1-d303d71b0075"
      ]
    ],
    responses: [
      no_content: "Unsubscribed"
    ]

  def delete(conn, _params) do
    %{current_user: user, goal: goal} = conn.assigns

    subscription = Goals.get_user_goal_subscription!(user, goal)

    with {:ok, %Subscription{}} <- Goals.delete_subscription(subscription) do
      send_resp(conn, :no_content, "")
    end
  end
end
