#!/bin/bash
set -e
cd /root

mkdir -p /root/bak/symbolic
cp -r /usr/share/mint-artwork/logos /root/bak/logos
cp -r /usr/share/plymouth/themes/mint-logo /root/bak/mint-logo
cp /usr/share/icons/hicolor/scalable/apps/linuxmint-logo*.svg /root/bak/ 2>/dev/null || true

cp --remove-destination wallpaper.jpg /usr/share/xfce4/backdrops/linuxmint.jpg
cp --remove-destination wallpaper.jpg /usr/share/backgrounds/linuxmint/default_background.jpg
cp --remove-destination wallpaper.jpg /usr/share/backgrounds/linuxmint/linuxmint.jpg
chmod 644 /usr/share/xfce4/backdrops/linuxmint.jpg /usr/share/backgrounds/linuxmint/default_background.jpg /usr/share/backgrounds/linuxmint/linuxmint.jpg

python3 - <<'PY'
from PIL import Image
im = Image.open('/root/logo.png').convert('RGBA')
n = max(im.size)
c = Image.new('RGBA', (n, n), (0, 0, 0, 0))
c.paste(im, ((n - im.size[0]) // 2, (n - im.size[1]) // 2))
c.save('/root/logo_sq_full.png')
c.resize((256, 256), Image.LANCZOS).save('/root/logo_sq.png')
PY
printf '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="256" height="256" viewBox="0 0 256 256"><image width="256" height="256" xlink:href="data:image/png;base64,%s"/></svg>' "$(base64 -w0 /root/logo_sq.png)" > /root/logo.svg

for f in /usr/share/icons/hicolor/scalable/apps/linuxmint-logo*.svg; do
  cp /root/logo.svg "$f"
  chmod 644 "$f"
done

python3 - <<'PY'
from PIL import Image
im = Image.open('/root/logo_sq_full.png')
for s in (16, 22, 24, 32, 48):
    im.resize((s, s), Image.LANCZOS).save(f'/usr/share/mint-artwork/logos/{s}.png')
PY
cp /root/logo.svg /usr/share/mint-artwork/logos/scalable.svg
gtk-update-icon-cache -f /usr/share/icons/hicolor

python3 - <<'PY'
from PIL import Image
import glob
im = Image.open('/root/logo_sq_full.png').resize((100, 100), Image.LANCZOS)
for f in glob.glob('/usr/share/plymouth/themes/mint-logo/animation-*.png'):
    im.save(f)
PY

update-initramfs -u
echo "Selesai."
