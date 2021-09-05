# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch
unsetopt beep

# prompt
# info at `man zshmisc`
# under title : /SIMPLE PROMPT ESCAPES
PROMPT="%B(%F{green}%n%f%F{magenta}@%f%F{yellow}%m%f)%K{red}%F{black}:%k%K{white}%2d%k%K{red}>%k%f%b "

# TODO: check the zshzle manpage for keybindings
#bindkey -e

# compinstall 
zstyle :compinstall filename "$ZDOTDIR/.zshrc"
autoload -Uz compinit
compinit
# End of lines added by compinstall

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

