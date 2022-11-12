use mrml;
use rustler::{Encoder, Env, NifStruct, NifResult, Term};

mod atoms {
    rustler::atoms! {
      ok,
      error
    }
}

#[derive(NifStruct)]
#[module = "Mjml.RenderOptions"]
pub struct Options {
    pub keep_comments: bool,
    pub social_icon_path: Option<String>
}

#[rustler::nif]
pub fn to_html<'a>(env: Env<'a>, mjml: String, render_options: Options) -> NifResult<Term<'a>> {
    return match mrml::parse(&mjml) {
        Ok(root) => {
            let options = mrml::prelude::render::Options{
                disable_comments: !render_options.keep_comments,
                social_icon_origin: render_options.social_icon_path
            };

            return match root.render(&options) {
                Ok(content) => Ok((atoms::ok(), content).encode(env)),
                Err(error) => Ok((atoms::error(), error.to_string()).encode(env)),
            };
        }
        Err(error) => Ok((atoms::error(), error.to_string()).encode(env)),
    };
}

rustler::init!("Elixir.Mjml.Native", [to_html]);
