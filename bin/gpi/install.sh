# image
wget https://github.com/RetroPie/RetroPie-Setup/releases/download/4.5.1/retropie-4.5.1-rpi1_zero.img.gz
gunzip retropie-4.5.1-rpi1_zero.img.gz
sudo dd bs=4M if=retropie-4.5.1-rpi1_zero.img of=/dev/mmcblk0 conv=fsync

# audio, screen, wifi and controller
sudo mount /dev/mmcblk0p1 /mnt
sudo cp patch/config.txt /mnt
sudo cp patch/overlays/* /mnt/overlays/
sudo cp wpa_supplicant.conf /mnt
sudo mount /dev/mmcblk0p2 /mnt2
sudo cp gba-retroarch.cfg /mnt2/opt/retropie/configs/gba/retroarch.cfg

# auto shutdown
sudo apt-get install -y python3-gpiozero
sudo mkdir /opt/RetroFlag
cp SafeShutdown_gpi.py /opt/RetroFlag
sed -i -e "s/^exit 0/sudo python3 \/opt\/RetroFlag\/SafeShutdown_gpi.py \&\n&/g" /etc/rc.local
