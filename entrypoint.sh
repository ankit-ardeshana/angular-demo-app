#!/bin/sh
echo "server {
    listen    8080;
    server_name     localhost;
    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
        try_files \$uri /index.html;
    }
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}" > "/etc/nginx/conf.d/default.conf"

nginx -g "daemon off;"
