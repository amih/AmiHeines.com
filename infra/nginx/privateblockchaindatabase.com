# privateblockchaindatabase.com — 301 redirect to amiheines.com
# All paths redirect, preserving /blog/* paths

server {
    server_name privateblockchaindatabase.com www.privateblockchaindatabase.com;

    # Redirect blog posts to amiheines.com/blog/
    location /blog/ {
        return 301 https://amiheines.com$request_uri;
    }

    # Redirect everything else to homepage
    location / {
        return 301 https://amiheines.com$request_uri;
    }

    listen 80;
    listen [::]:80;
}
