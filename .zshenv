# (info) zshenv is sourced first
# depends: nvim bat alacritty


export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config/zsh}"
# Always start by updating paths.. just in case

H=${HOME}
# include the bin
if [ -d "${H}/.local/bin" ] ; then
    PATH="${H}/.local/bin:$PATH"
fi

# if nix is installed..
if [ -e "${H}/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "${H}/.nix-profile/etc/profile.d/nix.sh"
fi

# if rustup toolchain source the provided import script
if [ -f "${H}/.cargo/env" ]; then
    . "${H}/.cargo/env"
fi

# if nodejs, for lsp, and other frontend utils
if [ -d "${H}/.npm-global" ]; then
    PATH="${H}/.npm-global/bin:${PATH}"
fi

# Depending on distros, XDG should be set, or overriden
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html

# analog: /etc
export XDG_CONFIG_HOME="${H}/.config"
# analog: /var/cache (WARNING!! login out => flush)
export XDG_CACHE_HOME="${H}/.cache"
# analog: /usr/share
export XDG_DATA_HOME="${H}/.local/share"
# analog: /var/lib user-specific state files
export XDG_STATE_HOME="${H}/.local/state"

#  pam_systemd sets this to /run/user/$UID, automatically
# XDG_RUNTIME_DIR=???
# this might need to be set manually 
# 	on other init system like : initd, openrc, runit, s6, 66, dinit or any other im not aware of :P

# System directories
# analog: PATH
export XDG_DATA_DIRS="${XDG_DATA_HOME}:/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="${XDG_CONFIG_HOME}:/etc/xdg"

# Misc
export TERMINAL="alacritty"
export EDITOR="nvim"
export VISUAL="bat"
export WALLPATH="${XDG_DATA_HOME}/backgrounds:/usr/share/backgrounds"

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
# desktop cli utilities for minimal standard,, some app refer to generic structure
# install`xdg-utils` and run `xdg-user-dirs-update`
