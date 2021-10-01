# redo last command, as root
!!
sudo !!

# create a ramdisk for tmp IO
mkdir -p /mnt/ram
mount -t tmpfs tmpfs /mnt/ram -o size=8192M

# dont record cmd in history(add a space before cmd)
 echo not in history

# Shell(modern) builtin, bash|zsh|mksh
## transfer last cmd as a string buffer into $EDITOR
fc

# Cloud, tunnel with ssh : local port 3337 -> remote host 127.0.0.1 on port 6379
## VERY usefull for accessing private ressources on a cloud server with exposing the port publicly
ssh -L 3337:127.0.0.1:6379 hellomeon@somemachine.xyz -N

# disown -a
