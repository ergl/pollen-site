#lang racket

(require txexpr
         pollen/core
         pollen/cache
         pollen/file)

(provide all-post-metas last-posts all-posts)

(define (last-posts n [path "posts"])
  (define post-elements (all-post-elements path))
  (define len (min n (length post-elements)))
  (define elements (take post-elements len))
  (define ils (map (lambda (el) `(li ([class "post-li"]) ,el)) elements))

  `(ul ([class "no-bullet"]) ,@ils))

(define (all-posts [path "posts"])
  (define post-elements (all-post-elements path))
  (define ils (map (lambda (el) `(li ([class "post-li"]) ,el)) post-elements))

  `(ul ([class "no-bullet"]) ,@ils))

(define (all-post-metas path)
  ; Get all the paths to posts in the given folder path
  (define (all-post-paths posts-path)
    (define (valid-path path)
      (define file-path (file-name-from-path path))
      (cond
        [(false? file-path) #f]
        [else
         (define path-string (path->string file-path))
         (and (not (string-prefix? path-string "index"))
              (or (string-suffix? path-string "pmd") (string-suffix? path-string "pm")))]))
    (find-files valid-path posts-path))

  ; Get all metas in the given folder
  ; Uses all-post-paths underneath
  (define (all-metas posts-path)
    (define (append-path path)
      (hash-set (cached-metas path) '_output (path->string (->output-path path))))
    (map append-path (all-post-paths posts-path)))

  ; Sort metas by published date
  ; metas _must_ contain a published meta key
  (define (sort-by-date metas)
    (sort metas string>? #:key (lambda (m) (select 'published m))))

  (sort-by-date (all-metas path)))

(define (all-post-elements path)
  ; Convert a list of post metas into a list of HTML links
  (define (make-links-for metas)
    (define (make-link-for meta)
      `(a ((href ,(select '_output meta))) ,(select 'title meta)))
    (map make-link-for metas))

  (define (render-post meta)
    (define entry-descr (select 'description meta))
    (define post-elt
    `(div ([class "post-entry"])
          (p ([class "post-entry-link"])
             (a ((href ,(select '_output meta))) ,(select 'title meta)))
          (p ([class "post-entry-date"]) ,(format "~a" (select 'published meta)))))
    (txexpr (get-tag post-elt) (get-attrs post-elt) `(,@(get-elements post-elt)
                                                      ,(when/splice entry-descr `(p ([class "post-entry-descr"]) ,entry-descr)))))


  (map render-post (all-post-metas path)))
