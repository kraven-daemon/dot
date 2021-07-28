BASICS


# Installing

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
    nix-build           
    nix-collect-garbage  
    nix-copy-closure     
    nix-daemon           
    nix-hash             
    nix-instantiate      
    nix-prefetch-url
    
    nix-store       

# Updating nix
Single-user installations of Nix should run this:
    `nix-channel --update;`
    `nix-env -iA nixpkgs.nix`
Apparently this also works:
    `nix upgrade-nix`

## This is probably the most accurate global summary of what is nix
### I've found this inside the nix manual and could not explain it better.

In Nix, different users can have different “views” on the set of installed applications. That is, there might be lots of applications present on the system (possibly in many different versions), but users can have a specific selection of those active — where “active” just means that it appears in a directory in the user’s PATH. Such a view on the set of installed applications is called a user environment, which is just a directory tree consisting of symlinks to the files of the active applications.
Components are installed from a set of Nix expressions that tell Nix how to build those packages, including, if necessary, their dependencies. There is a collection of Nix expressions called the Nixpkgs package collection that contains packages ranging from basic development stuff such as GCC and Glibc, to end-user applications like Mozilla Firefox. (Nix is however not tied to the Nixpkgs package collection; you could write your own Nix expressions based on Nixpkgs, or completely new ones.)
