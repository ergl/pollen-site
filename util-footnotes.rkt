#lang racket

(require txexpr
         pollen/core)

(provide note
         add-to-doc)

; A list that will contain all footnotes for the current document
(define footnote-list empty)

(define (note . contents)
  (define note-number (+ 1 (length footnote-list)))
  (define target-id (format "fn-~a" note-number))
  (define target-href (format "#fn-~a" note-number))
  (define src-id (format "fn-source-~a" note-number))
  (define src-href (format "#fn-source-~a" note-number))
  (set! footnote-list
        (append footnote-list (list `(p ([id ,target-id]) ,(format "~a. " note-number) ,@contents (sup (a ([href ,src-href] [class "footnote-backlink"]) "[return]︎"))))))
  `(sup (a ([href ,target-href] [id ,src-id] [class "footnote-forwardlink"]) ,(format "~a" note-number))))

(define (add-to-doc tx)
  (txexpr (get-tag tx) (get-attrs tx) `(,@(get-elements tx) ,(when/splice (not (empty? footnote-list)) `(hr) `(h3 "Notes"))
                                                            ,@footnote-list)))

