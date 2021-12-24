defmodule Queue.MixProject do
  use Mix.Project

  def project do
    [
      app: :queue,
      version: "0.1.0",
      elixir: "~> 1.12",
      source_url: "https://github.com/jeffersono7/queue",
      description: description(),
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp description do
    "Modules to work with queue"
  end

  defp package do
    [
      files: ~w(lib priv .formatter.exs mix.exs README* readme* LICENSE*
                license* CHANGELOG* changelog* src),
      licenses: ["Apache-2.0"],
      links: %{
        "GitHub" => "https://github.com/jeffersono7/queue"
      }
    ]
  end
end
