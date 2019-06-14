<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/style.css">
<title>◊(doc-title metas)</title>
◊(canonicalize metas)
◊(maybe-redirect metas)
◊;◊(maybe-import-highlight)
</head>
<body>
◊(->html site-navigation)
◊(->html (build-document doc metas))
</body>
</html>
