defmodule MotivNationWeb.ApiSpec do
  @moduledoc false
  @behaviour OpenApiSpex.OpenApi

  alias OpenApiSpex.{Components, Info, OpenApi, Paths, SecurityScheme, Server}
  alias MotivNationWeb.{Endpoint, Router}

  @impl true
  def spec do
    %OpenApi{
      servers: [
        Server.from_endpoint(Endpoint)
      ],
      info: %Info{
        title: to_string(Application.spec(:my_app, :description)),
        version: to_string(Application.spec(:my_app, :vsn))
      },
      paths: Paths.from_router(Router),
      components: %Components{
        securitySchemes: %{"cookieAuth" => %SecurityScheme{type: "apiKey", in: "cookie", name: "guardian_motivnation_token"}}
      }
    }
    |> OpenApiSpex.resolve_schema_modules()
  end
end
