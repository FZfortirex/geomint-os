# GeoMint OS

Remastering Linux Mint 22.3 XFCE (64-bit) menjadi GeoMint OS memakai Cubic di VirtualBox.

## Isi repository

| Berkas | Fungsi |
|---|---|
| customize-chroot.sh | Dijalankan di terminal Cubic (virtual environment): wallpaper, logo, ikon, boot splash |
| customize-host.sh | Dijalankan di terminal biasa: background menu boot BIOS dan UEFI |
| assets/wallpaper.jpg | Wallpaper desktop dan layar login |
| assets/logo.png | Logo GeoMint OS |
| assets/boot.jpg | Background menu boot |
| SHA256SUMS.txt | Checksum ISO hasil remastering |

## Cara pakai

1. Buat proyek di Cubic dengan ISO dasar linuxmint-22.3-xfce-64bit.iso.
2. Di terminal Cubic, copy wallpaper.jpg, logo.png, dan customize-chroot.sh ke /root lewat tombol Copy, lalu jalankan:

        bash customize-chroot.sh

3. Di terminal biasa (bukan Cubic), jalankan:

        sudo bash customize-host.sh /home/zain/GeoMint-project assets/boot.jpg

4. Kembali ke Cubic, klik Next sampai Generate.
5. Buat checksum:

        sha256sum nama-iso.iso > SHA256SUMS.txt

## Berkas sistem yang diubah

| Bagian | Berkas | Alasan |
|---|---|---|
| Wallpaper desktop | /usr/share/xfce4/backdrops/linuxmint.jpg | Dirujuk xfce4-desktop.xml |
| Layar login | /usr/share/backgrounds/linuxmint/default_background.jpg | Dirujuk 99_linuxmint.conf (lightdm) |
| Tombol menu panel | linuxmint-logo-ring-symbolic.svg | Dirujuk whiskermenu-1.rc |
| Ikon menu Start | /usr/share/mint-artwork/logos/ | Ditimpa balik oleh 15-mint-logos.overwrite |
| Animasi boot | /usr/share/plymouth/themes/mint-logo/animation-*.png | Tema Plymouth aktif |
| Menu boot BIOS | isolinux/splash.png | Tampilan isolinux |
| Menu boot UEFI | boot/grub/boot.jpg | Dipakai theme.cfg GRUB |

## Catatan

- Error cryptsetup saat update-initramfs di Cubic normal dan bisa diabaikan.
