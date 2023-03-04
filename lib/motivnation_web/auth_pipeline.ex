defmodule MotivNationWeb.AuthPipeline do
  @moduledoc false
  use Guardian.Plug.Pipeline,
    otp_app: :motivnation,
    module: MotivNation.Guardian,
    error_handler: MotivNationWeb.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, scheme: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
end
