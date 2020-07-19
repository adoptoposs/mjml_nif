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
    return match mrml::to_html(&mjml, mrml::Options::default()) {
        Ok(content) => Ok((atoms::ok(), content).encode(env)),
        Err(_) => Ok((atoms::error(), "Couldn't convert MJML template").encode(env)),
    };
}

rustler::init!("Elixir.Mjml", [to_html]);
