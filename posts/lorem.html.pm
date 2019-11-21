#lang pollen
◊(define-meta title "Test post")
◊(define-meta published "1970-01-01")
◊(define-meta description "An example post demonstrating several features of the blog.")
◊(define-meta enable-toc "yes")

◊tsection{My first section}

◊tsubsection{My first subsection}

◊drop-cap{
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nisi est,
    efficitur et pharetra eget, pellentesque ac enim. Phasellus congue dignissim
    augue, vitae malesuada purus tempor et. Morbi dictum euismod eros at iaculis.
    Ut vitae urna eget augue eleifend mollis at eget ipsum. Nullam nec venenatis
    ex, at malesuada odio. In euismod ullamcorper justo, sed eleifend sem aliquet
    sit amet. Phasellus pulvinar, erat eu placerat tincidunt, neque massa tincidunt
    quam, eu efficitur ex massa id risus. Curabitur massa ex, pharetra ac malesuada
    non, tincidunt et lectus. Aliquam erat volutpat. Vestibulum ante ipsum primis
    in faucibus orci luctus et ultrices posuere cubilia Curae; Maecenas nisi
    massa, ultrices a sagittis a, elementum sed mauris. Phasellus aliquam urna
    eget ipsum luctus consequat. Sed sodales leo facilisis, feugiat lectus vel,
    tempor massa. Nunc vel fringilla sem, id suscipit eros. Nam ex ipsum,
    consequat sit amet volutpat id, efficitur et quam.
}

◊tsubsection{My second subsection}

◊blockquote[#:author "Some dude on the internet"]{
    This is a quote, with some content in it. Wow, just look at the content!

    Quotes can span multiple lines, and contain footnotes◊note{:smile:}, ◊l["https://example.org"]{links}
    or ◊em{other things!}.
}

We can even do code, yes, code!

◊codeblock['python]{
    for x in range(3):
      print x
}

◊tsection{Another section}

Vestibulum◊note{You can put as much footnotes.} placerat, elit et sodales vulputate,
arcu mauris fermentum orci, sit amet euismod urna nunc eget est. Ut maximus ante
mattis maximus hendrerit. Suspendisse ac tellus pellentesque, posuere lectus in,
finibus eros. Phasellus tincidunt lectus a sem sagittis, vitae sagittis velit cursus. Suspendisse laoreet laoreet sem, vel tempor risus volutpat at. Nulla tincidunt nunc at magna malesuada euismod. In egestas elit ut molestie mollis. In hac habitasse platea dictumst. Aliquam sollicitudin sem tellus, vel dapibus erat auctor quis. Nullam in pharetra nisi, a cursus augue. Duis ac lectus id tellus commodo pharetra. Suspendisse dignissim suscipit auctor. Praesent a nibh finibus, tempus arcu ac, iaculis dui. Aliquam a nisl id metus molestie hendrerit. Fusce ac consequat lectus.

Nunc◊note{As you want.} a sem tellus. Sed mollis erat sit amet massa consequat iaculis. Proin cursus metus ex, quis ornare tellus congue ac. Sed rhoncus vitae orci quis congue. Pellentesque ornare leo mauris, ut tempor leo blandit sed. Morbi ut blandit massa. Fusce scelerisque ultrices interdum. Mauris quis neque laoreet, porttitor nibh non, egestas enim. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam lacinia nisi metus, ut euismod lectus consequat id. Fusce vestibulum laoreet diam dictum tempor. Morbi a blandit tortor, nec feugiat nisl.

◊tsection{Our final section!}

In elementum◊note{The note number will increase automatically!} efficitur diam id suscipit. Donec facilisis ligula quis eleifend laoreet. Curabitur finibus mauris ut vestibulum tincidunt. Nunc ligula augue, blandit eu arcu posuere, suscipit eleifend erat. Aliquam sit amet rutrum elit. Proin at vestibulum nulla, a elementum arcu. Nullam sit amet eros eu ipsum rutrum iaculis quis sed purus. Suspendisse feugiat, justo ac fermentum sagittis, nibh nunc ultricies nisi, id finibus nibh urna a enim. Praesent in risus placerat, dapibus leo vel, convallis nisi. Curabitur eget est ante. Nullam ante dui, convallis ac purus nec, rutrum dictum magna.

◊tsubsection{My last subsection}

Praesent nec lobortis magna, vel rhoncus diam. Aenean sollicitudin arcu eu molestie posuere. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean egestas dui et pretium accumsan. Maecenas odio dolor, egestas non nisi id, ornare sodales erat. Praesent dictum nisl at enim ornare, eu tristique purus ultricies. Sed venenatis nec orci eu luctus. Praesent venenatis luctus vulputate. In hac habitasse platea dictumst. Morbi vehicula ornare mollis. Maecenas vel elementum eros, et commodo ex. Duis scelerisque sapien in libero interdum tincidunt. Vestibulum pretium nec ante nec viverra. Fusce scelerisque nulla ac enim convallis euismod.
