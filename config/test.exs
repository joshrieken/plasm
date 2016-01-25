use Mix.Config

config :plasm, Plasm.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "plasm_test",
  username: System.get_env("PLASM_DB_USER") || System.get_env("USER")

config :logger, level: :info
