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
                <!-- my comment -->
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
    assert html =~ "<!-- my comment -->"
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

  describe "when passing options" do
    test "`keep_comments: false` removes comments" do
      comment = "<!-- some comment -->"

      mjml = """
        <mjml>
          <mj-body>
            #{comment}
          </mj-body>
        </mjml>
      """

      assert {:ok, html} = Mjml.to_html(mjml, keep_comments: false)
      refute html =~ comment
    end

    test "`social_icon_path: 'path'` sets a custom social icon path" do
      social_icon_path = "https://example.com/icons/"

      mjml = """
        <mjml>
          <mj-body>
            <mj-social>
              <mj-social-element name="github" href="[[SHORT_PERMALINK]]">
                GitHub
              </mj-social-element>
              <mj-social-element name="twitter" href="[[SHORT_PERMALINK]]">
                Twitter
              </mj-social-element>
            </mj-social>
          </mj-body>
        </mjml>
      """

      assert {:ok, html} = Mjml.to_html(mjml, social_icon_path: social_icon_path)
      assert html =~ social_icon_path
      assert html =~ "#{social_icon_path}github.png"
      assert html =~ "#{social_icon_path}twitter.png"
    end
  end
end
