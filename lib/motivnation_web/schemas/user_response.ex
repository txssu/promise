defmodule MotivnationWeb.Schemas.UserResponse do
  @moduledoc false
  use MotivnationWeb, :openapi_schema

  alias MotivnationWeb.Schemas.User

  OpenApiSpex.schema(%{
    title: "UserResponse",
    type: :object,
    properties: %{
      data: User
    }
  })
end
