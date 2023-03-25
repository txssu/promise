defmodule PromiseWeb.Schemas.GoalResponse do
  @moduledoc false
  use PromiseWeb, :openapi_schema

  alias PromiseWeb.Schemas.Goal

  OpenApiSpex.schema(%{
    title: "GoalResponse",
    type: :object,
    properties: %{
      data: Goal
    }
  })
end
