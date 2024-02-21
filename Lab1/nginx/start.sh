#!/bin/bash
/sbin/ip route replace default via 10.0.2.254

# Generate or modify the index.html file
cat <<EOF > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Server Info</title>
</head>
<body>
    <h1>Hostname: $(hostname)</h1>
</body>
</html>
EOF

# Start Nginx in the foreground
nginx -g "daemon off;"