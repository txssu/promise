defmodule MotivNationWeb.Schemas.User do
  use MotivNationWeb, :openapi_schema

  OpenApiSpex.schema(%{
    title: "User",
    type: :object,
    properties: %{
      id: %Schema{type: :string, format: :uuid},
      email: %Schema{type: :string, format: :email}
    }
  })
end
