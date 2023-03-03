defmodule MotivNationWeb.Schemas.TokenResponse do
  use MotivNationWeb, :openapi_schema

  alias MotivNationWeb.Schemas.Token

  OpenApiSpex.schema(%{
    title: "TokenResponse",
    description: "Response schema for token",
    type: :object,
    properties: %{data: Token}
  })
end
