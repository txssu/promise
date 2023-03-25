defmodule MotivnationWeb.Schemas.GoalResponse do
  @moduledoc false
  use MotivnationWeb, :openapi_schema

  alias MotivnationWeb.Schemas.Goal

  OpenApiSpex.schema(%{
    title: "GoalResponse",
    type: :object,
    properties: %{
      data: Goal
    }
  })
end
