FROM archlinux:latest AS build-stage-stage
# Source: https://wiki.archlinux.org/index.php/Archiso

# Update system
RUN pacman -Sy

# Install required packages
RUN pacman -S --noconfirm archiso

RUN cp -r /usr/share/archiso/configs/releng/ archlive

# Enable ssh server on boot
RUN mkdir -p archlive/airootfs/etc/systemd/system/multi-user.target.wants
RUN ln -s /usr/lib/systemd/system/sshd.service archlive/airootfs/etc/systemd/system/multi-user.target.wants/

# shellcheck disable=SC2016
# default password to 'root' - this is unsafe, but as its only used for setup, this is deemed sufficient
RUN sed -i 's/root::/root:$6$eFp54axqHlG7Pmvx$ysVIyKD5Lr99dCzGoDRDi3oKURB\/bRaMvJUCJw451ftR4p6duN2f8wWAkIuUX.gQThWKFN.CyP\/V5b70gIuWK.:/' archlive/airootfs/etc/shadow

# Add additional packages
RUN echo 'htop' >> archlive/packages.x86_64
RUN echo 'lm_sensors' >> archlive/packages.x86_64

RUN mkarchiso -v -w /tmp/archiso-tmp -o /out archlive

FROM scratch AS export-stage
COPY --from=build-stage /out/* /