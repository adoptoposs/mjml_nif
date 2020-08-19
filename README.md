# MJML (Rust NIFs for Elixir)

[![Hex version badge](https://img.shields.io/hexpm/v/mjml.svg)](https://hex.pm/packages/mjml)
[![License badge](https://img.shields.io/hexpm/l/mjml.svg)](https://github.com/adoptoposs/mjml_nif/blob/main/LICENSE.md)

Native Implemented Function (NIF) bindings for the [MJML](https://mjml.io) Rust implementation ([mrml](https://github.com/jdrouet/mrml)).

## Installation

The package can be installed by adding `mjml` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mjml, "~> 0.1.0"}
  ]
end
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

## License

Copyright (c) 2020, Paul Götze

This software is licensed under the [MIT License](https://github.com/adoptoposs/mjml_nif/blob/main/LICENSE.md).

