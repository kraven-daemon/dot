# .profile is sourced after /etc/profile, and /etc/profile.d/*
# depends: nvim bat alacritty

H=${HOME}

ENCODING="en_CA.UTF-8"
export LANG="$ENCODING"
export LC_CTYPE="$ENCODING"
export LC_NUMERIC="$ENCODING"
export LC_TIME="$ENCODING"
export LC_COLLATE="$ENCODING"
export LC_MONETARY="$ENCODING"
export LC_MESSAGES="$ENCODING"
export LC_PAPER="$ENCODING"
export LC_NAME="$ENCODING"
export LC_ADDRESS="$ENCODING"
export LC_TELEPHONE="$ENCODING"
export LC_MEASUREMENT="$ENCODING"
export LC_IDENTIFICATION="$ENCODING"

# BIN?
if [ -d "${H}/.local/bin" ]; then PATH="${H}/.local/bin:$PATH"; fi
# SCRIPTS?
if [ -d "${H}/.local/scripts" ] ; then PATH="${H}/.local/scripts:$PATH"; fi
# NIX?
if [ -e "${H}/.nix-profile/etc/profile.d/nix.sh" ]; then . "${H}/.nix-profile/etc/profile.d/nix.sh"; fi
# RUST?
if [ -d "${H}/.cargo/bin" ]; then PATH="${H}/.cargo/bin:$PATH"; fi

# XDG?
# analog: /etc
export XDG_CONFIG_HOME="${H}/.config"
# analog: /var/cache
export XDG_CACHE_HOME="${H}/.cache"
# analog: /usr/share
export XDG_DATA_HOME="${H}/.local/share"
# analog: /var/lib user-specific state files
export XDG_STATE_HOME="${H}/.local/state"
# System directories
# analog: PATH
export XDG_DATA_DIRS="${XDG_DATA_HOME}:/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="${XDG_CONFIG_HOME}:/etc/xdg"
# XDG_RUNTIME_DIR=???
# pam_systemd sets this to /run/user/$UID, automatically
# initd, openrc, runit, s6, 66, dinit might need manual setting
# Misc

export TERMINAL='alacritty'
export EDITOR='nvim'
export VISUAL='bat -p'
export BROWSER='chromium'
export WALLPATH="${XDG_DATA_HOME}/backgrounds"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export CLICOLOR=1

if [ -e "${H}/.aliases" ]; then
	. "${H}/.aliases"
fi

# other might remove
# Ui toolkit stuff for gtk/qt
#export QT_QPA_PLATFORMTHEME="qt5ct"
#export QT_AUTO_SCREEN_SCALE_FACTOR=0
#export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/.gtkrc-2.0"

# LUA stuff
export PATH="/opt/lua-language-server/bin:$PATH"

