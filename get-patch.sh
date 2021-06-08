#!/usr/bin/env sh

baseurl="https://tools.suckless.org/dmenu/patches"
rm *.diff
wget "$baseurl/border/dmenu-border-4.9.diff"
wget "$baseurl/xresources/dmenu-xresources-4.9.diff"
wget "$baseurl/center/dmenu-center-20200111-8cd37e1.diff"
