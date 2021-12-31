# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -e /home/kraven/.nix-profile/etc/profile.d/nix.sh ]; then . /home/kraven/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer



# export WALLPATH="/usr/share/backgrounds:${XDG_DATA_HOME}/"
. "$HOME/.cargo/env"


H=${HOME}

# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# analog: /etc
export XDG_CONFIG_HOME="${H}/.config"
# analog: /var/cache (WARNING!! login out => flush)
export XDG_CACHE_HOME="${H}/.cache"
# analog: /usr/share
export XDG_DATA_HOME="${H}/.local/share"
# analog: /var/lib user-specific state files
export XDG_STATE_HOME="${H}/.local/state"

#  pam_systemd sets this to /run/user/$UID.
# XDG_RUNTIME_DIR
#  Used for non-essential, user-specific data files such as sockets, named pipes, etc.
#  Not required to have a default value; warnings should be issued if not set or equivalents provided.
#  Must be owned by the user with an access mode of 0700.
#  Filesystem fully featured by standards of OS.
#  Must be on the local filesystem.
#  May be subject to periodic cleanup.
#  Modified every 6 hours or set sticky bit if persistence is desired.
#  Can only exist for the duration of the user's login.
#  Should not store large files as it may be mounted as a tmpfs.

# System directories
# analog: PATH
export XDG_DATA_DIRS="${XDG_DATA_DIRS}:/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS}:/etc/xdg"

# Misc
export TERMINAL="alacritty"
export EDITOR="nvim"



