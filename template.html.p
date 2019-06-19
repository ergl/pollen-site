◊(define page-title (doc-title metas))
◊(define page-description (doc-description metas))

<!DOCTYPE html>
<html lang="en-US">
<head prefix="og: http://ogp.me/ns#">
<meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1">
<meta property="og:title" content="◊|page-title|"/>
<meta property="og:description" content="◊|page-description|"/>
<meta property="og:type" content="website"/>
<title>◊|page-title|</title>
<link rel="stylesheet" href="/style.css">
◊(canonicalize metas)
◊(maybe-redirect metas)
◊;◊(maybe-import-highlight)
</head>
<body>
◊(->html site-navigation)
◊(->html (build-document doc metas))
</body>
</html>
