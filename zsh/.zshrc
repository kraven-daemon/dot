# zshrc is read on each interactive invocation
# only put interactive related settings here

# global zsh config
HISTFILE="${ZDOTDIR}/.histfile"
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
unsetopt beep
# Warning: vim's keybinding for navigation have weird behavior on some terminal emulator
# set it back to -e for emacs, if its too weird(double escape, unresponsive insert.. etc..)
bindkey -v

# prompt at `man zshmisc`
PROMPT="%B%F{green}%n%f%F{yellow}@%f%F{magenta}%m%f%F{yellow}[%f%F{blue}%2d%f%F{yellow}]%f%F{red}➜ %f%b"

# base16 shell color theme for the shell
# BASE16_SHELL="$HOME/.config/base16-shell/"
# [ -n "$PS1" ] && \
#     [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#         eval "$("$BASE16_SHELL/profile_helper.sh")"

# completion engine of zsh
zstyle ':completion:*' add-space true
zstyle ':completion:*' auto-description 'Specify: %d'
zstyle ':completion:*' completer _list _oldlist _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' format 'COMP : %d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '+' '+' '+' '+'
zstyle ':completion:*' max-errors 3 not-numeric
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' prompt 'Errors => %e'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
zstyle ':completion:*' word true
zstyle :compinstall filename "${ZDOTDIR}/.zshrc"
autoload -Uz compinit
compinit


# source aliases
test -e "${ZDOTDIR}/.aliases" && . "${ZDOTDIR}/.aliases"
