#!/bin/sh

# Converts your CentOS 6.2 to Scientific Linux 6.2 (x86_64 only)
DISTRO_ARCH=x86_64 # i386 or x86_64

# Install Yum Repo
rpm -ivh http://ftp.scientificlinux.org/linux/scientific/6x/${DISTRO_ARCH}/os/Packages/yum-conf-sl6x-1-1.noarch.rpm

# Install GPG keys for 64-bit Scientific Linux
rpm -ivh --force http://ftp.scientificlinux.org/linux/scientific/6x/${DISTRO_ARCH}/os/Packages/sl-release-6.2-1.1.${DISTRO_ARCH}.rpm

# clean up centos crud, start pulling from SL
yum erase centos-release
yum clean all
yum disto-sync

# Reinstall all CentOS packages with the SL equivalent
yum reinstall `rpm -qa --qf "%{NAME} %{VENDOR}\n"|grep CentOS|awk '{print $1}'`
