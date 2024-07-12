defmodule Mjml.Native do
  mix_config = Mix.Project.config()
  version = mix_config[:version]
  github_url = mix_config[:package][:links]["GitHub"]

  targets = ~w(
    aarch64-apple-darwin
    aarch64-unknown-linux-gnu
    aarch64-unknown-linux-musl
    riscv64gc-unknown-linux-gnu
    x86_64-apple-darwin
    x86_64-pc-windows-gnu
    x86_64-pc-windows-msvc
    x86_64-unknown-linux-gnu
    x86_64-unknown-linux-musl
  )

  nif_versions = ~w(
    2.15
    2.16
  )

  opts = [
    otp_app: :mjml,
    crate: "mjml_nif",
    base_url: "#{github_url}/releases/download/v#{version}",
    version: version,
    targets: targets,
    nif_versions: nif_versions
  ]

  use RustlerPrecompiled,
      (if System.get_env("MJML_BUILD") in ["1", "true"] do
         Keyword.put(opts, :force_build, true)
       else
         opts
       end)

  def to_html(_mjml, _render_options), do: error()
  defp error(), do: :erlang.nif_error(:nif_not_loaded)
end
