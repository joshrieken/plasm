use Mix.Config

config :plasm, Plasm.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "plasm_test",
  username: "postgres"

config :logger, level: :info
