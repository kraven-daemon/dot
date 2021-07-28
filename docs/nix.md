BASICS

## This is probably the most accurate global summary of what is nix
### I've found this inside the nix manual and could not explain it better.

In Nix, different users can have different “views” on the set of installed applications. 
That is, there might be lots of applications present on the system (possibly in many different versions),
but users can have a specific selection of those active — where “active” just means that it appears in a directory in the user’s PATH. 
Such a view on the set of installed applications is called a user environment,
which is just a directory tree consisting of symlinks to the files of the active applications.
Components are installed from a set of Nix expressions that tell Nix how to build those packages, including, if necessary, their dependencies.
There is a collection of Nix expressions called the Nixpkgs package collection that contains packages ranging from basic development stuff such as GCC and Glibc, 
to end-user applications like Mozilla Firefox. 

(Nix is however not tied to the Nixpkgs package collection; you could write your own Nix expressions based on Nixpkgs, or completely new ones.)


# Installing
The install script will modify the first writable file from amongst 
    .bash_profile, 
    .bash_login or
    .profile 
    -> to 
    source ~/.nix-profile/etc/profile.d/nix.sh
You can set the NIX_INSTALLER_NO_MODIFY_PROFILE environment variable before executing the install script to disable this behaviour.

Single-user/ no root
    sh <(curl -L https://nixos.org/nix/install) --no-daemon
# Uninstall

    rm -rf /nix
    Also remove the sourcing in profile..
    And the user created files
        - .nix-channels
        - .nix-defexpr
        - .nix-profile

# What you get
Nix comes with a set of utilities:
    nix-channel:
        where to get your pkgs
    nix-shell:
        made to run env
        looks for `shell.nix` inside a directory
    nix-env:
        probably the most usefull,
        where the install, update, erase, query,
        of the packages installed on your system is done
    nix
        this is a global wrapper around the more precise functions,
        kind of like: 
            apt is to dpkg for debian distros
            rpm/yum to dnf for redhat distros
            yay,paru, or other `AUR+pacman` pkg tool wrapper for arch-based distro
        It's also a bit more, as nix is not only a pkg manager
        REPL, 
    nix-build
        used to build nix expressions into generations (something.nix)
    nix-collect-garbage
        after uninstalling (-e for erase), only aliases are removed
        collecting garbage deletes all packages that aren’t in use by any user profile
    nix-copy-closure
    nix-daemon
        see multiuser environment, running in /etc/...
    nix-hash             
    nix-instantiate      
    nix-prefetch-url
    nix-store
        the path holding the generations, default is /nix/store
        all builds from where they are aliased

# Just want to use
## zero-manual

# Updating nix
Single-user installations of Nix should run this:
    `nix-channel --update;`
    `nix-env -iA nixpkgs.nix`
Apparently this also works:
    `nix upgrade-nix`

# First things first
## About channels

Listing current channels
    nix-channel --list
Adding a primary channel
    nix-channel --add https://nixos.org/channels/channel-name nixos
Adding other channels
    nix-channel --add https://some.channel/url my-alias
Remove a channel
    nix-channel --remove channel-alias
Updating a channel
    nix-channel --update channel-alias
Updating all channels
    nix-channel --update

# Second
## nix-env or nix


