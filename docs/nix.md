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
        It`s also a bit more, as nix is not only a pkg manager
        repl,etc...
    nix-build
        used to build nix expressions into generations (something.nix)
    nix-collect-garbage
        after uninstalling, it remove aliases from user,
        collecting garbage deletes all packages that aren’t in use by any user profile
    nix-copy-closure
    nix-daemon
        see multiuser environment, running in /etc/...
    nix-hash
    nix-instantiate
        used to evaluate nix code
        e.g.
        > nix-instantiate --eval --strict file.nix
        result
    nix-prefetch-url
    nix-store
        the path holding the generations, default is /nix/store
        all builds from where they are aliased

# Updating nix
Single-user installations of Nix should run this:
    `nix-channel --update;`
    `nix-env -iA nixpkgs.nix`
Apparently this also works:
    `nix upgrade-nix`

# Package Management
## About channels

Listing current channels
    nix-channel --list
Adding a channel
    nix-channel --add https://nixos.org/channels/channel-name channel-alias
Remove a channel
    nix-channel --remove channel-alias
Updating a channel
    nix-channel --update channel-alias
Updating all channels
    nix-channel --update

# Second, basic operation
## nix-env or nix

nix is a wrapper used to simplify using nix-toolofsomesort
    e.g. nix search // vs // nix-env -iA nixpkg.git

## Queries

nix-env -q // q:query installed packages
        -qa some-package // qa: query from available(from channels)
        -qaf /path/to/nixExpression  // qaf: querie
           The default is ~/.nix-defexpr. and point to the channels
           If the argument starts with http:// or https://,
           it is interpreted as the URL of a tarball that will be downloaded and unpacked to a temporary location.
           The tarball must include a single top-level directory containing at least a file named default.nix.
        -qs // query status of pkgs
            // where status is --S/-PS/IPS I:installed, P:present on the system, S:substitute exists
            //--? substitute is a prebuild binary, because in nix the default behavior is
            //    to install a prebuild or build from NixExpression(respectively
            //    each official channel have 2 urls, cache.nix.... for prebuild and a list of buildfiles)
        -q --description +| --json
            query info

## Upgrade and rollback
rollback is upgrade breaks
    nix-env --upgrade some-packages
    nix-env -u some-package // -u noargs upgrade all
    nix-env --rollback some-package

## Install
    nix-env --install some-packages
    nix-env -i some packages

## Uninstall
    nix-env --uninstall some-package
    nix-env -e some-package // e:erase the user's alias to the store

## Remove
This remove packages that are in store but not used by any user's profile
    nix-collect-garbage

## Preview
nix will output what operation is about to happen without running it
    nix-env -u --dry-run

# About profile
## Generation
Operations that modify the profile are creating generations
They physically live in
    ls -l /nix/var/nix/profiles/
which point to the /nix/store/ka...2cqib-user-environment
                   /nix/store/a3...98sd3-user-environment
                            etc....
Get the generations list
    nix-env --list-generations
Switch to a specific generation
    nix-env --switch-generation 41
Undo a nix-env operation
    nix-env --rollback

## User's env
Generations of profiles are coming from
    ~/.nix-profile/bin (in your PATH)
because the initialisation script (/nix/etc/profile.d/nix.sh)
sets a link to the /nix/var/nix/profiles/some-profile/bin

From there you can switch profile with a simple command
It will just change the link from your $HOME/.nix-profile to the other one
    nix-env --switch-profile /nix/var/nix/profiles/other-profile
To run some command on a profile without modifying the user's symlink
    nix-env -p /nix/var/nix/profiles/other-profile -i hello
    or nix-env --profile

## Garbage

Rolling back, switching between generations and between profiles come with a price.

All versions get excluded from the garbage collector sight if they are active,
meaning they are in a generation and or profile on the system
    nix-env --delete-generations old // remove all but current
    nix-store --gc    // flush unused from the store
    nix-store --gc --print-dead | --print-live // print what are going to be deleted/ignored

Utility to remove all unused pkgs from the /nix/var/nix/profiles
-d also delete all but current generation as well
    nix-collect-garbage -d // -d for --delete-old

## Serving your nix-store
### Serve over http
You can install a nix-server
    nix-env -i nix-serve
Start it
    nix-serve -p 8080
Check if it works
    curl http://avalon:8080/nix-cache-info
On the client side, you can tell Nix to use your binary cache using --option extra-binary-caches
    nix-env -i firefox --option extra-binary-caches http://avalon:8080/
Nix will first check if the path is available on the server avalon,
then the default binary cache(https://cache.nixos.org)
If not, it will fall back to building from source.

### Over ssh, copy or serve
The command nix-copy-closure copies a Nix store path along with all its dependencies to
or from another machine via the SSH protocol.
It doesn’t copy store paths that are already present on the target machine.

This gets a bit verbose, refer to
Nix manual(v. 2.3.15) section 13.2, 13.3
-More on `man nix-copy-closure`

# NIX EXPRESSION/PKGS

To build a pkgs, you need a 'nix-expression'
Sets are the core of the langage
And the backend is functionnal, using a subset of haskell

## Derivation

1- Write a nix-expression, a file, a function => default.nix
2- Write a builder, a shellscript => to build the file from input
3- Add the pkg to the file pkgs/top-level/all-packages.nix
    Actually 1&2 combine
    In this step you put it all together, i.e.,
    you call the function with the right arguments to build the actual package.


The builders for almost all Unix packages look like this —>
set up some environment variables, unpack the sources, configure, build, and install

nix repl : test, .drv, :b build it, no link

nix-build
    1- nix-instantiate : parse and evaluate simple.nix and return the .drv file corresponding to the parsed derivation set
    2- nix-store -r : realise the .drv file, which actually builds it.
    3- Finally, it creates the symlink.








