use mrml;
use mrml::prelude::parser;
use mrml::prelude::parser::local_loader::LocalIncludeLoader;
use mrml::prelude::parser::noop_loader::NoopIncludeLoader;
use rustler::{Encoder, Env, NifResult, NifStruct, Term};
use std::borrow::Cow;
use std::borrow::Cow::Owned;
use std::collections::HashMap;
use std::path::PathBuf;

mod atoms {
    rustler::atoms! {
        ok,
        error
    }
}

#[derive(NifStruct)]
#[module = "Mjml.RenderOptions"]
pub struct RenderOptions<'a> {
    pub keep_comments: bool,
    pub social_icon_path: Option<String>,
    pub fonts: Option<HashMap<Term<'a>, Term<'a>>>,
}

#[derive(NifStruct)]
#[module = "Mjml.ParserOptions"]
pub struct ParserOptions<'a> {
    pub include_loader: Term<'a>,
    pub args: Vec<Term<'a>>,
}

#[rustler::nif]
pub fn to_html<'a>(
    env: Env<'a>,
    mjml: String,
    render_options: RenderOptions,
    parser_options: ParserOptions,
) -> NifResult<Term<'a>> {
    let parse_opts = parser::ParserOptions {
        include_loader: include_loader_option(&parser_options),
        ..parser::ParserOptions::default()
    };
    return match mrml::parse_with_options(&mjml, &parse_opts) {
        Ok(root) => {
            let options = mrml::prelude::render::RenderOptions {
                disable_comments: !render_options.keep_comments,
                social_icon_origin: social_icon_origin_option(render_options.social_icon_path),
                fonts: fonts_option(render_options.fonts),
            };

            return match root.element.render(&options) {
                Ok(content) => Ok((atoms::ok(), content).encode(env)),
                Err(error) => Ok((atoms::error(), error.to_string()).encode(env)),
            };
        }
        Err(error) => Ok((atoms::error(), error.to_string()).encode(env)),
    };
}

fn social_icon_origin_option(option_value: Option<String>) -> Option<Cow<'static, str>> {
    option_value.map_or(
        mrml::prelude::render::RenderOptions::default().social_icon_origin,
        |origin| Some(Owned(origin)),
    )
}

fn fonts_option<'a>(
    option_values: Option<HashMap<Term<'a>, Term<'a>>>,
) -> HashMap<String, Cow<'static, str>> {
    option_values.map_or(
        mrml::prelude::render::RenderOptions::default().fonts,
        |fonts| -> HashMap<String, Cow<'static, str>> {
            let mut options: HashMap<String, Cow<'static, str>> = HashMap::new();

            for (key, value) in fonts {
                let (k, v) = font_option(key, value);
                options.insert(k, v);
            }

            options
        },
    )
}

fn font_option<'a>(key: Term<'a>, value: Term<'a>) -> (String, Cow<'static, str>) {
    (
        match key.atom_to_string() {
            Ok(s) => s,
            Err(_) => panic!(
                "Keys for the `fonts` render option must be of type Atom, got {:?}.
                 Please use a Map like this: %{{\"My Font Name\": \"https://myfonts.example.com/css\"}}",
                key.get_type()
            )

        },
        match value.decode::<String>() {
            Ok(s) => Owned(s),
            Err(_) => panic!(
                "Values for the `fonts` render option must be of type String, got {:?}.
                 Please use a Map like this: %{{\"My Font Name\": \"https://myfonts.example.com/css\"}}",
                value.get_type()
            )
        }
    )
}

fn include_loader_option<'a>(
    parser_options: &ParserOptions<'a>,
) -> Box<dyn parser::loader::IncludeLoader> {
    match parser_options.include_loader.atom_to_string() {
        Ok(loader) if loader == "local" => {
            let path = include_loader_path(&parser_options.args);
            Box::new(LocalIncludeLoader::new(path))
        }
        _ => Box::new(NoopIncludeLoader),
    }
}

fn include_loader_path<'a>(args: &Vec<Term<'a>>) -> PathBuf {
    match args.first() {
        Some(path) => path
            .decode::<String>()
            .map_or(PathBuf::default(), |path| PathBuf::from(path)),
        _ => PathBuf::default(),
    }
}

rustler::init!("Elixir.Mjml.Native");
