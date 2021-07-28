# Because a lot of linux distribution
# already implement it,
# only include user-profile related stuff here

# otherwise read and uncomment what's missing for your desktop
#export LC_ALL=C
#export LANG=en_ca.utf-8

# X desktop group specification
#export XDG_DATA_HOME="$HOME/.local/share"
#export XDG_DATA_DIRS="$XDG_DATA_HOME:/usr/local/share:/usr/share"
#export XDG_CONFIG_HOME="$HOME/.config"
#export XDG_CONFIG_DIRS="$XDG_CONFIG_HOME:/etc/xdg:/etc"

# RUNTIME FILES
# uncomment if not define under systemd 
#export XDG_RUNTIME_DIR="/run/user/$(id -u)"
# on openrc and others generally under /tmp
# make a directory in tmp and flush it with some kind of rule in your process management routine


# Ui toolkit stuff for gtk/qt
#export QT_QPA_PLATFORMTHEME="qt5ct"
#export QT_AUTO_SCREEN_SCALE_FACTOR=0
#export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Minimal base env for X
# make sure to have a xdg-compliant desktop environment
# or install `xdg-utils` and run `xdg-user-dirs-update` in user's "$HOME" path to generate the file structure
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# utils
#export EDITOR="/usr/bin/nvim"
#export WALLPAPERS="$XDG_DATA_HOME/wallpapers"

# simple hotkey daemon default shell variable
# export SXHKD_SHELL="sh"

# TODO:
# More stuff on nix and podman, 
# Separate all aliases in a file,
# Parse the alias and make a popup helper in an "awesomewm-like" fashion tools.
