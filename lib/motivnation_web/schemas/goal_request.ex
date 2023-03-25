defmodule MotivnationWeb.Schemas.GoalParams do
  @moduledoc false
  use MotivnationWeb, :openapi_schema

  alias MotivnationWeb.Schemas.Goal

  OpenApiSpex.schema(%{
    title: "GoalRequest",
    type: :object,
    properties: %{
      goal: %Schema{anyOf: [Goal]},
    }
  })
end
