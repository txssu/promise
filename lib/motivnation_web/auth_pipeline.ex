defmodule MotivnationWeb.AuthPipeline do
  @moduledoc false
  use Guardian.Plug.Pipeline,
    otp_app: :motivnation,
    module: Motivnation.Guardian,
    error_handler: MotivnationWeb.AuthErrorHandler,
    key: :motivnation

  plug Guardian.Plug.VerifyHeader,
    refresh_from_cookie: true

  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
