defmodule Mjml do
  @moduledoc """
  Provides functions for transpiling MJML email templates to HTML.
  """

  @doc """
  Converts an MJML string to HTML content.

  Returns a result tuple:

  * `{:ok, html}` for a successful MJML transpiling
  * `{:error, message}` for a failed MJML transpiling

  You can pass the following options to customize the parsing of the MJML template and rendering of the final HTML:

  * `keep_comments` – when `false`, removes the comments from the rendered HTML.
    Defaults to `true`.

  * `social_icon_path` – when given, uses this base path to generate social icon URLs.
    E.g. `social_icon_path: "https://example.com/icons/"` will generate a social icon
    URL, like "https://example.com/icons/github.png"

  * `fonts` – a Map of font names and their URLs to hosted CSS files.
    When given, includes these fonts in the rendered HTML
    (Note that only actually used fonts will show up!).
    Defaults to `nil`, which will make the default font families available to
    be used (Open Sans, Droid Sans, Lato, Roboto, and Ubuntu).

  * `include_loader` - the loader to use for `mj-include` tags.
    Currently, the only supported include loader is `Mjml.ParserOptions.LocalIncludeLoader`.
    By default, there is no include loader configured, which means that transpiling MJML
    templates with `mj-include` tags will fail with an error.

  ## Examples

      iex> Mjml.to_html("<mjml><mj-head></mj-head></mjml>")
      {:ok, "<!doctype html><html xmlns=..."}

      iex> Mjml.to_html("something not MJML")
      {:error, "Couldn't convert MJML template"}

      iex> opts = [
      iex>   keep_comments: false,
      iex>   social_icon_path: "https://example.com/icons/"
      iex>   fonts: %{
      iex>     "Noto Color Emoji": "https://fonts.googleapis.com/css?family=Noto+Color+Emoji:400"
      iex>   }
      iex> ]
      iex> Mjml.to_html("<mjml><mj-head></mj-head></mjml>", opts)
      {:ok, "<!doctype html><html xmlns=..."}

      iex> Mjml.to_html("<mjml><mj-head><mj-include path="./partial.mjml"/></mj-head></mjml>")
      {:error, "unable to load include template ..."}

      iex> alias Mjml.ParserOptions.LocalIncludeLoader
      iex> opts = [include_loader: %LocalIncludeLoader{}]
      iex> Mjml.to_html("<mjml><mj-head><mj-include path="file:///./partial.mjml"/></mj-head></mjml>", opts)
      {:ok, "<!doctype html><html xmlns=..."} # assuming `partial.mjml` exists in the current working directory

      iex> opts = [include_loader: %LocalIncludeLoader{path: "/path/to/mjml/includes"}]
      iex> Mjml.to_html("<mjml><mj-head><mj-include path="file:///partial.mjml"/></mj-head></mjml>", opts)
      {:ok, "<!doctype html><html xmlns=..."} # assuming `partial.mjml` exists in the specified path
  """
  def to_html(mjml, opts \\ []) do
    render_opts = struct(Mjml.RenderOptions, opts)
    parser_opts = Mjml.ParserOptions.new(opts)
    Mjml.Native.to_html(mjml, render_opts, parser_opts)
  end
end
