
#     _    _     _          _    ____   ___  _   _ _____   _____ _   ___     __
#    / \  | |   | |        / \  | __ ) / _ \| | | |_   _| | ____| \ | \ \   / /
#   / _ \ | |   | |       / _ \ |  _ \| | | | | | | | |   |  _| |  \| |\ \ / /
#  / ___ \| |___| |___   / ___ \| |_) | |_| | |_| | | |   | |___| |\  | \ V /
# /_/   \_\_____|_____| /_/   \_\____/ \___/ \___/  |_|   |_____|_| \_|  \_/

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
#----------------------------------------------------------------------------------
# otherwise read and uncomment what's missing for your desktop
#export LC_ALL=C
#export LANG=en_ca.utf-8

# Ui toolkit stuff for gtk/qt
#export QT_QPA_PLATFORMTHEME="qt5ct"
#export QT_AUTO_SCREEN_SCALE_FACTOR=0
#export GTK2_RC_FILES="$HOME/gtk2/.gtkrc-2.0"

# X desktop group specification
# https://wiki.archlinux.org/title/XDG_Base_Directory
# 2021 -> new directory proposition from XDG-STANDARD, STATE, based on this

#                          DATA  CONFIG  STATE  CACHE  RUNTIME
# sync across machines?    yes?  yes     no     no     no
# manage in VCS (Git/SVN)? no    yes     no     no     no
# should be backed up?     yes   yes     yes    no     no
# can live in tmpfs?       no    no      no     yes    yes?
# contains much data?      yes   no      no     yes    no

# install`xdg-utils` and run `xdg-user-dirs-update`
# in user's "$HOME" path to generate the file structure
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
# a lot of distributions implement ..._DIRS, for system-wide settings
#export XDG_DATA_DIRS="$XDG_DATA_HOME:/usr/local/share:/usr/share"
#export XDG_CONFIG_DIRS="$XDG_CONFIG_HOME:/etc/xdg:/etc"

# RUNTIME FILES
# under systemd
#export XDG_RUNTIME_DIR="/run/user/$(id -u)"
# on openrc and others generally under /tmp
# make a directory in tmp and flush it with some kind of rule in your process management routine



# Userland helpers
export EDITOR="$nixvim"
export WALLPAPERS="$XDG_DATA_HOME/wallpapers"
export LBIN="$HOME/.local/bin"
export DOT="$HOME/Desktop/dot"

# simple hotkey daemon default shell variable
# export SXHKD_SHELL="sh"

# RUST
. "$HOME/.cargo/env"

# NIX
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . /home/kraven/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
# because nix dont link stdc++.6.so
export LD_LIBRARY_PATH=$(nix eval --raw nixpkgs.stdenv.cc.cc.lib)/lib64:$LD_LIBRARY_PATH

#home-manager
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
# NODEJS
# this is where npm -g intall will reside, in user-space
# because npm in nix is immutable, so you cannot modify the global state
# dont forget `npm set prefix ~/.npm-global`
if [ -d $HOME/.npm-global ]; then PATH="$HOME/.npm-global/bin:$PATH"; fi
export LUA_PATH='/home/kraven/.luarocks/share/lua/5.1/?.lua;/home/kraven/.luarocks/share/lua/5.1/?/init.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;./?.lua;/usr/local/lib/lua/5.1/?.lua;/usr/local/lib/lua/5.1/?/init.lua;/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua'
export LUA_CPATH='/home/kraven/.luarocks/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/?.so;./?.so;/usr/lib/x86_64-linux-gnu/lua/5.1/?.so;/usr/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so'
