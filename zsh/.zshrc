# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch
unsetopt beep

# compinstall 
zstyle :compinstall filename "$ZDOTDIR/.zshrc"
autoload -Uz compinit
compinit
# End of lines added by compinstall

# alias
#
# modifier
alias ls="exa"
alias la="exa -a"
alias ll="exa -la"
alias l="exa"
alias l.="exa -a | rg '^\..*'"
alias cl="clear"
alias grep="rg --color=auto"
alias vi="nvim"

# info
alias df="df -h"
alias free="free -mt"
alias wget="wget -c"
alias userlist="cut -d: -f1 /etc/passwd"

# xrelated
alias merge="xrdb -merge ~/.Xresources"
alias printlock="printf '\t\    |    /\n\n\n.^_^-  SCREENLOCKED  -^_^.\n\n\n\t/    |    \'"
alias lock="slock -m '$(printlock)'"

# read screen brightness
alias brightness="cat /sys/class/backlight/acpi_video0/brightness"

alias nlight="redshift -O 4000"
alias dlight="redshift -x"

alias pp="echo $PATH | sed 's/:/\n/g'"

# Git CONFIG reminder
# with this alias
alias config="git --git-dir=$HOME/.dotdotdot --work-tree=$HOME"

#herbstluft helpers
alias hh="herbstclient help"
alias hs="herbstclient set_attr"


ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# exstarship prompt
eval "$(starship init zsh)"

