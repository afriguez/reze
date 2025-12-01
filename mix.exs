defmodule Reze.MixProject do
  use Mix.Project

  def project do
    [
      app: :reze,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Reze.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:anubis_mcp, "~> 0.16.0"},
      {:httpoison, "~> 2.3.0"},
      {:poison, "~> 6.0"}
    ]
  end
end
