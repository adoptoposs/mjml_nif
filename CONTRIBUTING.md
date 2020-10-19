# Contributing to mjml_nif

Thanks for considering to contribute to mjml_nif. ❤

Bug reports, feature suggestions, and pull requests for any open issues are very welcome. Issues can be reported on GitHub: https://github.com/adoptoposs/mjml_nif/issues/new.

Please read and follow our [Code of Conduct](https://github.com/adoptoposs/mjml_nif/blob/main/CODE_OF_CONDUCT.md).

## Development setup
 
In order to setup the development environment you need to have some dependencies installed on your machine:

- [git](https://git-scm.com/downloads)
- [Rust](https://www.rust-lang.org/learn/get-started)
- [Elixir](https://elixir-lang.org/install.html)

Checkout the mjml_nif repository with

```
$ git clone git@github.com:adoptoposs/mjml_nif.git
```

Then step into the project directory and install the dependencies with 

```
mix deps.get
```

## How to Contribute

Here’s how to contribute:

* Fork it (https://github.com/adoptoposs/mjml_nif/fork)
* Create your feature branch (git checkout -b feature/my-new-feature)
* Commit your changes (git commit -am 'Add some feature')
* Push to the branch (git push origin feature/my-new-feature)
* Create a new Pull Request

Try to add tests along with your new feature. This will ensure that your code does not break existing functionality and that your feature is working as expected. You can run the tests with:

```bash
mix test
```

If you’ve changed any Elixir code, please run Elixir’s code formatter before committing your changes:

```bash
mix format
```

This will keep the code style consistent and future code diffs as small as possible.

---------

As a contributor, please keep in mind this project is free and open source software. Maintainers are not paid to work on it, so there might be times were the maintainers seem unresponsive. If you have that feeling, please be patient and be assured, that all team members try their best to review your contribution and reply to you as soon as their time allows.
