#lang racket

(require txexpr
         pollen/core)

(provide note
         add-to-doc)

; A hash-table of footnotes, one entry per document
(define footnotes (make-hash))

(define (note . contents)
  (define doc-key (select-from-metas 'here-path (current-metas)))
  ; If there's no entry, add a new list for our footnotes
  (define footnote-list (hash-ref! footnotes doc-key empty))
  (define note-number (+ 1 (length footnote-list)))
  (define target-id (format "fn-~a" note-number))
  (define target-href (format "#fn-~a" note-number))
  (define src-id (format "fn-source-~a" note-number))
  (define src-href (format "#fn-source-~a" note-number))

  ; Append to the footnote list
  ; We'll get back to it when we build the entire document
  (hash-set! footnotes doc-key
    (append footnote-list
      (list `(p ([id ,target-id])
                ,(format "~a. " note-number)
                ,@contents
                (a ([href ,src-href] [class "footnote-backlink"]) "↩")))))

  `(sup (a ([href ,target-href] [id ,src-id] [class "footnote-forwardlink"]) ,(format "~a" note-number))))

(define (add-to-doc tx)
  (define doc-key (select-from-metas 'here-path (current-metas)))
  (define footnote-list (hash-ref! footnotes doc-key empty))
  (txexpr (get-tag tx)
          (get-attrs tx)
          `(,@(get-elements tx)
            ,(when/splice (not (empty? footnote-list))
            `(hr)
            `(h3 "Notes")) ,@footnote-list)))
