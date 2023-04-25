defmodule PromiseWeb.PostJSON do
  alias Promise.Goals.Post

  @doc """
  Renders a list of goal_posts.
  """
  def index(%{goal_posts: goal_posts}) do
    %{data: for(post <- goal_posts, do: data(post))}
  end

  @doc """
  Renders a single post.
  """
  def show(%{post: post}) do
    %{data: data(post)}
  end

  defp data(%Post{} = post) do
    %{
      id: post.id,
      text: post.text,
      inserted_at: post.inserted_at
    }
  end
end
