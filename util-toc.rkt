#lang racket

(require txexpr
         pollen/core)

(provide section
         subsection
         add-toc)

(define section-list empty)

(define subsection-counter 0)
(define subsection-list empty)

(define (section #:label [reference 'nil] name)
    ; Reset the subsection counter
    (set! subsection-counter 0)

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

    (set! section-list (append section-list (list entry)))

    `(h2 ([id ,target-id])
        (a ([name ,(format "~a" reference-name)]))
        ,name))

(define (subsection #:label [reference 'nil] name)
    (set! subsection-counter (+ 1 subsection-counter))

    (define parent-number
        (length section-list))

    (define parent-ref
        (hash-ref (last section-list) 'ref))

    (define target-id
        (format "toc-s-~a-~a" parent-number subsection-counter))

    (define target-href
        (format "#toc-s-~a-~a" parent-number subsection-counter))

    (define link-content
      `(li ([class "toc-ss"])
        (a ([href ,target-href] [class "toc-link"]) ,name)))

    (define reference-name
        (if (eq? reference 'nil) name reference))

    (define entry (make-hash))
    (hash-set! entry 'ref reference-name)
    (hash-set! entry 'parent-ref parent-ref)
    (hash-set! entry 'anchor target-href)
    (hash-set! entry 'content link-content)

    (set! subsection-list (append subsection-list (list entry)))

    `(h3 ([id ,target-id])
        (a ([name ,(format "~a" reference-name)]))
        ,name))

(define (sublinks-for reference)
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
(define (build-toc-elements)
    (foldl
        (lambda (elt acc)
            (define ref (hash-ref elt 'ref))
            (define content (hash-ref elt 'content))
            (define sub-links (sublinks-for ref))
            (define new-entry (add-to-parent content sub-links))
            (append acc (list new-entry)))
        empty
        section-list))

(define (add-toc tx)
    (define toc-elems (build-toc-elements))
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
