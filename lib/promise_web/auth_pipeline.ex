defmodule PromiseWeb.AuthPipeline do
  @moduledoc false
  use Guardian.Plug.Pipeline,
    otp_app: :promise,
    module: Promise.Guardian,
    error_handler: PromiseWeb.AuthErrorHandler,
    key: :promise

  plug Guardian.Plug.VerifyHeader

  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
