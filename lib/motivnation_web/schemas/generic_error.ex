defmodule MotivNationWeb.Schemas.GenericError do
  use MotivNationWeb, :openapi_schema

  OpenApiSpex.schema(%{
    title: "GenericError",
    description: "Schema for default errors",
    type: :object,
    properties: %{
      errors: %Schema{
        type: :object,
        properties: %{
          message: %Schema{type: :string},
          detail: %Schema{type: :string}
        }
      }
    }
  })
end
