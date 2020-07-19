defmodule Mjml do
  @moduledoc """
  Provides functions for transpiling MJML email templates to HTML.
  """

  use Rustler, otp_app: :mjml, crate: "mjml_nif"

  @doc """
  Converts an MJML string to HTML content.

  ## Examples

      iex> Mjml.to_html("<mjml><mj-head></mj-head></mjml>")
      "<!doctype html><html xmlns=..."

  """
  def to_html(_mjml), do: error()

  defp error(), do: :erlang.nif_error(:nif_not_loaded)
end
