# MJML (Rust NIFs for Elixir)

[![Build Status](https://github.com/adoptoposs/mjml_nif/workflows/Tests/badge.svg)](https://github.com/adoptoposs/mjml_nif/workflows/Tests/badge.svg)
[![Module Version](https://img.shields.io/hexpm/v/mjml.svg)](https://hex.pm/packages/mjml)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/mjml/)
[![Total Download](https://img.shields.io/hexpm/dt/mjml.svg)](https://hex.pm/packages/mjml)
[![License](https://img.shields.io/hexpm/l/mjml.svg)](https://github.com/adoptoposs/mjml_nif/blob/master/LICENSE.md)
[![Last Updated](https://img.shields.io/github/last-commit/adoptoposs/mjml_nif.svg)](https://github.com/adoptoposs/mjml_nif/commits/master)

Native Implemented Function (NIF) bindings for the [MJML](https://mjml.io) Rust implementation ([mrml](https://github.com/jdrouet/mrml)).

## Installation

The package can be installed by adding `mjml` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mjml, "~> 4.0"}
  ]
end
```

By default **you don't need Rust installed** because the lib will try to download
a precompiled NIF file. In case you want to force compilation set the
`MJML_BUILD` environment variable to `true` or `1`. Alternatively you can also set the
application env in order to force the build:

```elixir
config :rustler_precompiled, :force_build, mjml: true
```

## Usage

Transpile MJML templates to HTML with:

```elixir
mjml = "<mjml>...</mjml>"
{:ok, html} = Mjml.to_html(mjml)

# For an invalid MJML template:
mjml = "something not MJML"
{:error, message} = Mjml.to_html(mjml)
```

### Options

Available rendering options are:

* `keep_comments` – when `false`, removes comments from the final HTML. Defaults to `true`.
* `social_icon_path` – when given, uses this base path to generate social icon URLs.
* `fonts` – a Map of font names and their URLs to a hosted CSS file.
  When given, includes these fonts in the rendered HTML
  (Note that only actually used fonts will show up!).
  Defaults to `nil`, which will make the default font families available to
  be used (Open Sans, Droid Sans, Lato, Roboto, and Ubuntu).

```elixir
mjml = "<mjml>...</mjml>"

opts = [
  keep_comments: false,
  social_icon_path: "https://example.com/icons/",
  fonts: %{
      "Noto Color Emoji": "https://fonts.googleapis.com/css?family=Noto+Color+Emoji:400"
  }
]

{:ok, html} = Mjml.to_html(mjml, opts)
```

## Contributing

We encourage you to contribute to mjml_nif.
Please check our [CONTRIBUTING.md](./CONTRIBUTING.md) guides for more information.

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to our [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md).


## Copyright and License

Copyright (c) 2020 Paul Götze

This work is free. You can redistribute it and/or modify it under the
terms of the MIT License. See the [LICENSE.md](./LICENSE.md) file for more details.
