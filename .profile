# lang
export LC_ALL=C
export LANG=en_ca.utf-8

# X desktop group specification
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="$XDG_DATA_HOME:/usr/local/share:/usr/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIRS="$XDG_CONFIG_HOME:/etc/xdg:/etc"
# uncomment if not define under systemd 
# export XDG_RUNTIME_DIR="/run/user/$(id -u)"
# on openrc and others generally under /tmp

# non essential data
export XDG_CACHE_HOME="$HOME/.cache"

# Ui toolkit stuff
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# utils

export EDITOR="/usr/bin/nvim"
export WALLPAPERS="$XDG_DATA_HOME/wallpapers"

# simple hotkey daemon default shell 
export SXHKD_SHELL="sh"

# dev
WHEREIS_DENO="$HOME/.deno/bin"
WHEREIS_NODE="$HOME/.node/bin"
. "$HOME/.cargo/env"
PATH="$PATH:$HOME/.local/scripts:$WHEREIS_DENO:$WHEREIS_NODE"
