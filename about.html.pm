#lang pollen

◊(define-meta meta-title "About")

◊h2{About me}

You thought I was going to tell you about my life? Well, maybe some other time.
In the meantime, please enjoy my professional life detailed below, or check out
◊l["/cv" #:ext #t]{my CV} (I'll code for money).

◊h3{Articles}

◊; TODO(borja): Add command for articles, see Chris' website
◊; http://christophermeiklejohn.com/publications.html
◊; for formatting ideas
◊ul{
    ◊li{B. A. de R. Basáñez and C. S. Meiklejohn, "Dynamic Path Contraction for Distributed, Dynamic Dataflow Languages",
    Sep. 2016 (◊l["http://arxiv.org/abs/1609.01068" #:ext #t]{arXiv:1609.01068}).

    I gave a talk about it at ◊l["https://2016.splashcon.org/details/agere2016/3/Dynamic-Path-Contraction-for-Distributed-Dataflow-Languages" #:ext #t]{AGERE! 2016}.
    }
}

◊h3{Code}

Here's a sample of projects I've done and collaborated in:

◊ul{
    ◊li{◊l["https://github.com/AntidoteDB/antidote" #:ext #t]{AntidoteDB}: An AP transactional database using CRDTs.}
    ◊li{◊l["https://github.com/lasp-lang/lasp" #:ext #t]{Lasp}: A language and collection of Erlang libraries to build distributed systems.}
    ◊li{◊l["https://github.com/ergl/pipesock" #:ext #t]{pipesock}: An Erlang TCP client that offers automatic batching and pipelining of messages across connections.}
    ◊li{◊l["https://github.com/ergl/crdt-ml" #:ext #t]{crdt-ml}: A collection of CRDTs in OCaml.}
    ◊li{◊l["https://github.com/ergl/pony-docset" #:ext #t]{pony-docset}: A ◊l["https://kapeli.com/dash" #:ext #t]{Dash} docset for the ◊l["https://www.ponylang.io/" #:ext #t]{Pony} programming language.}
    ◊li{◊l["https://github.com/ergl/clojurebot" #:ext #t]{clojurebot}: A Clojure REPL bot for Telegram Messenger.}
    ◊li{◊l["https://github.com/Pysellus/pysellus" #:ext #t]{pysellus}: A little DSL and Python library to test and monitor data streams.}
}

◊h2{About this site}

This site is written and published using ◊l["https://docs.racket-lang.org/pollen/"]{Pollen}. It also does not allow comments, but if you want to discuss anything, shoot me an ◊l["mailto:borjaocook@gmail.com"]{email}, or text me on ◊l["http://t.me/king_of_manlets" #:ext #t]{Telegram}.

Many thanks to ◊l["https://thelocalyarn.com" #:ext #t]{Joel Dueck} for indirectly helping to create the ◊l[◊|atom-path|]{RSS feed} through his code. You can find the complete in the ◊l["https://github.com/ergl/pollen-site/blob/master/util-rss.rkt"]{github repo}.

◊|site-license|
