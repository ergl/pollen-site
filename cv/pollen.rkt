#lang racket/base

(require txexpr pollen/setup pollen/tag pollen/decode)
(provide (all-defined-out))

(module setup racket/base
  (provide (all-defined-out))
  (define poly-targets '(html ltx pdf)))

(define (root . elements)
  `(@ ,@elements))

(define-tag-function (explicit-p attrs elems)
  (txexpr 'p empty (decode-elements elems
                                       #:txexpr-elements-proc decode-paragraphs
                                       #:string-proc (compose1 smart-quotes smart-dashes))))

(define (heading . elements)
  (case (current-poly-target)
    [(ltx pdf) (apply string-append `("{\\LARGE " ,@elements "}\\[.2cm]"))]
    [else (txexpr 'h2 empty elements)]))

(define-tag-function (job attrs elements)
  (let* ([hash-attrs (attrs->hash attrs)]
         [position (hash-ref hash-attrs 'position)]
         [company (hash-ref hash-attrs 'company)]
         [start (hash-ref hash-attrs 'start)]
         [end (hash-ref hash-attrs 'end #f)])
    `(div ((class "job"))
          (h4 ,company)
          (h5 (em ,position))
          (h6 ,(string-append start (if end (format "—~a" end) "")))
          (p ,@elements))))


(define-tag-function (link attrs elems)
  (let* ([hash-attrs (attrs->hash attrs)]
         [addr (hash-ref hash-attrs 'addr)])
  `(a ((href ,addr)) ,@elems)))

(define-tag-function (email attrs elems)
  `(a ((href ,(format "mailto:~a" (car elems)))) ,@elems))

(define-tag-function (address attrs elems)
  `(p ,@elems))

(define-tag-function (personal attrs elems)
  `(ul ,@(map (lambda (el) `(li ,el)) elems)))

(define-tag-function (skill attrs elems)
  (let* ([hash-attrs (attrs->hash attrs)]
         [level (hash-ref hash-attrs 'level)])
    `(@ ,@elems " (" (em (strong ,level)) ")")))

(define-tag-function (section attrs elems)
  (let* ([hash-attrs (attrs->hash attrs)]
         [title (hash-ref hash-attrs 'title #f)]
         [id (hash-ref hash-attrs 'id #f)])
  `(div ((class "section") ,(when id `(id ,id))) ,(when title `(h3 ,title)) ,@elems)))

(define-tag-function (class attrs elems)
  (let* ([hash-attrs (attrs->hash attrs)]
         [start (hash-ref hash-attrs 'start)]
         [end (hash-ref hash-attrs 'end #f)]
         [name (hash-ref hash-attrs 'name)]
         [place (hash-ref hash-attrs 'place)]
         [location (hash-ref hash-attrs 'location)])
    `(div ((class "education"))
          (h4 ,name)
          (h5 (em ,place) ", " ,location)
          (h6 ,(string-append start (if end (format "—~a" end) ""))))))

(define-tag-function (language attrs elems)
  (let* ([hash-attrs (attrs->hash attrs)]
         [level (hash-ref hash-attrs 'level)])
    `(@ (em ,@elems) ,(format " (~a)" level))))

(define (emph . elements)
  (case (current-poly-target)
    [(txt) `("**" ,@elements "**")]
    [(ltx pdf) (apply string-append `("{\\bf " ,@elements "}"))]
    [else (txexpr 'strong empty elements)]))

