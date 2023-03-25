defmodule PromiseWeb.Schemas.GenericError do
  @moduledoc false
  use PromiseWeb, :openapi_schema

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