# amiheines.com

Personal website and consulting hub. Astro 5 + Tailwind v4 + MDX.

## Scripts

### YouTube Banner

```bash
./youtube-banner-creator.sh                    # outputs youtube-banner.png
./youtube-banner-creator.sh custom-name.png    # custom filename
```

2048x1152px, dark gradient, white text. Upload to YouTube → Customization → Branding → Banner image.

### LinkedIn Banner

```bash
./linkedin-banner-creator.sh                   # outputs linkedin-banner.png
./linkedin-banner-creator.sh custom-name.png   # custom filename
```

1584x396px, same style as YouTube banner.

### YouTube Thumbnails

```bash
./youtube-thumbnail-creator.sh "Line 1" "Line 2" "Subtitle" [output.png]
```

1280x720px. Line 1 = white, Line 2 = blue accent, Subtitle = gray at bottom-left.

Examples:

```bash
./youtube-thumbnail-creator.sh "Enterprise Monitoring" "for \$0" "Grafana + Prometheus on One Server"
./youtube-thumbnail-creator.sh "Stripe + Blockchain" "Payments On-Chain" "ChainVault Deep Dive" video2.png
./youtube-thumbnail-creator.sh "Smart Contracts" "from Scratch" "Parking Tickets on Antelope" video5.png
```

All scripts require ImageMagick and the Lato font (`/usr/share/fonts/truetype/lato/`).

## Deploy

```bash
npm run build && rsync -avz --delete dist/ ami@158.69.27.200:/var/www/amiheines.com/
```
