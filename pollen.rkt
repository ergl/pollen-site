#lang racket

(require pollen/decode
         txexpr
         pollen/core
         pollen/template
         racket/list
         racket/function
         (prefix-in footnotes: "util-footnotes.rkt")
         "util-posts.rkt")

(provide (all-from-out "util-posts.rkt")
         (rename-out [footnotes:note note])
         (all-defined-out))

; TODO(borja): Clean this up

(define site-name "Wrong opinions, all the time")
(define site-description "Welcome to my blog / scratch note place.")
(define site-license
  `(p "All posts licensed under a "
      (a [(href "http://creativecommons.org/licenses/by-nc-sa/4.0/")
          (target "_blank")
          (rel "noopener")
          (class "external")] "CC BY-NC-SA 4.0")
      ". Code examples are, except otherwise noted, licensed under the MIT License."))

; Append the title, date, and main title information
; to the main document with h1, h2, etc
;
; TODO(borja): Clean this up, I realized I have no idea
; of how txexpr works
(define (build-document doc metas)
  (define title (select 'title metas))
  (define date (select 'published metas))

  (define with-date (if date
                        `(div (h3 ,date) ,@(get-elements doc))
                        doc))

  (define with-title (if title
                         `(div (h2 ,title) ,@(get-elements with-date))
                         with-date))

  (txexpr 'div '[(id "pcontainer")] (get-elements with-title)))

; Break paragraphs on double enter, but don't break lines
(define smart-paragraphs (lambda (el) (decode-paragraphs el #:linebreak-proc identity)))

; Convert dashes to hyphens and quotes to smart quotes
(define quotes-and-dashes (compose1 smart-quotes smart-dashes))

(define (root . elements)
  (footnotes:add-to-doc
    (txexpr 'div empty
      (decode-elements elements #:txexpr-elements-proc smart-paragraphs
                                #:string-proc quotes-and-dashes
                                #:exclude-tags '(code)))))

; If the metas define a canonical url, insert it into the document
; as a meta attribute
(define (canonicalize metas)
  (define canonical-url (select 'canonical metas))
  (when canonical-url
    (->html `(l ((rel "canonical") (href ,canonical-url))))))

(define (drop-cap word . paragraph)
  (define word-list (string->list word))
  (define first-letter (string (car word-list)))
  (define rest (list->string (cdr word-list)))
  `(p [(class "dropcap-wrap")]
      (span [(class "dropcap")] ,first-letter) ,rest ,@paragraph))

; If the metas define a redirect-to url, create a client-side
; redirect, after redirect-to-secs seconds
; XXX(borja): This probably should be handled server-side, but
; github doesn't let us redirect pages unless we use jekyll
(define (maybe-redirect metas)
  (define url (select 'redirect-to metas))
  (define secs (select 'redirect-to-secs metas))
  (when (and url secs)
    (->html `(meta ((http-equiv "refresh")
                    (content ,(format "~a;url=~a" secs url)))))))

; Won't work since this is called from template,
; and not during document creation
#;(define (maybe-import-highlight)
  (when needs-code-js
    (->html `(script ([src "/path/to/lib.js"])))))

; If the document has a title meta, use that for the html title
; otherwise use the page title
(define (doc-title metas)
  (define title (select 'title metas))
  (define meta-title (select 'meta-title metas))

  ; The title might be used shown to the user (title),
  ; or not (meta-title)
  (if meta-title
      (format "~a — ~a" meta-title site-name)
      (if title
          (format "~a — ~a" title site-name)
          site-name)))

; If the document has a description meta, use that, otherwise
; use the default site-wide description
(define (doc-description metas)
  (define description (select 'description metas))
  (if description description
                  site-description))

; Simple blockquote structure. The author is added at the end
; with a simple em dash and a hair space
(define (blockquote #:author [author #f] . contents)
  `(blockquote (p ,@contents) ,(when/splice author `(footer ,(format "—\u2006~a" author)))))

(define (toggle #:title [header #f] . contents)
  `(details ,(when/splice header `(summary ,header)) (div [(class "toggle-content")] (p ,@contents))))

; An html link. If #:ext is true, this link
; will open in a new tab
(define (l addr #:ext [external #f] . contents)
  (define attrs (if external
                    `((href ,addr) (target "_blank") (rel "noopener") (class "external"))
                    `((href ,addr))))
  (if (empty? contents)
    `(a ,attrs ,addr)
    `(a ,attrs ,@contents)))

; Ugh, why is racket single-pass?
(define site-sections
  `(ul [(class "main-menu")]
    (li [(id "nav-home")] ,(l "/" "home"))
    (li ,(l "/posts" "blog"))
    (li ,(l "/wiki/index.html" "wiki"))
    (li ,(l "/misc.html" "misc"))
    (li ,(l "/about.html" "about"))))

; TODO(borja): Add CSS marker to current page
; Using the here-path meta key we could figure out
; where in the tree we are
;
; Other options is to user the pagetree to get parents,
; or childs. For example, all would have "posts" as parent
; whereas root pages would have #f as parent
(define site-navigation `(header (nav ,site-sections)))

; The body of a page that will be redirected client-side
(define (redirect-msg url secs)
  `(p "This page has moved to a "
      ,(l url "new location")
      ,(format ". You can either follow the link, or wait ~a seconds to be automatically redirected"
               secs)))

; TODO(borja): Add js to document only if this is true
; See tutorial https://docs.racket-lang.org/pollen/mini-tutorial.html
#;(define needs-code-js #f)
(define (codeblock lang . contents)
  ;(set! needs-code-js #t)
  `(pre (code ([class ,(format "~a" lang)]) ,@contents)))

(module setup racket/base
  (provide (all-defined-out))
  (require racket)
  ; Drafts live in drafts/
  (define omitted-path?
    (lambda (path)
      (define strpath (path->string path))
      (or
        (string-contains? strpath "drafts")
        (string-contains? strpath "secret")
        (string-contains? strpath "template")
        (string-suffix? strpath "LICENSE")
        (string-suffix? strpath "~")))))
