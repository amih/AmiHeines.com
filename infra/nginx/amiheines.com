# amiheines.com — Static Astro site
# Serves pre-built static files from /opt/amiheines.com/dist/

server {
    server_name amiheines.com www.amiheines.com;

    root /opt/amiheines.com/dist;
    index index.html;

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;

    # Static assets — long cache
    location /_astro/ {
        expires 365d;
        add_header Cache-Control "public, immutable";
    }

    # Favicon, robots, sitemap
    location ~* \.(ico|svg|xml|txt)$ {
        expires 7d;
        add_header Cache-Control "public";
    }

    # HTML pages — no cache (for quick deploys)
    location / {
        try_files $uri $uri/index.html $uri.html =404;
        expires -1;
        add_header Cache-Control "no-cache";
    }

    # Custom 404
    error_page 404 /404.html;

    listen 80;
    listen [::]:80;
}
