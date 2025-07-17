defmodule MjmlTest do
  use ExUnit.Case

  test "transpiles the given MJML to HTML" do
    mjml = """
      <mjml>
        <mj-head>
          <!-- Comment -->
          <mj-attributes>
            <mj-all font-family="My Font"></mj-all>
          </mj-attributes>
          <mj-font name="My Font" href="https://myfontserver.example.com/css?family=My+Font"></mj-font>
          <mj-font name="Other Font" href="https://myfontserver.example.com/css?family=Other+Font" />
        </mj-head>
        <mj-body>
          <mj-section>
            <!-- Comment -->
            <mj-column>
              <mj-image width="100px" src="logo.png" />
              <mj-divider border-color="#F45E43" />
              <mj-text font-size="20px" color="#F45E43" font-family="Other Font, helvetica">
                <!-- my comment -->
                Hello<br>Email!
              </mj-text>
              <mj-text>
                This is a test.
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
    assert html =~ "My Font"
    assert html =~ "Other Font"
  end

  test "fails to parse invalid MJML" do
    assert {:error, message} = Mjml.to_html("<mjml><mjml>")
    assert String.starts_with?(message, "unexpected element")

    assert {:error, message} = Mjml.to_html("not MJML")
    assert String.starts_with?(message, "unable to parse next template in root template")

    assert {:error, message} = Mjml.to_html("<mjml><///invalid-element></mjml>")
    assert String.starts_with?(message, "unable to parse next template in root template")
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

    test "`fonts: %{\"font name\": \"font URL\", ...}` includes the given fonts" do
      fonts = %{
        "My Font": "https://myfontserver.example.com/css?family=My+Font:300,400,500,700",
        "Your Font": "https://yourfontserver.example.com/css?family=Your+Font:300,400,500,700"
      }

      mjml = """
        <mjml>
          <mj-head>
            <mj-attributes>
              <mj-all font-family="My Font, Your Font" />
            </mj-attributes>
          </mj-head>
          <mj-body>
            <mj-section>
              <mj-column>
                <mj-text>
                  test
                </mj-text>
              </mj-column>
            </mj-section>
          </mj-body>
        </mjml>
      """

      assert {:ok, html} = Mjml.to_html(mjml, fonts: fonts)

      [font_name_a, font_name_b] = fonts |> Map.keys()
      [font_url_a, font_url_b] = fonts |> Map.values()

      assert html =~ font_name_a |> Atom.to_string()
      assert html =~ font_url_a

      assert html =~ font_name_b |> Atom.to_string()
      assert html =~ font_url_b
    end

    test "not providing `fonts` allows using the default fonts" do
      mjml = """
        <mjml>
          <mj-head>
            <mj-attributes>
              <mj-all font-family="Open Sans" />
            </mj-attributes>
          </mj-head>
          <mj-body>
            <mj-section>
              <mj-column>
                <mj-text>
                  test
                </mj-text>
              </mj-column>
            </mj-section>
          </mj-body>
        </mjml>
      """

      assert {:ok, html} = Mjml.to_html(mjml)
      assert html =~ "Open Sans"
      assert html =~ "https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,700"
    end
  end

  describe "with mj-includes" do
    alias Mjml.ParserOptions.LocalIncludeLoader

    defp template_with_mj_include(path: path) do
      """
      <mjml>
        <mj-body>
          Include example:
          <mj-wrapper padding="0 0 0 0">
            <mj-include path="#{path}" />
          </mj-wrapper>
        </mj-body>
      </mjml>
      """
    end

    test "fails loading without a configured include loader" do
      mjml = template_with_mj_include(path: "file:///./test/support/partial.mjml")

      assert {:error, message} = Mjml.to_html(mjml)
      assert message =~ "unable to load included template"
    end

    test "succeeds loading with local include loader" do
      mjml = template_with_mj_include(path: "file:///./test/support/partial.mjml")
      include_loader = %LocalIncludeLoader{}

      assert {:ok, html} = Mjml.to_html(mjml, include_loader: include_loader)
      assert html =~ "This `partial.mjml` file should be included"
    end

    test "succeeds loading from a custom local include path" do
      mjml = template_with_mj_include(path: "file:///partial.mjml")
      include_loader = %LocalIncludeLoader{path: Path.expand("test/support")}

      assert {:ok, html} = Mjml.to_html(mjml, include_loader: include_loader)
      assert html =~ "This `partial.mjml` file should be included"
    end

    test "fails loading from an invalid custom local include path" do
      mjml = template_with_mj_include(path: "file:///partial.mjml")
      include_loader = %LocalIncludeLoader{path: "/dev/null"}

      assert {:error, message} = Mjml.to_html(mjml, include_loader: include_loader)
      assert message =~ "unable to load included template"
    end

    # TODO(https://github.com/adoptoposs/mjml_nif/pull/179): in mrml 6.0 it should succeed
    test "fails loading without protocol 'file:///' in path attribute" do
      mjml = template_with_mj_include(path: "./test/support/partial.mjml")

      assert {:error, message} = Mjml.to_html(mjml)
      assert message =~ "unable to load included template"
    end

    test "raises when using an invalid include_loader" do
      assert_raise RuntimeError,
                   "Unknown MJML include loader: :invalid_loader",
                   fn -> Mjml.to_html("", include_loader: :invalid_loader) end
    end

    test "handles include loading with other options" do
      mjml = template_with_mj_include(path: "file:///partial.mjml")

      opts = [
        keep_comments: false,
        social_icon_path: "https://example.com/icons/",
        fonts: %{
          "My Font": "https://myfontserver.example.com/css?family=My+Font:300,400,500,700",
          "Your Font": "https://yourfontserver.example.com/css?family=Your+Font:300,400,500,700"
        },
        include_loader: %LocalIncludeLoader{path: Path.expand("test/support")}
      ]

      assert {:ok, html} = Mjml.to_html(mjml, opts)
      assert html =~ "This `partial.mjml` file should be included"
    end
  end
end
