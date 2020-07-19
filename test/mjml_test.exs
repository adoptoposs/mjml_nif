defmodule MjmlTest do
  use ExUnit.Case

  test "transpiles the given MJML to HTML" do
    mjml = "<mjml></mjml>"
    assert {:ok, html} = Mjml.to_html(mjml)
    assert String.starts_with?(html, "<!doctype html>")
  end

  test "fails to transpile invalid MJML" do
    mjml = "<mjml></br></mjml>"
    assert {:error, _message} = Mjml.to_html(mjml)
  end
end
