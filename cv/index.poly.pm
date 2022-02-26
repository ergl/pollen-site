#lang pollen

◊heading{Borja de Régil}

◊section[#:id "contact-section"]{
    ◊itemize{◊item{
        ◊itemize{
            ◊item{◊email{borjaocook@gmail.com}}
            ◊item{◊link[#:addr "https://deregil.es"]{deregil.es}}
            ◊item{◊link[#:addr "https://github.com/ergl"]{github.com/ergl}}
        }
    }}
}

◊section{
    ◊text{
        Making strong consistency scale.
    }
}

◊section[#:title "Areas of Interest"]{
    ◊itemize{
        ◊item{Distributed and Storage Systems}
        ◊item{Strong (consensus) and Weak Consistency (CRDTs)}
        ◊item{Thread-per-core programming language runtimes}
    }
}

◊section[#:title "Education"]{◊itemize{◊item{
    ◊class[#:start "June 2020"
           #:name "B.S. in Computer Science"
           #:place "Complutense University of Madrid"
           #:location "Madrid"]{}
}}}

◊section[#:id "jobs" #:title "Experience"]{◊itemize{
    ◊item{◊job[#:start "June 2020"
               #:end "Current"
               #:position "Research/Development Engineer"
               #:company "Imdea Software Institute"]{

    Developer of Unistore, a fault-tolerant data store combining causal and strong
    consistency. Developed significant experience with fault-tolerant distributed
    consensus protocols (Paxos) and Conflict-free replicated data types (CRDTs).

    The work was funded by an ERC grant ◊em{A Rigorous Approach to Consistency in Cloud Databases}.}}

    ◊item{◊job[#:start "October 2016"
               #:end "May 2020"
               #:position "Research Intern"
               #:company "Imdea Software Institute"]{

    Developer of fastPSI, a transactional protocol for databases with flexible
    consistency semantics. Developed experience with property-based testing and TCP
    performance on high-latency scenarios. Extensive design of evaluation benchmarks.

    The work was funded by an ERC grant ◊em{A Rigorous Approach to Consistency in Cloud Databases}.}}

    ◊item{◊job[#:start "May 2016"
               #:end "Aug 2016"
               #:company "Google Summer of Code, BEAM Community"
               #:position "Participant"]{

    Improved the run-time performance of
    ◊link[#:addr "https://github.com/lasp-lang/lasp"]{Lasp}, a programming language for
    distributed, eventually consistent computations. Reduced end-to-end latency by
    applying deforestation techniques and control flow analysis in distributed dataflow
    scenarios.}}

    ◊; ◊item{◊job[#:start "Summer 2015"
    ◊;            #:company "H4ckademy Programming School"
    ◊;            #:position "Alumni"]{

    ◊; Co-designed and implemented a domain-specific language in Python that would
    ◊; let users write unit test against streaming APIs.}}
}}

◊section[#:title "Publications"]{◊itemize{
    ◊item{
        ◊publication[
            #:title "UniStore: A fault-tolerant marriage of causal and strong consistency"
            #:authors "Manuel Bravo, Alexey Gotsman, Borja de Régil and Hengfeng Wei"
            #:date "2021"
            #:link "[PDF]"
            #:link-url "https://www.usenix.org/system/files/atc21-bravo.pdf"
            #:venue "USENIX ATC '21"
            #:type "Conferences"
        ]
    }

    ◊item{
        ◊publication[
            #:title "Dynamic Path Contraction for Distributed, Dynamic Dataflow Languages"
            #:authors "Borja de Régil and Christopher Meiklejohn"
            #:date "2016"
            #:link "[arXiv preprint]"
            #:link-url "http://arxiv.org/abs/1609.01068"
            #:place "Amsterdam, Netherlands"
            #:venue "AGERE 2016"
            #:type "Workshops"
            ]
    }
}}

◊section[#:title "Skills"]{
    ◊itemize{
        ◊item{◊skill[#:level "Professional Experience"]{Go, Erlang, R, shell scripting}}
        ◊item{◊skill[#:level "Fluent"]{Java, Python, Pony, Javascript}}
        ◊item{◊skill[#:level "Familiar"]{C, OCaml, Clojure, Rust}}
    }
}

◊section[#:title "Languages"]{◊itemize{
    ◊item{◊language[#:level "Full professional proficiency"]{English}}
    ◊item{◊language[#:level "Native"]{Spanish}}
}}
