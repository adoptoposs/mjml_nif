use mrml;
use rustler::{Encoder, Env, NifResult, Term};

mod atoms {
    rustler::atoms! {
      ok,
      error
    }
}

#[rustler::nif]
pub fn to_html<'a>(env: Env<'a>, mjml: String) -> NifResult<Term<'a>> {
    return match mrml::parse(&mjml) {
        Ok(root) => {
            let options = mrml::prelude::render::Options::default();

            return match root.render(&options) {
                Ok(content) => Ok((atoms::ok(), content).encode(env)),
                Err(error) => Ok((atoms::error(), error.to_string()).encode(env)),
            };
        }
        Err(error) => Ok((atoms::error(), error.to_string()).encode(env)),
    };
}

rustler::init!("Elixir.Mjml", [to_html]);
