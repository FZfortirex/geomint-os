#!/bin/bash
set -e
PROYEK="${1:?Isi folder proyek Cubic}"
SUMBER="${2:?Isi path gambar sumber}"
DISK="$PROYEK/custom-disk"

mkdir -p "$PROYEK/bak-boot"
cp "$DISK/isolinux/splash.png" "$PROYEK/bak-boot/splash.png" 2>/dev/null || true
cp "$DISK/boot/grub/boot.jpg" "$PROYEK/bak-boot/grub_boot.jpg" 2>/dev/null || true

python3 - "$SUMBER" "$DISK" <<'PY'
import sys
from PIL import Image
src, disk = sys.argv[1], sys.argv[2]
im = Image.open(src).convert('RGB')
im.resize((640, 480), Image.LANCZOS).save(f'{disk}/isolinux/splash.png')
im.resize((1024, 768), Image.LANCZOS).save(f'{disk}/boot/grub/boot.jpg')
im.resize((800, 600), Image.LANCZOS).save(f'{disk}/isolinux/splash800x600.png')
PY

echo "Selesai."
