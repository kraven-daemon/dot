[[ $- != *i* ]] && return 2
. "${HOME}/.profile"
. "${HOME}/.aliases"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
