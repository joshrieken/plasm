defmodule Plasm.Repo do
  use Ecto.Repo,
    otp_app: :plasm,
    adapter: Ecto.Adapters.Postgres
end
