#lang pollen

◊(define-meta meta-title "About")

◊h2{About me}

◊; TODO(borja): Fit pdf CV to one page
You thought I was going to tell you about my life? Well, maybe some other time.
In the meantime, please enjoy my professional life detailed below, or check out
◊l["/cv"]{my CV} (also in ◊l["/cv/index.pdf"]{pdf form}).

◊h3{Code}

Here's a sample of projects I've done and collaborated in:

◊ul{
    ◊li{
        ◊l["https://github.com/ponylang/ponyc" #:ext #t]{The Pony programming language}: Pony is an open-source, object-oriented, actor-model, capabilities-secure, high-performance programming language.
    }
    ◊li{
        ◊l["https://github.com/AntidoteDB/antidote" #:ext #t]{AntidoteDB}: A highly-available transactional database using ◊l["https://en.wikipedia.org/wiki/Conflict-free_replicated_data_type" #:ext #t]{CRDTs}.
    }
    ◊li{
        ◊l["https://github.com/lasp-lang/lasp" #:ext #t]{Lasp}: A programming language prototype and collection of Erlang libraries to build distributed systems.
    }
    ◊li{
        ◊l["https://github.com/ergl/clojurebot" #:ext #t]{clojurebot}: A Telegram bot that acts as a Clojure REPL.
    }
    ◊li{
        ◊l["https://github.com/ergl/crdt-ml" #:ext #t]{crdt-ml}: A collection of CRDTs in OCaml.
    }
    ◊li{
        ◊l["https://github.com/ergl/pipesock" #:ext #t]{pipesock}: An Erlang TCP client that offers automatic batching and pipelining of messages across connections.
    }
    ◊li{
        ◊l["https://github.com/ergl/pony-docset" #:ext #t]{pony-docset}: A ◊l["https://kapeli.com/dash" #:ext #t]{Dash} docset for ◊l["https://www.ponylang.io/" #:ext #t]{Pony}.
    }
    ◊li{
        ◊l["https://github.com/Pysellus/pysellus" #:ext #t]{pysellus}: A Python library to monitor of data streams and perform tests against them.
    }
}

◊h3{Articles}

◊; TODO(borja): Add command for articles, see Chris' website
◊; http://christophermeiklejohn.com/publications.html
◊; for formatting ideas
◊ul{
    ◊li{
        Borja de Régil and Christopher S. Meiklejohn. Dynamic Path Contraction for Distributed, Dynamic Dataflow Languages. Draft, published Sep 2016. ◊l["http://arxiv.org/abs/1609.01068" #:ext #t]{(preprint)}
    }
}

◊h3{Talks}

◊ul{
    ◊li{
        AGERE 2016, colocated with SPLASH 2016: Dynamic Path Contraction for Distributed, Dynamic Dataflow Languages. ◊l["https://2016.splashcon.org/details/agere2016/3/Dynamic-Path-Contraction-for-Distributed-Dataflow-Languages" #:ext #t]{(link)}
    }
}

◊h2{About this site}

This site is written and published using ◊l["https://docs.racket-lang.org/pollen/"]{Pollen}. It also does not allow comments, but if you want to discuss anything, shoot me an ◊l["mailto:borjaocook@gmail.com"]{email}, or text me on ◊l["http://t.me/king_of_manlets" #:ext #t]{Telegram}.

Many thanks to ◊l["https://thelocalyarn.com" #:ext #t]{Joel Dueck} for indirectly helping to create the ◊l[◊|atom-path|]{RSS feed} through his code. You can find the complete code in the ◊l["https://github.com/ergl/pollen-site/blob/master/util-rss.rkt"]{github repo}.

◊|site-license|

Some things I'd like to add:

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
    Add a "this page was last updated on XXX" to the about page. An idea is to just
    track the "about" page, or maybe the index. Do we want to add this to every
    page? In any case, some ideas are to use git for this.

    First: from racket, get the ◊l["https://stackoverflow.com/a/16843630" #:ext #t]{name of the file}; second, get the last commit that touched the file, and the date. The command looks something like:

    ◊pre{
        ◊code{git log -n 1 --pretty=format:%cD', ref '%H -- <file>}
    }
}

◊toggle[#:title "Series Ideas"]{
    Borrowed from Joel's ◊em{The Local Yarn}, series are "categories on steroids",
    that present the list of articles under the series in a different rendering,
    with an (optional) introduction at the top.

    In a particular piece, I can say "This piece is part of ...". Also, when browsing the pieces from a particular series, the snippet linking to the series should disappear.
}

◊toggle[#:title "Add (code) callouts"]{
    Borrowed from Asciidoc's ◊l["https://asciidoctor.org/docs/asciidoc-writers-guide/#listing-and-source-code-blocks" #:ext #t]{code callouts}, we could also add something similar (either in code, or in any piece of code). Do something similar to what Joel suggests about ◊l["https://github.com/mbutterick/pollen-users/issues/27#issuecomment-578420503" #:ext #t]{links}, separating urls in separate tags.

    For us, we could have a tag that inserts the callout number, in a similar style to what we do for footnotes. Another tag inserts the comment. We can also make the callout numbers ◊l["https://developer.mozilla.org/en-US/docs/Web/CSS/user-select" #:ext #t]{un-selectable}.
}
