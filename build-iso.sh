#!/bin/bash

# Source: https://wiki.archlinux.org/index.php/Archiso

# Update system
pacman -Sy

# Install required packages
pacman -S --noconfirm archiso

cp -r /usr/share/archiso/configs/releng/ archlive

# Enable ssh server on boot
mkdir -p archlive/airootfs/etc/systemd/system/multi-user.target.wants
ln -s /usr/lib/systemd/system/sshd.service archlive/airootfs/etc/systemd/system/multi-user.target.wants/

# shellcheck disable=SC2016
# default password to 'root' - this is unsafe, but as its only used for setup, this is deemed sufficient
sed -i 's/root::/root:$6$eFp54axqHlG7Pmvx$ysVIyKD5Lr99dCzGoDRDi3oKURB\/bRaMvJUCJw451ftR4p6duN2f8wWAkIuUX.gQThWKFN.CyP\/V5b70gIuWK.:/' archlive/airootfs/etc/shadow

# Add additional packages
echo 'htop' >> archlive/packages.x86_64
echo 'lm_sensors' >> archlive/packages.x86_64

mkarchiso -v -w /tmp/archiso-tmp -o /out archlive