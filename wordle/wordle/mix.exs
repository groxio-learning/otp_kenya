defmodule Wordle.MixProject do
  use Mix.Project

  def project do
    [
      app: :wordle,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Wordle.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dictionary, path: "../dictionary"},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false}
    ]
  end
end
