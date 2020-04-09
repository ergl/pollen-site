#lang pollen

◊heading{Borja de Régil}

◊section[#:id "contact-section"]{
    ◊itemize{◊item{
        ◊itemize{
            ◊item{◊email{borjaocook@gmail.com}}
            ◊item{◊link[#:addr "https://github.com/ergl"]{github.com/ergl}}
            ◊item{◊link[#:addr "https://twitter.com/brocooks"]{@brocooks}}
        }
    }}
}

◊section{
    ◊text{
        I am interested in writing fast–and–correct distributed systems
        and scalable peer-to-peer networks.
    }
}

◊section[#:title "Areas of Interest"]{
    ◊itemize{
        ◊item{Distributed Systems}
        ◊item{Databases}
        ◊item{Conflict-Free Replicated Data Types (CRDTs)}
    }
}

◊section[#:title "Skills"]{
    ◊itemize{
        ◊item{◊skill[#:level "Professional Experience"]{Erlang, Bash, Javascript (Node)}}
        ◊item{◊skill[#:level "Fluent"]{Java, Python, Pony}}
        ◊item{◊skill[#:level "Familiar"]{C, OCaml, Clojure, R}}
    }
}

◊section[#:id "jobs" #:title "Previous Experience"]{◊itemize{
    ◊item{◊job[#:start "October 2016"
               #:end "Current"
               #:position "Research Intern"
               #:company "Imdea Software Institute"]{

    Implemented and evaluated a new transactional protocol for strongly consistent
    distributed databases; implemented a relational (SQL) model adapter for key-value
    distributed storage; tested distributed programs via property checking (model
    checking); implemented an open-source library for batching and multiplexing of
    TCP connections, which allowed to scale systems to handle up to 2.5 times more
    requests per second.}}

    ◊item{◊job[#:start "Summer 2016"
                #:company "Google Summer of Code"
                #:position "Alumni"]{

    Improved run-time performance of the Lasp programming language by applying deforestation techniques and control flow analysis.}}

    ◊item{◊job[#:start "Summer 2015"
               #:company "H4ckademy Programming School"
               #:position "Alumni"]{

    Co-designed and implemented a domain-specific language in Python that would let users write unit test against streaming APIs.}}
}}

◊section[#:title "Publications"]{◊itemize{◊item{
    ◊publication[
        #:title "Dynamic Path Contraction for Distributed, Dynamic Dataflow Languages"
        #:authors "Borja Arnau de Régil Basáñez, Christopher Meiklejohn"
        #:date "2016"
        #:link "http://arxiv.org/abs/1609.01068"
        #:place "Amsterdam, Netherlands"
        #:venue "AGERE 2016"
        #:type "Workshop"
        ]
}}}

◊section[#:title "Education"]{◊itemize{◊item{
    ◊class[#:start "Class of 2020"
           #:name "B.S in Computer Science"
           #:place "Complutense University of Madrid"
           #:location "Madrid"]{}
}}}

◊section[#:title "Languages"]{◊itemize{
    ◊item{◊language[#:level "Native"]{Spanish}}
    ◊item{◊language[#:level "Full professional proficiency"]{English}}
}}
