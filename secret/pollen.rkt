#lang racket

(require pollen/template "../pollen.rkt")
(provide (all-from-out "../pollen.rkt")
         (all-defined-out))

; Don't reveal article name on metas
(define draft-title (format "~a — ~a" "Secrets" site-name))
