userresources=$HOME/.config/Xresources/xresources
usermodmap=$HOME/.config/Xmodmap/xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

if [ -f $sysresources ]; then xrdb -merge $sysresources; fi
if [ -f $sysmodmap ]; then xmodmap $sysmodmap; fi
if [ -f "$userresources" ]; then xrdb -merge "$userresources"; fi
if [ -f "$usermodmap" ]; then xmodmap "$usermodmap"; fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# crank up key repeat rate
xset r rate 300 100

# ssh-add `keys` #later
eval "$(ssh-agent)"

# feh --bg-fill "${WALLPATH}/purple-haze.jpg"

# nvidia need extra settings otherwise erroR
# picom --xrender-sync-fence --backend glx --config /dev/null
eval "$(dbus-launch --sh-syntax --exit-with-x11)"
exec awesome
