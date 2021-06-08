# Do not use with systemd
# Unprivileged Write Access directory only
# those can be either ->    /tmp    /var/tmp    /dev/shm    /run/user/$USER
# Create a temp folder for non essential user app date
# export MYDUMP=$(mktemp -d /tmp/depotoir-$USER.XXXXXX )

figlet -c "Welcome Back Bro"


#if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
#  exec sway
#fi
