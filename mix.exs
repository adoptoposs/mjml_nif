defmodule Mjml.MixProject do
  use Mix.Project

  @source_url "https://github.com/adoptoposs/mjml_nif"
  @version "4.0.0"

  def project do
    [
      app: :mjml,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      compilers: Mix.compilers(),
      name: "mjml",
      package: package(),
      docs: docs(),
      deps: deps(),
      aliases: aliases()
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
      {:rustler_precompiled, "~> 0.7.0"},
      {:rustler, ">= 0.0.0", optional: true},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      description:
        "Responsive emails made easy. NIF bindings for the MJML Rust implementation (mrml)",
      maintainers: ["Paul Götze"],
      licenses: ["MIT"],
      files: ~w(lib native .formatter.exs CHANGELOG.md README* LICENSE* mix.exs checksum-*.exs),
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: [
        "CHANGELOG.md": [],
        "CONTRIBUTING.md": [title: "Contributing"],
        "CODE_OF_CONDUCT.md": [title: "Code of Conduct"],
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      source_url: @source_url,
      source_ref: "v#{@version}",
      homepage_url: @source_url,
      formatters: ["html"]
    ]
  end

  defp aliases do
    [
      # always force building the NIF for test runs:
      test: [fn _ -> System.put_env("MJML_BUILD", "true") end, "test"]
    ]
  end
end
