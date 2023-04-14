defmodule PromiseWeb.PostController do
  use PromiseWeb, :controller

  alias Promise.Goals
  alias Promise.Goals.Post

  alias PromiseWeb.Loaders

  plug PromiseWeb.Plugs.ResourceLoader,
       [key: :current_user, loader: Loaders.CurrentUserLoader]

  plug PromiseWeb.Plugs.ResourceLoader,
       [key: :goal, loader: Loaders.GenLoader, param_key: "goal_id",  resource: {Goals, :get_goal_with_posts!}]
       when action in [:index]

  plug PromiseWeb.Plugs.ResourceLoader,
       [key: :goal, loader: Loaders.GenLoader, param_key: "goal_id",  resource: {Goals, :get_goal!}]
       when action in [:create, :show, :update, :delete]

  plug PromiseWeb.Plugs.ResourceLoader,
       [key: :post, loader: Loaders.GenLoader, resource: {Goals, :get_post!}]
       when action in [:show, :update, :delete]

  plug PromiseWeb.Plugs.AccessRules,
       [rule: :owner_only, resource_key: :goal]

  action_fallback PromiseWeb.FallbackController

  def index(conn, _params) do
    render(conn, :index, goal_posts: conn.assigns.goal.posts)
  end

  def create(conn, %{"post" => post_params}) do
    goal = conn.assigns.goal

    with {:ok, %Post{} = post} <- Goals.create_post(goal, post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/goals/#{goal}/posts/#{post}")
      |> render(:show, post: post)
    end
  end

  def show(conn, _params) do
    post = conn.assigns.post
    render(conn, :show, post: post)
  end

  def update(conn, %{"post" => post_params}) do
    post = conn.assigns.post

    with {:ok, %Post{} = post} <- Goals.update_post(post, post_params) do
      render(conn, :show, post: post)
    end
  end

  def delete(conn, _params) do
    post = conn.assigns.post

    with {:ok, %Post{}} <- Goals.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
