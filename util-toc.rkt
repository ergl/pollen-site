#lang racket

(require txexpr
         pollen/core)

(provide section
         subsection
         add-toc)

; A hash-table of tocs, one entry per document
(define tocs (make-hash))

(define (section #:label [reference 'nil] name)
    (define doc-key (select-from-metas 'here-path (current-metas)))
    (define doc-toc (hash-ref! tocs doc-key make-hash))

    (define section-list (hash-ref! doc-toc 'section-list empty))
    (define section-number (+ 1 (length section-list)))
    (define target-id (format "toc-s-~a" section-number))
    (define target-href (format "#toc-s-~a" section-number))

    (define link-content
      `(li ([class "toc-s"])
        (a ([href ,target-href] [class "toc-link"]) ,name)))

    (define reference-name
        (if (eq? reference 'nil) name reference))

    (define entry (make-hash))
    (hash-set! entry 'ref reference-name)
    (hash-set! entry 'anchor target-href)
    (hash-set! entry 'content link-content)

    (hash-set*! doc-toc
        'subsection-counter 0 ; Reset the subsection counter
        'section-list (append section-list (list entry)))

    (hash-set! tocs doc-key doc-toc)

    `(h2 ([id ,target-id])
        (a ([name ,(format "~a" reference-name)]))
        ,name))

(define (subsection #:label [reference 'nil] name)
    (define doc-key (select-from-metas 'here-path (current-metas)))
    (define doc-toc (hash-ref! tocs doc-key make-hash))

    (define section-list (hash-ref! doc-toc 'section-list empty))
    (define subsection-list (hash-ref! doc-toc 'subsection-list empty))
    (define subsection-counter (+ 1 (hash-ref! doc-toc 'subsection-counter 0)))

    (define parent-number (length section-list))
    (define target-id (format "toc-s-~a-~a" parent-number subsection-counter))
    (define target-href (format "#~a" target-id))
    ; The link that goes on the TOC
    (define link-content
        `(li ([class "toc-ss"])
             (a ([href ,target-href] [class "toc-link"]) ,name)))

    ; The current parent is always the last inserted section
    (define parent-ref (hash-ref (last section-list) 'ref))
    ; If the caller gave us a ref, use it, otherwise our name
    (define reference-name (if (eq? reference 'nil) name reference))
    (define entry (make-hash))
    (hash-set! entry 'parent-ref parent-ref)
    (hash-set! entry 'ref reference-name)
    (hash-set! entry 'anchor target-href)
    (hash-set! entry 'content link-content)

    (hash-set*! doc-toc
        'subsection-counter subsection-counter
        'subsection-list (append subsection-list (list entry)))

    (hash-set! tocs doc-key doc-toc)

    `(h3 ([id ,target-id])
         (a ([name ,(format "~a" reference-name)]))
         ,name))

(define (sublinks-for reference subsection-list)
  (filter-map
    (lambda (elt)
        (if (eq? reference (hash-ref elt 'parent-ref))
            (hash-ref elt 'content)
            #f))
    subsection-list))

(define (add-to-parent parent elems)
    (txexpr (get-tag parent)
            (get-attrs parent)
            `(,@(get-elements parent)
              ,(when/splice (not (empty? elems))
                `(ol ([type "a"]) ,@elems)))))

; Go over the section list, and retrieve its subsections as we go
(define (build-toc-elements document-toc)
    (foldl
        (lambda (elt acc)
            (define ref (hash-ref elt 'ref))
            (define content (hash-ref elt 'content))
            (define sub-links (sublinks-for ref (hash-ref! document-toc 'subsection-list empty)))
            (define new-entry (add-to-parent content sub-links))
            (append acc (list new-entry)))
        empty
        (hash-ref! document-toc 'section-list empty)))

(define (add-toc tx)
    (define doc-key (select-from-metas 'here-path (current-metas)))
    (define toc-elems (build-toc-elements (hash-ref! tocs doc-key make-hash)))
    ; Aside, so it doesn't get included in the reader view
    (define (format-toc toc)
            `(aside (details ([id "table-of-contents-wrap"])
                (summary "Table of Contents")
                (nav ([id "table-of-contents"])
                     (ol ([type "1"]) ,@toc)))))

    (txexpr (get-tag tx)
            (get-attrs tx)
            `(,(when/splice (not (empty? toc-elems))
                (format-toc toc-elems))
              ,@(get-elements tx))))
