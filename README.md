# arch-raspi-docker-image
Dockerbuild script for Arch Linux on Raspberry Pi.

## filesystem

This image's file system is created by [arch-bootstrap.sh](https://raw.githubusercontent.com/yannayl/arch-bootstrap/master/arch-bootstrap.sh).

## how to build

Run build.sh with root privilege on your Raspberry Pi. Because of architecture difference, you cannot build image on x86/x86_64 machine.  
This script will install wget command if your machine doesn't have it because arch-bootstrap.sh requires.

