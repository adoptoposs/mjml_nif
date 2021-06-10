# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

For clarity, major releases of mjml_nif use the respective [mrml] releases with the same major release number.
I.e. mjml_nif 0.x versions use mrml versions >= 0.1, < 1.0.0, and mjml_nif 1.x versions use mrml versions >= 1.0.0, < 2.0.0, etc.

## [Unreleased]
### Changed
- Use [mrml] v1.2.4

## [1.1.1] - 2021-06-01
### Fixed
- Use [mrml] v1.2.3, which fixes a bug with ignored mj-class attributes (see https://github.com/jdrouet/mrml/issues/164)

## [1.1.0] - 2021-05-23
### Changed
- Use [mrml] v1.2.2
- Support OTP 24
- mjml_nif crate type changed from "dylib" to "cdylib"

## [1.0.0] - 2021-04-07
### Changed
- Use [mrml] v1.0.0
- Pass on parsing/rendering error messages from mrml to the error tuple of `MJML.to_html/1`

## [0.3.1] - 2021-02-23
### Fixed
- Compilation on aarch64 MacOS

## [0.3.0] - 2021-02-02
### Changed
- Use [mrml] v0.5.0

### Fixed
- Warning about special link args for x86_64-apple-darwin target

## [0.2.0] – 2020-10-19
### Changed
- Use [mrml] v0.3.3

## [0.1.0] – 2020-07-19
Initial release

[Unreleased]: https://github.com/adoptoposs/mjml_nif/compare/v1.1.1...HEAD
[1.1.1]: https://github.com/adoptoposs/mjml_nif/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/adoptoposs/mjml_nif/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/adoptoposs/mjml_nif/compare/v0.3.1...v1.0.0
[0.3.1]: https://github.com/adoptoposs/mjml_nif/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/adoptoposs/mjml_nif/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/adoptoposs/mjml_nif/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/adoptoposs/mjml_nif/compare/e77d33e9bcb58e0e2e9e522322d97ebdcb212618...v0.1.0
[mrml]: https://github.com/jdrouet/mrml
