defmodule Plasm.Mixfile do
  use Mix.Project

  @version "0.0.1"
  @adapters [:pg, :mysql]

  def project do
    [
      app: :plasm,
      version: @version,
      elixir: "~> 1.0",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps,
      description: description,
      package: package,
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :ecto]]
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
    [{:ecto, "~> 1.0"},
     {:ex_doc, "~> 0.10", only: :docs},
     {:earmark, "~> 0.1", only: :docs},
     {:inch_ex, only: :docs}]
  end

  defp description do
    """
    Plasm is a composable query library for Ecto containing several common query transforms to make working with Ecto easier.
    """
  end

  defp package do
    [
      maintainers: ["Jason Harrelson", "Joshua Rieken"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/atomic-fads/plasm"},
      files: ~w(mix.exs README.md CHANGELOG.md lib)
    ]
  end
end
