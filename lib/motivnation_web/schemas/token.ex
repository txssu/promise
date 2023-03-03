defmodule MotivNationWeb.Schemas.Token do
  use MotivNationWeb, :openapi_schema

  OpenApiSpex.schema(%{
    title: "Token",
    description: "User's access token",
    type: :object,
    properties: %{
      user_id: %Schema{type: :string, description: "User id", format: :uuid},
      token: %Schema{type: :string, description: "User token", format: :jwt_token}
    }
  })
end
