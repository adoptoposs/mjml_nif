# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

For clarity, major releases of mjml_nif use the respective [mrml] releases with the same major release number.
I.e. `mjml_nif 0.x` versions use mrml versions `>= 0.1, < 1.0.0`, and `mjml_nif 1.x` versions use mrml versions `>= 1.0.0, < 2.0.0`, etc.

## [Unreleased]

## [4.0.0] - 2024-06-18

- Use [mrml] v4.0.0 which fixes a bug when using HEEx annotations and phoenix function components to generate MJML (see [mrml diff v3.1.5..v4.0.0][mrml-v3.1.5-v4.0.0])

## [3.1.0] - 2024-04-18

- Use [mrml] v3.1.5 (see [mrml diff v3.0.4..v3.1.5][mrml-v3.0.4-v3.1.5])
- Use rustler v0.32.1


## [3.0.3] - 2024-03-09

- Use [mrml] v3.0.4, which fixes applying mj-attributes inside mj-include tags and ensures fonts are rendered once (see https://github.com/jdrouet/mrml/issues/378, https://github.com/jdrouet/mrml/issues/383, [mrml diff v3.0.2..v3.0.4][mrml-v3.0.2-v3.0.4]).

## [3.0.2] - 2024-02-27

- Use [mrml] v3.0.2, which fixes using comments in `<mj-head>` tags. (See https://github.com/jdrouet/mrml/issues/373, [mrml diff v3.0.1..v3.0.2][mrml-v3.0.1-v3.0.2]).


## [3.0.1] - 2024-02-16

- Use [mrml] v3.0.1, which fixes using comments in `<mj-section>` tags. (See https://github.com/jdrouet/mrml/issues/370, [mrml diff v3.0.0..v3.0.1][mrml-v3.0.0-v3.0.1]).


## [3.0.0] - 2023-12-23

## Changed
- Use [mrml] v3.0.0, which fixes an issue with rendering not self-closing `<mj-font></mj-font>` tags. (See https://github.com/jdrouet/mrml/issues/356, [mrml diff v2.1.1..v3.0.0][mrml-v2.1.1-v3.0.0]).

## [2.0.0] - 2023-12-16

### Changed
- Drop support for Elixir < v1.13
- Drop `arm-unknown-linux-gnueabihf` as precompiled target
- Allow passing a rendering option `fonts` to `Mjml.to_html/2`
- Use [Rustler Precompiled v0.7.1](https://github.com/philss/rustler_precompiled/blob/main/CHANGELOG.md#071---2023-11-30)
- Use rustler v0.30.0
- Use Rust edition 2021
- Use [mrml] v.2.1.1, which provides a `fonts` rendering option and implements mj-include (see [mrml diff v1.2.11..v2.1.1][mrml-v1.2.11-v2.1.1])

---

## [1.5.0] - 2023-02-02

### Changed
- Use rustler_precompiled v0.6.0
- Add new target `riscv64gc-unknown-linux-gnu`
- Use [mrml] v1.2.11, which handles inner attributes (see [mrml diff v1.2.10..v1.2.11][mrml-v1.2.10-v1.2.11])

## [1.4.0] - 2022-11-30

### Changed
- Use rustler_precompiled v0.5.4
- Change `Mjml.to_html/1` to `Mjml.to_html/2` and allow passing rendering options `keep_comments` (defaults to `true`) & `social_icon_path`

## [1.3.5] - 2022-07-11
### Fixed
- Add `aarch64-unknown-linux-musl` as precompiled target (see [#66](https://github.com/adoptoposs/mjml_nif/issues/66))

## [1.3.4] - 2022-07-01
### Fixed
- Add Cross.toml in order to pass the NIF version to cross (see [philss/rustler_precompiled#23](https://github.com/philss/rustler_precompiled/issues/23))

## [1.3.3] - 2022-05-25
### Fixed
- Use "orderedmap" feature of mrml to get consistent HTML output (see [jdrouet/mrml#215](https://github.com/jdrouet/mrml/pull/215))
- Use [Rustler Precompiled v0.5.1](https://github.com/philss/rustler_precompiled/blob/main/CHANGELOG.md#051---2022-05-24)

## [1.3.2] - 2022-03-26
### Fixed
- Use [mrml] v1.2.10, which fixes a bug with parsing other self-closing tags
(see [mrml diff v1.2.9..v1.2.10][mrml-v1.2.9-v1.2.10]))

## [1.3.1] - 2022-03-25
### Fixed
- Use [mrml] v1.2.9, which fixes a bug with parsing the self-closing `br` and `meta` tags
(see [mrml diff v1.2.8..v1.2.9][mrml-v1.2.8-v1.2.9]))

## [1.3.0] - 2022-03-18
### Changed
- Use [Rustler Precompiled](https://github.com/philss/rustler_precompiled): this allows to use the mjml NIF without the Rust compiler 🎉
- Use [mrml] v1.2.8 (see [mrml diff v1.2.7..v1.2.8][mrml-v1.2.7-v1.2.8]))

## [1.2.0] - 2022-02-25
### Changed
- Update rustler to v0.24 (drops support for OTP <22, requires Elixir ~> 1.11)

## [1.1.3] - 2022-02-16
### Changed
- Update rustler to v0.23 (drops support for OTP 20)
- Use [mrml] v1.2.7, which allows inner elements in mj-social-element & mj-navbar-link (see [mrml diff v1.2.5..v1.2.7][mrml-v1.2.5-v1.2.7])

## [1.1.2] - 2021-10-04
### Changed
- Use [mrml] v1.2.5, which allows the `lang` attribute in the mjml tag and allows using `mj-raw` tags in `mj-head` (see [mrml diff v1.2.3..v1.2.5][mrml-v1.2.3-v1.2.5])

### Fixed
- Misc doc changes ([#31](https://github.com/adoptoposs/mjml_nif/pull/31))

## [1.1.1] - 2021-06-01
### Fixed
- Use [mrml] v1.2.3, which fixes a bug with ignored mj-class attributes (see [jdrouet/mrml #164](https://github.com/jdrouet/mrml/issues/164), [mrml diff v1.2.2..v1.2.3][mrml-v1.2.2-v1.2.3]))

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

[Unreleased]: https://github.com/adoptoposs/mjml_nif/compare/v3.1.0...HEAD
[3.1.0]: https://github.com/adoptoposs/mjml_nif/compare/v3.0.3...v3.1.0
[3.0.3]: https://github.com/adoptoposs/mjml_nif/compare/v3.0.2...v3.0.3
[3.0.2]: https://github.com/adoptoposs/mjml_nif/compare/v3.0.1...v3.0.2
[3.0.1]: https://github.com/adoptoposs/mjml_nif/compare/v3.0.0...v3.0.1
[3.0.0]: https://github.com/adoptoposs/mjml_nif/compare/v2.0.0...v3.0.0
[2.0.0]: https://github.com/adoptoposs/mjml_nif/compare/v1.5.0...v2.0.0
[1.5.0]: https://github.com/adoptoposs/mjml_nif/compare/v1.4.0...v1.5.0
[1.4.0]: https://github.com/adoptoposs/mjml_nif/compare/v1.3.5...v1.4.0
[1.3.5]: https://github.com/adoptoposs/mjml_nif/compare/v1.3.4...v1.3.5
[1.3.4]: https://github.com/adoptoposs/mjml_nif/compare/v1.3.3...v1.3.4
[1.3.3]: https://github.com/adoptoposs/mjml_nif/compare/v1.3.2...v1.3.3
[1.3.2]: https://github.com/adoptoposs/mjml_nif/compare/v1.3.1...v1.3.2
[1.3.1]: https://github.com/adoptoposs/mjml_nif/compare/v1.3.0...v1.3.1
[1.3.0]: https://github.com/adoptoposs/mjml_nif/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/adoptoposs/mjml_nif/compare/v1.1.3...v1.2.0
[1.1.3]: https://github.com/adoptoposs/mjml_nif/compare/v1.1.2...v1.1.3
[1.1.2]: https://github.com/adoptoposs/mjml_nif/compare/v1.1.1...v1.1.2
[1.1.1]: https://github.com/adoptoposs/mjml_nif/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/adoptoposs/mjml_nif/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/adoptoposs/mjml_nif/compare/v0.3.1...v1.0.0
[0.3.1]: https://github.com/adoptoposs/mjml_nif/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/adoptoposs/mjml_nif/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/adoptoposs/mjml_nif/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/adoptoposs/mjml_nif/compare/e77d33e9bcb58e0e2e9e522322d97ebdcb212618...v0.1.0
[mrml]: https://github.com/jdrouet/mrml

[mrml-v3.0.4-v3.1.5]: https://github.com/jdrouet/mrml/compare/mrml-v3.0.4...mrml-v3.1.5
[mrml-v3.0.2-v3.0.4]: https://github.com/jdrouet/mrml/compare/mrml-v3.0.2...mrml-v3.0.4
[mrml-v3.0.1-v3.0.2]: https://github.com/jdrouet/mrml/compare/mrml-v3.0.1...mrml-v3.0.2
[mrml-v3.0.0-v3.0.1]: https://github.com/jdrouet/mrml/compare/mrml-v3.0.0...mrml-v3.0.1
[mrml-v2.1.1-v3.0.0]: https://github.com/jdrouet/mrml/compare/mrml-v2.1.1...mrml-v3.0.0
[mrml-v1.2.11-v2.1.1]: https://github.com/jdrouet/mrml/compare/v1.2.11...mrml-v2.1.1
[mrml-v1.2.10-v1.2.11]: https://github.com/jdrouet/mrml/compare/mrml-core-1.2.10...v1.2.11
[mrml-v1.2.9-v1.2.10]: https://github.com/jdrouet/mrml/compare/mrml-core-1.2.9...mrml-core-1.2.10
[mrml-v1.2.8-v1.2.9]: https://github.com/jdrouet/mrml/compare/mrml-core-1.2.8...mrml-core-1.2.9
[mrml-v1.2.7-v1.2.8]: https://github.com/jdrouet/mrml/compare/mrml-core-1.2.7...mrml-core-1.2.8
[mrml-v1.2.5-v1.2.7]: https://github.com/jdrouet/mrml/compare/mrml-core-1.2.5...mrml-core-1.2.7
[mrml-v1.2.3-v1.2.5]: https://github.com/jdrouet/mrml/compare/mrml-core-1.2.3...mrml-core-1.2.5
[mrml-v1.2.2-v1.2.3]: https://github.com/jdrouet/mrml/compare/mrml-core-1.2.2...mrml-core-1.2.3
