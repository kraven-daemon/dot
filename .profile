# .profile is sourced after /etc/profile, and /etc/profile.d/*
# depends: nvim bat alacritty

H=${HOME}

# BIN?
if [ -d "${H}/.local/bin" ] ; then
    PATH="${H}/.local/bin:$PATH"
fi
# NIX?
if [ -e "${H}/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "${H}/.nix-profile/etc/profile.d/nix.sh"
fi
# RUST?
if [ -d "${H}/.cargo/bin" ]; then
    PATH="${H}/.cargo/bin:$PATH"
fi
# NODEJS?
if [ -d "${H}/.npm-global" ]; then
    PATH="${H}/.npm-global/bin:${PATH}"
fi

# XDG?
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# Also `xdg-utils`
# analog: /etc
export XDG_CONFIG_HOME="${H}/.config"
# analog: /var/cache (WARNING!! login out => flush)
export XDG_CACHE_HOME="${H}/.cache"
# analog: /usr/share
export XDG_DATA_HOME="${H}/.local/share"
# analog: /var/lib user-specific state files
export XDG_STATE_HOME="${H}/.local/state"

# XDG_RUNTIME_DIR=???
# pam_systemd sets this to /run/user/$UID, automatically
# initd, openrc, runit, s6, 66, dinit might need manual setting

# System directories
# analog: PATH
export XDG_DATA_DIRS="${XDG_DATA_HOME}:/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="${XDG_CONFIG_HOME}:/etc/xdg"

# Misc
# export TERMINAL="alacritty"
export TERMINAL="st"
export EDITOR="nvim"
export VISUAL="bat -p"
export BROWSER="firefox-developper-edition"
export WALLPATH="${XDG_DATA_HOME}/backgrounds"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ -e "${H}/.aliases" ]; then
	. ${H}/.aliases
fi


# other might remove
#export LANG=en_ca.utf-8
# Ui toolkit stuff for gtk/qt
#export QT_QPA_PLATFORMTHEME="qt5ct"
#export QT_AUTO_SCREEN_SCALE_FACTOR=0
#export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/.gtkrc-2.0"
# X desktop group specification
# https://wiki.archlinux.org/title/XDG_Base_Directory
# 2021/2022 -> new directory proposition from XDG-STANDARD, STATE, based on this
#                          DATA  CONFIG  STATE  CACHE  RUNTIME
# sync across machines?    yes?  yes     no     no     no
# manage in VCS (Git/SVN)? no    yes     no     no     no
# should be backed up?     yes   yes     yes    no     no
# can live in tmpfs?       no    no      no     yes    yes?
# contains much data?      yes   no      no     yes    no
# 

if [ -e /home/kraven/.nix-profile/etc/profile.d/nix.sh ]; then . /home/kraven/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
