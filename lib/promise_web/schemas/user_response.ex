defmodule PromiseWeb.Schemas.UserResponse do
  @moduledoc false
  use PromiseWeb, :openapi_schema

  alias PromiseWeb.Schemas.User

  OpenApiSpex.schema(%{
    title: "UserResponse",
    type: :object,
    properties: %{
      data: User
    }
  })
end
