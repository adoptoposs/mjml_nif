defmodule MjmlTest do
  use ExUnit.Case

  test "transpiles the given MJML to HTML" do
    mjml = """
      <mjml>
        <mj-body>
          <mj-section>
            <mj-column>
              <mj-image width="100px" src="logo.png" />
              <mj-divider border-color="#F45E43" />
              <mj-text font-size="20px" color="#F45E43" font-family="helvetica">
                Hello<br>Email!
              </mj-text>
            </mj-column>
          </mj-section>
        </mj-body>
      </mjml>
    """

    assert {:ok, html} = Mjml.to_html(mjml)
    assert String.starts_with?(html, "<!doctype html>")
    assert String.ends_with?(html, "</html>")
    assert html =~ "Hello<br />Email!"
  end

  test "fails to parse invalid MJML" do
    assert {:error, message} = Mjml.to_html("<mjml><mjml>")
    assert String.starts_with?(message, "unexpected element")

    assert {:error, message} = Mjml.to_html("not MJML")
    assert String.starts_with?(message, "parsing error: unknown token")

    assert {:error, message} = Mjml.to_html("<mjml><///invalid-element></mjml>")
    assert String.starts_with?(message, "parsing error: invalid element")
  end
end
