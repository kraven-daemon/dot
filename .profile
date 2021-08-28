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

# Helpers
export EDITOR="$(which nvim)"
export WALLPAPERS="$XDG_DATA_HOME/wallpapers"
export LBIN="$HOME/.local/bin"
export DOT="$HOME/Desktop/dot"

# simple hotkey daemon default shell variable
# export SXHKD_SHELL="sh"
