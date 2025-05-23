defmodule ExOptimizer.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_optimizer,
      version: "0.2.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      name: "ExOptimizer",
      source_url: "https://framagit.org/tcit/ex_optimizer",
      homepage_url: "https://tcit.frama.io/ex_optimizer",
      description: description(),
      package: package(),
      docs: [
        # The main page in the docs
        main: "readme",
        extras: ["README.md", "CHANGELOG.md"],
        nest_modules_by_prefix: [
          ExOptimizer.Optimizers
        ]
      ]
    ]
  end

  defp description() do
    "ExOptimizer is a tool to optimize pictures by running them through a chain of various image optimization tools."
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def package do
    %{
      links: %{"Gitlab" => "https://framagit.org/tcit/ex_optimizer"},
      licenses: ["MIT"]
    }
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:file_info, "~> 0.0.4"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:excoveralls, "~> 0.12", only: :test},
      {:credo, "~> 1.7.0", only: [:dev, :test], runtime: false}
    ]
  end
end
