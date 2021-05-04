#lang racket/base

(require txexpr
         pollen/setup
         pollen/tag
         pollen/decode
         quadwriter)

(provide (all-defined-out) render-pdf)

(define raw-pdf-font-size 12)
(define pdf-font-size (format "~apt" raw-pdf-font-size))
(define (pdf-adjust-font-size mult)
  (format "~apt" (* raw-pdf-font-size mult)))

(module setup racket/base
  (provide (all-defined-out))
  (define poly-targets '(html pdf)))

(define (root . elements)
  (case (current-poly-target)
   [(pdf) `(q [(footer-display "false")
               (page-size "a4")
               (page-margin-left "2.5cm")
               (page-margin-right "2.5cm")]
               ,@elements)]
   [else `(@ ,@elements)]))

(define-tag-function (text attrs elems)
  (case (current-poly-target)
    [(pdf) `(q [(keep-first-lines "2")
                (keep-last-lines "3")
                (font-size ,pdf-font-size)
                (hyphenate "true")
                (line-align "justify")]
              ,@elems ,para-break)]
    [else `(p ,@elems)]))

(define (heading . elements)
  (case (current-poly-target)
    [(pdf) `(q [(display "block")
                (font-size ,(pdf-adjust-font-size 2))
                (inset-bottom "15")
                (keep-with-next "true")]
                ,page-break
                ,@elements
                ,para-break)]
    [else `(h2 [] (a [(href "/") (id "heading-link")] ,@elements))]))

(define-tag-function (publication attrs elements)
  (let* ([hash-attrs (attrs->hash attrs)]
         [title (hash-ref hash-attrs 'title)]
         [authors (hash-ref hash-attrs 'authors)]
         [date (hash-ref hash-attrs 'date)]
         [link (hash-ref hash-attrs 'link "")]
         [place (hash-ref hash-attrs 'place "")]
         [venue (hash-ref hash-attrs 'venue)]
         [type (hash-ref hash-attrs 'type)])

    (case (current-poly-target)
      [(pdf) `(q
                (q [(font-size ,(pdf-adjust-font-size 0.9))]
                   ,type)
                (q [(display "block")
                    (font-size ,pdf-font-size)
                    (hyphenate "true")]
                  ,para-break
                  ,(format "~a, " authors)
                  (q [(font-italic "true")
                      (font-size ,pdf-font-size)]
                     ,(format " ~a. " title)))
                  ,(format "~a. " venue)
                  ,(if (not (eq? link ""))
                    `(q [(link ,link) (font-color "#EA5A5B")] ,link)
                    `(q ""))
                  ,para-break)]

      [else `(div [(class "publication")]
                (h5 ,type)
                (p ,(format "~a," authors)
                   (em ,(format " ~a." title))
                   ,(format " ~a. " venue)
                   ,(if (not (eq? link ""))
                      `(a [(href ,link)] ,link)
                      `"")))])))

(define-tag-function (job attrs elements)
  (let* ([hash-attrs (attrs->hash attrs)]
         [position (hash-ref hash-attrs 'position)]
         [company (hash-ref hash-attrs 'company)]
         [start (hash-ref hash-attrs 'start)]
         [end (hash-ref hash-attrs 'end #f)]
         [start-end (string-append start (if end (format "—~a" end) ""))])

    (case (current-poly-target)
      [(pdf) `(q ,company
                 ,line-break
                 (q [(font-size ,(pdf-adjust-font-size 0.9))
                     (font-italic "true")]
                     ,position)
                 ,line-break
                 (q [(font-size ,(pdf-adjust-font-size 0.75))
                     (font-italic "true")]
                     ,start-end)
                 ,(when elements
                  `(q [(display "block")
                       (font-size ,pdf-font-size)
                       (hyphenate "true")
                       (line-align "justify")
                       (inset-left "10")
                       (inset-right "10")]
                      ,para-break
                      ,@elements))
                    ,para-break)]

      [else `(div [(class "job")]
                  (h4 ,company)
                  (h5 (em ,position))
                  (h6 ,start-end)
                  (p ,@elements))])))

(define-tag-function (link attrs elems)
  (let* ([hash-attrs (attrs->hash attrs)]
         [addr (hash-ref hash-attrs 'addr)])
    (case (current-poly-target)
      [(pdf) `(q [(link ,addr) (font-color "#EA5A5B")] ,@elems)]
      [else `(a ((href ,addr)) ,@elems)])))

(define-tag-function (email attrs elems)
  (let* ([addr (format "mailto:~a" (car elems))])
    (case (current-poly-target)
      [(pdf) `(q [(link ,addr) (font-color "#EA5A5B")] ,@elems)]
      [else `(a [(href ,addr)] ,@elems)])))

(define-tag-function (itemize attrs elems)
  (case (current-poly-target)
    [(pdf) `(q [] ,@elems ,para-break)]
    [else (txexpr 'ul attrs elems)]))

(define-tag-function (item attrs elems)
  (case (current-poly-target)
    [(pdf) `(q [] ,@elems ,line-break)]
    [else (txexpr 'li attrs elems)]))

(define-tag-function (skill attrs elems)
  (let* ([hash-attrs (attrs->hash attrs)]
         [level (hash-ref hash-attrs 'level)])
    (case (current-poly-target)
      [(pdf) `(q [] ,@elems (q [(font-italic "true")] ,(format " (~a)" level)))]
      [else `(@ ,@elems " (" (em (strong ,level)) ")")])))

(define-tag-function (section attrs elems)
  (let* ([hash-attrs (attrs->hash attrs)]
         [title (hash-ref hash-attrs 'title #f)]
         [id (hash-ref hash-attrs 'id #f)])
    (case (current-poly-target)
      [(pdf) `(q ,(when title
                        `(q [(first-line-indent "0")
                             (font-size ,(pdf-adjust-font-size 1.2))
                             (font-bold "true")
                             (keep-with-next "true")]
                             ,para-break
                             ,title
                             ,para-break))
                  (q [(font-size ,pdf-font-size)] ,@elems ,para-break))]
      [else `(div ((class "section") ,(when id `(id ,id))) ,(when title `(h3 ,title)) ,@elems)])))

(define-tag-function (class attrs elems)
  (let* ([hash-attrs (attrs->hash attrs)]
         [start (hash-ref hash-attrs 'start)]
         [end (hash-ref hash-attrs 'end #f)]
         [name (hash-ref hash-attrs 'name)]
         [place (hash-ref hash-attrs 'place)]
         [location (hash-ref hash-attrs 'location)]
         [start-end (string-append start (if end (format "—~a" end) ""))])
    (case (current-poly-target)
      [(pdf) `(q ,name
                 ,line-break
                 (q [(font-size ,(pdf-adjust-font-size 0.9))]
                    (q [(font-italic "true")] ,place)
                    ,(format ", ~a" location))
                  ,line-break
                  (q [(font-size ,(pdf-adjust-font-size 0.75))
                      (font-italic "true")]
                      ,start-end))]
      [else `(div [(class "education")]
                  (h4 ,name)
                  (h5 (em ,place) ", " ,location)
                  (h6 ,start-end))])))

(define (em . elements)
  (case (current-poly-target)
    [(pdf) `(q [(font-italic "true")] ,@elements)]
    [else `(em ,@elements)]))

(define-tag-function (language attrs elems)
  (let* ([hash-attrs (attrs->hash attrs)]
         [level (hash-ref hash-attrs 'level)])
    (case (current-poly-target)
      [(pdf) `(q (q [(font-italic "true")] ,@elems) ,(format " (~a)" level))]
      [else `(@ (em ,@elems) ,(format " (~a)" level))])))
