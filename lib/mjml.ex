defmodule Mjml do
  @moduledoc """
  Provides functions for transpiling MJML email templates to HTML.
  """

  @doc """
  Converts an MJML string to HTML content.

  Returns a result tuple:

  * `{:ok, html}` for a successful MJML transpiling
  * `{:error, message}` for a failed MJML transpiling

  You can pass render options to customize the rendering of the final HTML:

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

  """
  def to_html(mjml, opts \\ []) do
    options = struct(Mjml.RenderOptions, opts)
    Mjml.Native.to_html(mjml, options)
  end
end
