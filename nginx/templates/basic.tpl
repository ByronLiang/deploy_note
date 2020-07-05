server {
    listen 80;
    server_name {{domains}};
    root "{{project_dir}}/laravel/public";

    index index.html index.htm index.php;

    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log /var/log/nginx/{{project}}.log;
    error_log /var/log/nginx/{{project}}-error.log error;

    sendfile off;

    client_max_body_size 100m;
    
    # 配置跨域header

    # add_header Strict-Transport-Security "max-age=63072000 includesSubdomain; preload";
    
    add_header Access-Control-Allow-Origin "$http_origin" always;
    add_header Access-Control-Allow-Methods 'HEAD, GET, POST, DELETE, PUT, OPTIONS' always;
    add_header Access-Control-Allow-Headers 'DNT,Authorization,User-Agent,X-XSRF-TOKEN,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range,X-APP-KEY,X-APP-SIGN' always;
    add_header Access-Control-Allow-Credentials 'true' always;
    add_header Access-Control-Max-Age 1728000 always;
    if ($request_method = 'OPTIONS') {
        return 204;
    }

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        fastcgi_param DOCUMENT_ROOT $realpath_root;

        fastcgi_intercept_errors off;
        fastcgi_buffer_size 16k;
        fastcgi_buffers 4 16k;
        fastcgi_connect_timeout 300;
        fastcgi_send_timeout 300;
        fastcgi_read_timeout 300;
    }

    location ~ /\.ht {
        deny all;
    }
}
