defmodule PromiseWeb.GoalController do
  use PromiseWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias Promise.Goals
  alias Promise.Goals.Goal

  alias PromiseWeb.Loaders

  plug PromiseWeb.Plugs.ResourceLoader,
       [key: :current_user, loader: Loaders.CurrentUserLoader]
       when action in [:create, :update, :delete]

  plug PromiseWeb.Plugs.ResourceLoader,
       [key: :goal, loader: Loaders.GenLoader, resource: {Goals, :get_goal!}]
       when action in [:show, :update, :delete]

  plug :owner_only when action in [:update, :delete]

  action_fallback PromiseWeb.FallbackController

  tags ["goals"]
  security [%{}, %{"authorization" => ["cookieAuth"]}]

  operation :index, false

  def index(conn, _params) do
    goals = Goals.list_goals()
    render(conn, :index, goals: goals)
  end

  operation :show,
    summary: "Get goal data",
    parameters: [
      id: [
        in: :path,
        description: "Goal ID",
        type: :string,
        example: "3bf8ac00-fa03-43b5-86b1-d303d71b0075"
      ]
    ],
    responses: [
      ok: {"Goal data", "application/json", Schemas.GoalResponse},
      not_found: {"There is no this user", "application/json", Schemas.GenericError}
    ]

  def show(conn, _params) do
    render(conn, :show, goal: conn.assigns.goal)
  end

  operation :create,
    summary: "Create goal",
    request_body: {"Goal params", "application/json", Schemas.GoalRequest},
    responses: [
      created: {"Created goal", "application/json", Schemas.GoalResponse},
      bad_request: {"Bad request", "application/json", Schemas.GenericError}
    ]

  def create(conn, %{"goal" => goal_params}) do
    user = conn.assigns.current_user

    with {:ok, %Goal{} = goal} <- Goals.create_goal(user, goal_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/goals/#{goal}")
      |> render(:show, goal: goal)
    end
  end

  operation :update,
    summary: "Edit goal data",
    request_body: {"User params", "application/json", Schemas.GoalRequest},
    responses: [
      ok: {"User data", "application/json", Schemas.GoalResponse}
    ]

  def update(conn, %{"goal" => goal_params}) do
    goal = conn.assigns.goal

    with {:ok, %Goal{} = goal} <- Goals.update_goal(goal, goal_params) do
      render(conn, :show, goal: goal)
    end
  end

  operation :delete,
    summary: "Delete goal",
    responses: [
      no_content: "Deleted succesfully"
    ]

  def delete(conn, _params) do
    goal = conn.assigns.goal

    with {:ok, %Goal{}} <- Goals.delete_goal(goal) do
      send_resp(conn, :no_content, "")
    end
  end

  def owner_only(conn, _opts) do
    %{current_user: user, goal: goal} = conn.assigns

    if goal.user_id == user.id do
      conn
    else
      conn
      |> put_status(:forbidden)
      |> put_view(json: PromiseWeb.ErrorJSON)
      |> render("403.json", message: "You are not the owner of the resource")
      |> halt()
    end
  end
end
