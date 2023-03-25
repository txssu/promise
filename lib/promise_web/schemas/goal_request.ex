defmodule PromiseWeb.Schemas.GoalRequest do
  @moduledoc false
  use PromiseWeb, :openapi_schema

  alias PromiseWeb.Schemas.Goal

  OpenApiSpex.schema(%{
    title: "GoalRequest",
    type: :object,
    properties: %{
      goal: %Schema{anyOf: [Goal]}
    }
  })
end
