defmodule MotivnationWeb.Schemas.UserAuthData do
  use MotivnationWeb, :openapi_schema

  OpenApiSpex.schema(%{
    title: "UserAuthData",
    description: "User's authorization data",
    type: :object,
    properties: %{
      user: %Schema{
        type: :object,
        properties: %{
          email: %Schema{type: :string, description: "User's email", format: :email},
          password: %Schema{type: :string, description: "User's password", format: :password}
        }
      }
    }
  })
end
