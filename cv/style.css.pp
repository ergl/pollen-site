#lang pollen

◊(define section-space 0.2)
◊(define margin-space 5)

html {
    padding: ◊|margin-space|em;
    margin: auto;
    max-width: 45em;
}

body {
    font: 1.2em Palatino, sans-serif;
    color: #333;
    background-color: #FFFEFC;
}

.section {
    padding-top: ◊|section-space|em;
}

h1, h2 {
    line-height: 1.2;
    font-weight: normal;
}

h6 {
    font-weight: normal;
    font-style: italic;
}

ul {
    list-style-type: none;
    padding-left: 0;
}


a {
    color: RGBA(219, 93, 107, 1.00);
    text-decoration: none;
}

a:hover {
    color: RGBA(185, 79, 91, 1.00);
    text-decoration: underline;
}

#contact-section > ul > li {
    display:inline-table;
    padding-right: 2em;
}

.job h4 {
    margin-bottom:0.5em;
}

.education h4 {
    margin-bottom:0.5em;
}

.job h5, h6 {
    margin-top:0em;
    margin-bottom:0.5em;
}

.education h5, h6 {
    margin-top:0em;
    margin-bottom:0.5em;
}
