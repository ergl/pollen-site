#lang racket

(require txexpr
         pollen/core)

(provide section
         subsection
         add-toc)

(define section-list empty)

(define subsection-counter 0)
(define subsection-list empty)

(define (section name)
    ; Reset the subsection counter
    (set! subsection-counter 0)

    (define section-number (+ 1 (length section-list)))
    (define target-id (format "toc-s-~a" section-number))
    (define target-href (format "#toc-s-~a" section-number))

    (set! section-list
          (append section-list
                  (list `(li ([class "toc-s"])
                             (a ([href ,target-href] [class "toc-link"]) ,name)))))

    `(h2 ([id ,target-id]) ,name))

(define (subsection name)
    (set! subsection-counter (+ 1 subsection-counter))

    (define parent-number (length section-list))
    (define target-id (format "toc-s-~a-~a" parent-number subsection-counter))
    (define target-href (format "#toc-s-~a-~a" parent-number subsection-counter))

    ; We add the content consed with the parent index so we can merge them with
    ; the parent later (see next function).
    (set! subsection-list
          (append subsection-list
                  (list (cons parent-number
                              `(li ([class "toc-ss"])
                                   (a ([href ,target-href] [class "toc-link"]) ,name))))))

    `(h3 ([id ,target-id]) ,name))

(define (subsections-for index)
  (filter-map (lambda (elt) (if (= index (car elt))
                                (cdr elt)
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
    (cdr (foldl (lambda (elt result)
                (define idx (car result))
                (define l-acc (cdr result))

                (define subs (subsections-for idx))
                (define new-alt (add-to-parent elt subs))

                (cons (+ 1 idx) (append l-acc (list new-alt))))
            (cons 1 empty)
            section-list)))

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
