defmodule MotivNation.Guardian do
  @moduledoc false
  use Guardian, otp_app: :motivnation

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id}) do
    resource = MotivNation.Accounts.get_user!(id)
    {:ok, resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_fro_error}
  end
end
