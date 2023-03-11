defmodule MotivNationWeb.Schemas.TokenResponse do
  use MotivNationWeb, :openapi_schema

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
