defmodule Mjml.MixProject do
  use Mix.Project

  @github_url "https://github.com/adoptoposs/mjml_nif"

  def project do
    [
      app: :mjml,
      version: "0.3.1",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      compilers: [:rustler] ++ Mix.compilers(),
      rustler_crates: [mjml_nif: []],
      name: "mjml",
      description: description(),
      source_url: @github_url,
      homepage_url: @github_url,
      package: package(),
      docs: docs(),
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
      {:rustler, "~> 0.21"},
      {:ex_doc, "~> 0.23", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "NIF bindings for the MJML Rust implementation (mrml)"
  end

  defp package() do
    [
      maintainers: ["Paul Götze"],
      licenses: ["MIT"],
      files: ~w(lib native .formatter.exs README* LICENSE* mix.exs),
      links: %{"GitHub" => @github_url}
    ]
  end

  defp docs() do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end
end
