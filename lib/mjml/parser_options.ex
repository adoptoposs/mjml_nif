defmodule Mjml.ParserOptions do
  defstruct include_loader: nil, args: []

  alias Mjml.ParserOptions.LocalIncludeLoader

  @moduledoc """
  Allows configuring a local path to load MJML templates that are included via
  the `<mj-include>` tag.

  ## Examples

      iex> opts = [include_loader: %LocalIncludeLoader{}]
      # will start looking for include templates from the current working directory

      iex> opts = [include_loader: %LocalIncludeLoader{path: Path.expand("my/custom/path")}]
      # # will start looking for include templates from the defined directory
  """
  defmodule LocalIncludeLoader do
    defstruct path: nil
  end

  def new(include_loader: %LocalIncludeLoader{path: path}) do
    %__MODULE__{include_loader: :local, args: [path]}
  end

  def new(include_loader: include_loader) do
    raise "Unknown MJML include loader: #{inspect(include_loader)}"
  end

  def new(_), do: %__MODULE__{}
end
