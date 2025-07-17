defmodule Mjml.ParserOptions.LocalIncludeLoader do
  @moduledoc """
  Allows configuring a local path to load MJML templates that are included via
  the `<mj-include>` tag.

  ## Examples

      iex> opts = [include_loader: %LocalIncludeLoader{}]
      # will start looking for include templates from the current working directory

      iex> opts = [include_loader: %LocalIncludeLoader{path: Path.expand("my/custom/path")}]
      # # will start looking for include templates from the defined directory
  """

  defstruct path: nil
end
