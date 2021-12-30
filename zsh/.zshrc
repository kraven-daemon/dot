# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch
unsetopt beep

# prompt
# info at `man zshmisc`
# under title : /SIMPLE PROMPT ESCAPES
PROMPT="%B%F{green}%n%f%F{yellow}@%f%F{magenta}%m%f%K{}%F{yellow}[%f%F{blue}%2d%f%F{yellow}]%f%F{red}<>%f%b "

# TODO: check the zshzle manpage for keybindings
#bindkey -e

# compinstall 
zstyle :compinstall filename "$ZDOTDIR/.zshrc"
autoload -Uz compinit
compinit
zmodload zsh/complist
setopt menucomplete
zstyle ':completion:*' menu select=0 search
# End of comp

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

extract()
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
      *)           echo "'$1' cannot be extracted" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
