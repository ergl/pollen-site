#lang racket

(require txexpr
         racket/string
         racket/date
         pollen/core)

(provide rss-feed)

;; From https://thelocalyarn.com/code/artifact/e414aebe97ea8e9f

;; For the feed "updated" value, we do want a complete timestamp.
(define (current-rfc3339)
  ;; #f argument to seconds->date forces a UTC timestamp
  (define now (seconds->date (* 0.001 (current-inexact-milliseconds)) #f))
  (define timestamp
    (parameterize [(date-display-format 'iso-8601)]
      (date->string now #t)))
  (string-append timestamp "Z"))

;; Atom feeds require dates to be in RFC 3339 format
;; Our published/updated dates only give year-month-day. No need to bother about time zones or DST.
;; So, arbitrarily, everything happens at a quarter of noon UTC.
(define (ymd->rfc3339 datestr)
  (format "~aT11:45:00Z" datestr))

(define (rss-feed site-name
                  site-author
                  site-url
                  site-description
                  post-path
                  feed-path
                  all-post-metas)

  (define site-domain (string-append "https://" site-url))

  (define (render-post meta)
    (define post-title (select 'title meta))
    (define post-summary (select 'description meta))
    (define post-url (string-append "https://" site-url "/" (select '_output meta)))
    (define post-date (ymd->rfc3339 (select 'published meta)))

    `(entry (title ,post-title)
            (author (name ,site-author))
            (link [(rel "alternate") (href ,post-url)])
            (id ,post-url)
            (published ,post-date)
            (updated ,post-date)
            (summary ,post-summary)))

  `(feed [(xml:lang "en-us") (xmlns "http://www.w3.org/2005/Atom")]
      (title ,site-name)
      (link [(rel "self") (href ,feed-path)])
      (link [(rel "alternate") (href ,site-domain)])
      (updated ,(current-rfc3339))
      (author (name ,site-author)
              (uri ,site-domain))
      (id ,site-domain)
      (subtitle ,site-description)
      ,@(map render-post (all-post-metas post-path))))
