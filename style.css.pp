#lang pollen

◊; The CSS for the entire site is not very complex,
◊; it consists of a mix of foghorn (http://jasonm23.github.io/markdown-css-themes/)
◊; plus personal touches:
◊;  * remove dependency on Google Fonts, used only for the Vollkorn font, and
◊;    replaced it with Palatino
◊;
◊;  * adjust max-width and font size for better mobile experience
◊;
◊;  * change link color
◊;
◊;  * add first-letter for blog posts

◊;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

◊; first-letter, for nicer paragraphs
◊(define first-letter-size 3)
◊(define first-letter-color "#EA5A5B")
◊(define compat-first-letter-size 6)
◊(define compat-first-letter-spacing 2)

◊; might need to check for initial-letter compatibilty
◊; on Safari, the first letter will be inset with the text, whereas in Firefox
◊; and Chrome it will stand out
◊(define supports-initial-letter
   (format "(-webkit-initial-letter: ~a) or (initial-letter: ~a)"
           first-letter-size
           first-letter-size))

◊(define not-supports-initial-letter
   (format "(not (-webkit-initial-letter: ~a)) and (not (initial-letter: ~a))"
           first-letter-size
           first-letter-size))

@supports ◊|supports-initial-letter| {
  .dropcap-wrap::first-letter {
    -webkit-initial-letter: ◊|first-letter-size|;
    initial-letter: ◊|first-letter-size|;
    color: ◊|first-letter-color|;
  }
}

@supports ◊|not-supports-initial-letter| {
  .dropcap {
    font-size: ◊|compat-first-letter-size|rem;
    line-height: 1rem;
    color: ◊|first-letter-color|;
  }

  ◊; The wrapper div around the letter needs some spacing
  ◊; on top to prevent clash with the parent element
  .dropcap-wrap {
    padding-top: ◊|compat-first-letter-spacing|rem;
  }
}

◊;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

html, body {
  padding: 0.5em;
  margin: auto;
  max-width: 45em;
}

◊(define font-size 1.2)
◊(define font-color "#333")
◊(define background-color "#FFFEFC")

body {
  color: ◊|font-color|;
  background: ◊|background-color|;
  font: ◊|font-size|em Palatino, sans-serif;
  line-height: 1.6;
  ◊; TODO(borja): should do left + hyphenation
  text-align: justify;
  
}

header {
  padding-top: 0.5em;
}

img, video {
  min-width: 50%;
  max-width: 100%;
  margin: 0 auto;
}

h1, h2, h3 {
  line-height: 1.2;
  font-weight: normal;
}

h3 {
  font-style: italic;
}

p {
  margin-top: 0;
}

ul, ol {
  padding-left: 1.2em;
}

.main-menu {
  margin: 0 auto;
  text-align: left;
  list-style: none;
  padding-left: 0em;
}

.main-menu li {
  display: inline-block;
  margin-right: 0.6em;
}

.main-menu a {
  color: #5B627E;
}

#nav-home a {
  color: RGBA(219, 93, 107, 1.00);
}

#nav-home a:hover {
  color: RGBA(185, 79, 91, 1.00);
}

.main-menu a:hover {
  text-decoration: none;
  color: black;
}

a.footnote-backlink {
  font-size: 0.8em;
  vertical-align: super;
}

a.footnote-forwardlink {
  font-size: 0.8em;
  vertical-align: super;
}

ul.no-bullet {
  list-style-type: none;
  marging-left: 0;
  padding-left: 0;
}

p.post-entry-link, p.post-entry-descr {
  padding-top: 0;
  padding-bottom: 0;
  margin-bottom:0;
}

p.post-entry-descr {
  font-size: 0.9em;
  background-color: #FCF8F3
}

p.post-entry-descr:before {
  content: "";
  margin-left: 2em;
}

em.post-entry-date {
  font-size: 0.8em;
  color: #9C9C9C;
}

blockquote {
  margin-left: 1em;
  padding-left: 1em;
  border-left: 1px solid #ddd;
}

blockquote footer {
  font-style: italic;
}

code {
  font-family: "Consolas", "Menlo", "Monaco", monospace, serif;
}

pre {
  background-color: #FCF8F3;
  overflow: auto;
}

a {
  color: RGBA(219, 93, 107, 1.00);
  text-decoration: none;
}

◊; Show an arrow for links in a new tab
◊; this only applies to desktop users, however
◊; for mobile we might want to show a visual indicator
a.external:hover {
  cursor: alias;
}

a:hover {
  color: RGBA(185, 79, 91, 1.00);
  text-decoration: underline;
}

a img {
  border: none;
}

h1 a,
h2 a,
h3 a,
h4 a,
h5 a,
h6 a {
  color: ◊|font-color|;
  text-decoration: none;
}

h1 a:hover,
h2 a:hover,
h3 a:hover,
h4 a:hover,
h5 a:hover,
h6 a:hover {
  color: #818181;
  text-decoration: none;
}

hr {
  color: #ddd;
  height: 2px;
  margin: 2em 0;
  border-top: dotted 0.3em #ddd;
  border-bottom: none;
  border-left: 0;
  border-right: 0;
}

◊(define (media-between min max)
    (format "(min-device-width: ~apx) and (max-device-width: ~apx)" min max))

◊(define (media-lt max)
    (format "(max-device-width: ~apx)" max))

◊(define tablet (media-between 320 568))
◊(define phone (media-lt 480))

@media only screen and ◊|tablet| {
  html, body {
    line-height: 1.4;
  }
}

@media only screen and ◊|phone| {
  body {
    text-align: left;
  }

  article {
    width: auto;
    padding: 0 10px;
  }
}
