defmodule Queue.MixProject do
  use Mix.Project

  def project do
    [
      app: :queue,
      version: "0.1.2",
      elixir: "~> 1.12",
      source_url: "https://github.com/jeffersono7/queue",
      description: description(),
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:excoveralls, "~> 0.10", only: :test}
    ]
  end

  defp description do
    "Modules to work with queue"
  end

  defp package do
    [
      name: "queue_tool",
      files: ~w(lib .formatter.exs mix.exs README* LICENSE*),
      licenses: ["Apache-2.0"],
      links: %{
        "GitHub" => "https://github.com/jeffersono7/queue"
      }
    ]
  end
end
