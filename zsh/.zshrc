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
# load from file otherwise its ZDOTDIR..
compinit -d "$XDG_CACHE_HOME/.zcompdump"

prompt="%B%F{green}%n%f%F{magenta}@%f%F{yellow}%M%f%F{red}[%f%F{blue}%2d%f%F{red}]%f%F{cyan}|>%f%b "
#neofetch --backend off
#

function br {
    local cmd cmd_file code
    cmd_file=$(mktemp)
    if broot --outcmd "$cmd_file" "$@"; then
        cmd=$(<"$cmd_file")
        rm -f "$cmd_file"
        eval "$cmd"
    else
        code=$?
        rm -f "$cmd_file"
        return "$code"
    fi
}

# cat << FILE
# CHECKLIST
# - GOAL
# - ATTITUDE
# - Enviroment
# - Think
# - Truth
# - R&D : Research and development
# - SECRET > we become what we think about most of the time
# ---------------------------------------------------------
# EARL NIGHTINGALE
# FILE

eval "$(zoxide init zsh)"
