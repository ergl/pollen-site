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
  .dropcap-wrap:first-letter {
    -webkit-initial-letter: ◊|first-letter-size|;
    initial-letter: ◊|first-letter-size|;
    color: ◊|first-letter-color|;
  }

  .dropcap {
    margin-right: 0.15em;
  }
}

@supports ◊|not-supports-initial-letter| {
  .dropcap {
    font-size: ◊|compat-first-letter-size|rem;
    line-height: 1rem;
    color: ◊|first-letter-color|;
  }

  .dropcap:before {
    margin-bottom: -0.175em;
  }

  .dropcap:after {
    margin-top: -0.05em;
  }

  ◊; The wrapper div around the letter needs some spacing
  ◊; on top to prevent clash with the parent element
  .dropcap-wrap {
    padding-top: ◊|compat-first-letter-spacing|rem;
  }
}

◊;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

html {
  font-size: 100%;
}

html, body {
  padding: 0.5em;
  margin: auto;
  max-width: 42em;
}

◊(define font-size 1.2)
◊(define font-color "#333")
◊(define background-color "#FFFEFC")
◊(define code-background-color "#F5F4F2")

body {
  color: ◊|font-color|;
  background: ◊|background-color|;
  font: ◊|font-size|em Palatino, sans-serif;
  line-height: 1.4;
  ◊; TODO(borja): should add smart hyphenation
  text-align: left;
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

.right-aligned {
  text-align: right;
}

a.footnote-backlink {
  margin-left: 0.1em;
  font-size: 0.8em;
}

a.footnote-forwardlink {
  margin-left: 0.1em;
  font-size: 0.8em;
}

ul.no-bullet {
  list-style-type: none;
  margin-left: 0;
  padding-left: 0;
}

p.post-entry-link {
  padding-top: 0;
  padding-bottom: 0;
  margin-bottom:0;
}

p.post-entry-descr {
  font-size: 0.9em;
  margin-bottom: 2em;
}

p.post-entry-date {
  padding-top: 0.7em;
  font-size: 0.9em;
  font-style: italic;
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
  font-size: 0.8em;
  background: ◊|code-background-color|;
}

code:before, code:after {
  content: "`";
}

pre code {
  background: inherit;
}

pre code:before, pre code:after {
  content: "";
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

details > summary {
  cursor: pointer;
}

.toggle-content {
  margin-left: 1em;
  padding-left: 1em;
  border-left: 1px solid #ddd;
}

#table-of-contents {
  margin-left: 1em;
  padding-left: 1rem;
}

.toc-s { margin: 0.5em; }

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
