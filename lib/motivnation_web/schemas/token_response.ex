defmodule MotivnationWeb.Schemas.TokenResponse do
  use MotivnationWeb, :openapi_schema

  def response() do
    %OpenApiSpex.Response{
      description: "Authorization was successful",
      headers: %{
        "Set-Cookie": %{
          schema: %OpenApiSpex.Schema{
            type: :string,
            example: "guardian_motivnation_token=TOKEN; Path=/; HttpOnly"
          }
        }
      }
    }
  end
end
