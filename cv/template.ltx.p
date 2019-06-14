\documentclass[a4paper,12pt]{letter}
\begin{document}
◊(local-require racket/list)
◊(apply string-append (filter string? (flatten doc)))
\end{document}

