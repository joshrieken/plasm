use Mix.Config

config :plasm, Plasm.Repo,
  database: "plasm_test",
  username: "postgres",
  password: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, level: :info
