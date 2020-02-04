#lang pollen

◊h3{Other sites}

Yes, this is a webring.

◊; Remove most sites here, only add the ones I truly "follow"
◊ul{
    ◊li{◊l["http://tilde.club/~joeld/" #:ext #t]{tilde.club/~joeld}}

    ◊li{◊l["https://flowing.systems" #:ext #t]{flowing.systems}}

    ◊li{◊l["https://christine.website/" #:ext #t]{christine.website}}

    ◊li{◊l["https://jfm.carcosa.net" #:ext #t]{jfm.carcosa.net}}

    ◊li{◊l["https://agbero.dev" #:ext #t]{agbero.dev}}

    ◊li{◊l["https://wiki.xxiivv.com/" #:ext #t]{xxiivv.com}}

    ◊li{◊l["http://ayekat.ch/" #:ext #t]{ayekat.ch}}
}

◊h3{Random quotes}

(Please add /s as necessary)

◊blockquote[#:author "mikey"]{
    If you can’t make yourself miserable trying to monetize it, it’s not a hobby.
}

◊blockquote[#:author "Paula and I on a sunny June afternoon"]{
    please give these portuguese geese

    some cheese and grease

    chinese bees lease the trees
}


◊h3{Site TODOs}

Things I'd like to add:

◊toggle[#:title "list/table support"]{
    The macro will accept a list/hashmap of values (tuples?) denoting each column.

    Optionally, it will receive a list of header items.
}

◊toggle[#:title "self-contained post encryption"]{
    We can use Racket's ◊code{read}/◊code{write} functions to ask the user for a password. When we want to password-protect a post, we could add a meta like so:

    ◊pre{◊code{
        ◊"◊"(define-meta locked #t)
    }}

    This would prompt pollen to ask us for a password. It will take the body, encrypt it, and embed the metadata in the ◊code{head} section so that javascript can decrypt it.
}

◊toggle[#:title "full text search"]{
    For starters we can just use a {google,bing,duck}.com search redirect with
    ◊code{site:our-site.com}. Another option is to use ◊l["https://lunrjs.com" #:ext #t]{◊code{lunrjs}}. We can ◊l["https://lunrjs.com/guides/index_prebuilding.html"]{pre-build} the page index and host a static ◊code{.json} file that we can use.

    Disadvantages: uses javascript.
}

◊toggle[#:title "Syntax coloring"]{
    Use some js library to add color to code blocks.
}

◊toggle[#:title "Self host fonts"]{
    ◊l["https://rsms.me/inter/" #:ext #t]{Inter} looks cool. Pair with this ◊l["https://kevq.uk/how-to-self-host-your-web-fonts/" #:ext #t]{tutorial} to self-host the font files. The font also has nice features that will pair nicely with ◊l["https://docs.racket-lang.org/quad" #:ext #t]{quad}.
}

◊toggle[#:title "Add \"last updated\""]{
    Add a "this page was last updated on XXX" to the about page
}
