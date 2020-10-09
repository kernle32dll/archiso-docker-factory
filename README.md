# Archiso Docker factory

This repo contains a script to create an [Arch Linux](https://www.archlinux.org/)
installation ISO via a temporary Docker container. This allows you to build an
Arch Linux installation media regardless of your host system, while leveraging
the excellent [archiso](https://wiki.archlinux.org/index.php/Archiso) tool.

## Build

Execute `build.sh` to start up a `Docker` based container, which fully automatically
builds a customized `Arch Linux` installation media.

For customization, open the `build-iso.sh` file, which is the script executed
in the Docker container. For details on how to customize, look trough the
[archiso](https://wiki.archlinux.org/index.php/Archiso) wiki page.

You will find the build image in the `out` folder.

## Defaults

This repo assumes a few defaults, the reasons for which are explained in the `About`
section below. 

- the `root` user password is changed to `root`
- a SSH server gets enabled, including password based access for the `root` user
- the `htop` and `lm_sensors` packages are installed

## About

While developing scripts to automate bootstrapping for my personal servers, I realized
that the default Arch Linux comes without a SSH server activated per default. This makes
remote installation impractical, as you need to get on the machine at least once physically,
to start a SSH server, and enable root login (either via password or public key).

So I set out to assemble my own installation media. There is the very mature archiso project,
which unfortunately only runs on Arch Linux itself. A comon saying says: 
`if you have a hammer, everything looks like a nail`. Thus, I wrote myself a small script
to assemble said installation media inside a Docker container, running Arch Linux.