defmodule MotivnationWeb.Schemas.Goal do
  @moduledoc false
  use MotivnationWeb, :openapi_schema

  alias MotivnationWeb.Schemas.GoalParams

  OpenApiSpex.schema(%{
    title: "Goal",
    type: :object,
    properties: %{
      id: %Schema{type: :string, format: :uuid},
      user_id: %Schema{type: :string, format: :uuid},
      title: %Schema{type: :string},
    }
  })
end
