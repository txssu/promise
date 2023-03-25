defmodule PromiseWeb.Schemas.TokenResponse do
  @moduledoc false
  use PromiseWeb, :openapi_schema

  def response do
    %OpenApiSpex.Response{
      description: "Authorization was successful",
      headers: %{
        "Set-Cookie": %{
          schema: %OpenApiSpex.Schema{
            type: :string,
            example: "guardian_promise_token=TOKEN; Path=/; HttpOnly"
          }
        }
      }
    }
  end
end
