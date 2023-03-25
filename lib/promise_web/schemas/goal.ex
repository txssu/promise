defmodule PromiseWeb.Schemas.Goal do
  @moduledoc false
  use PromiseWeb, :openapi_schema

  OpenApiSpex.schema(%{
    title: "Goal",
    type: :object,
    properties: %{
      id: %Schema{type: :string, format: :uuid},
      user_id: %Schema{type: :string, format: :uuid},
      title: %Schema{type: :string}
    }
  })
end
