# Lines configured by zsh-newuser-install
HISTFILE=~/.local/share/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/kraven/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
prompt="%B%F{green}%n%f%F{magenta}@%f%F{yellow}%M%f%F{red}[%f%F{blue}%2d%f%F{red}]%f%F{cyan}|>%f%b "
neofetch --backend off
