defmodule MotivNationWeb.AuthPipeline do
  @moduledoc false
  use Guardian.Plug.Pipeline,
    otp_app: :motivnation,
    module: MotivNation.Guardian,
    error_handler: MotivNationWeb.AuthErrorHandler,
    key: :motivnation

  plug Guardian.Plug.VerifyHeader,
    refresh_from_cookie: true

  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
