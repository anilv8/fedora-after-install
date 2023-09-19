#!/bin/bash

echo "Welcome to Fedora after install script."

echo Changing /etc/dnf/dnf.conf
printf "#Added for speed\nfastestmirror=True\nmax_parallel_downloads=5\n#defaultyes=True\n#keepcache=True\n" | sudo tee -a /etc/dnf/dnf.conf

echo Enabling free RPM Fusion repos.
echo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y

echo Enabling non-free RPM Fusion repos.
dnf install \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

echo Installing multimedia codecs.
dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
dnf install lame\* --exclude=lame-devel -y
dnf group upgrade --with-optional Multimedia -y

echo Installing non-free  nVidia driver.
dnf install akmod-nvidia -y
