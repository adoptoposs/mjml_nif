defmodule Mjml.Native.Precompiled do
  @moduledoc false

  def options(opts) do
    if force?() do
      Keyword.put(opts, :force_build, true)
    else
      opts
    end
  end

  defp force? do
    System.get_env("MJML_BUILD") in ["1", "true"]
  end
end
