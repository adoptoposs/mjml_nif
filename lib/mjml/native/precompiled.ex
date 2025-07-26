defmodule Mjml.Native.Precompiled do
  @moduledoc false

  def options(opts) do
    if force?(Keyword.get(opts, :targets)) do
      Keyword.put(opts, :force_build, true)
    else
      opts
    end
  end

  defp force?(available_targets) do
    System.get_env("MJML_BUILD") in ["1", "true"] ||
      !current_target_available?(available_targets)
  end

  defp current_target_available?(targets) do
    case RustlerPrecompiled.target() do
      {:ok, current_target} ->
        available =
          Enum.any?(targets, fn target ->
            String.ends_with?(current_target, target)
          end)

        if !available do
          log_notice(current_target)
        end

        available

      _ ->
        false
    end
  end

  defp log_notice(current_target) do
    require Logger

    target = Regex.replace(~r/\Anif-\d+.\d+-/, current_target, "")
    github_url = Mix.Project.config()[:package][:links]["GitHub"]

    new_issue_url =
      URI.encode("#{github_url}/issues/new?title=Add target #{target}")

    notice = "

      The mjml NIF is currently not yet precompiled for your target '#{target}'.

      Please consider opening an issue here:
      #{new_issue_url}
    "

    Logger.notice(notice)
  end
end
