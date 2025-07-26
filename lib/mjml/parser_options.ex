defmodule Mjml.ParserOptions do
  @moduledoc false

  defstruct include_loader: nil, args: []

  alias Mjml.ParserOptions.LocalIncludeLoader

  def new(opts) do
    include_loader = opts && opts[:include_loader]

    if include_loader do
      build(include_loader: include_loader)
    else
      build(opts)
    end
  end

  defp build(include_loader: %LocalIncludeLoader{path: path}) do
    %__MODULE__{include_loader: :local, args: [path]}
  end

  defp build(include_loader: include_loader) do
    raise "Unknown MJML include loader: #{inspect(include_loader)}"
  end

  defp build(_), do: %__MODULE__{}
end
