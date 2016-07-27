defmodule Plasm.Mixfile do
  use Mix.Project

  @version "0.4.0"

  def project do
    [
      app:             :plasm,
      version:         @version,
      elixir:          "~> 1.0",
      elixirc_paths:   elixirc_paths(Mix.env),
      build_embedded:  Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps:            deps,
      description:     description,
      package:         package,
      aliases:         aliases,
      docs:            [extras: ["README.md", "CHANGELOG.md"]],
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      applications: [
        :logger,
        :ecto,
      ]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ecto,     "~> 1.0 or ~> 2.0-dev"},
      {:ex_doc,     "~> 0.13",  only: [:dev]},
      {:earmark,    "~> 1.0.1", only: [:dev]},
      {:inch_ex,    "~> 0.5",   only: [:dev,     :test]},
      {:ex_machina, "~> 1.0",   only: [:test]},
      {:postgrex,   "> 0.0.0",  optional: true},
    ]
  end

  defp description do
    """
    Composable query convenience functions for Ecto
    """
  end

  defp package do
    [
      maintainers: ["Joshua Rieken"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/facto/plasm"},
      files: ~w(mix.exs README.md CHANGELOG.md LICENSE.md lib),
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp aliases do
    [
      "test.setup": ["ecto.create", "ecto.migrate"],
      "test.reset": ["ecto.drop", "test.setup"],
    ]
  end
end
