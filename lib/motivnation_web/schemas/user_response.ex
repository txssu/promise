defmodule MotivNationWeb.Schemas.UserResponse do
  use MotivNationWeb, :openapi_schema

  alias MotivNationWeb.Schemas.User

  OpenApiSpex.schema(%{
    title: "UserResponse",
    type: :object,
    properties: %{
      data: User
    }
  })
end
