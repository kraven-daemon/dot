# Languages
    more at https://nixos.wiki/wiki/Nix_Expression_Language

    repl

    nix

## Variables
    immutable, lazy evaluated
    
    ```
    #comments
    '' multi
       line
       comments
    ''

    # Types
    
    # Integer or Float
    a = 7 or 1.4
    
    # All string no char
    b = "string" or 'stringTo'

    # Path Type :)
    <nixpkgs/...> -> refer to ~/.nix-defexpr/channels/nixpkgs
    x = ./here/be/relativePathtoAFile.txt -> all relative becomes absolute in nix


    ```
## Sets
Nix is a first class Sets kinda language.

    a = {}

## List

    a = [a b 1 2]

## Functions

    func1 = foo: foo + 1;
    func2 = {a, b}: a + b;

## Derivations

The default is no interaction from the outside.

Nix-code -> Nix-derivation -> Nix-store
```
    derivation {
        system = "x86_64-linux";
        name = "foo";
        builder = ./builder.sh;
        outputs = [ "out" ];
    };
```
stdenv.mkDerivation {};
stdenv.runCommand {};
stdenv.writeScriptBin {};

## Reserved Word Statement

with
    This is like a 'using namespace' in c++
    it remove the necessity of typing something.other

    seeing a lot of this in nixos

    environment.systemPackages = with pkgs; [
        git # instead of pkgs.git
        strace
        ltrace
    ];

import

    Is a drop-in text-to-variable from Path variable
    x = import ./someFile.nix;
    y = import ./folder; # will load default.nix
    #*** WARNING   included file need a removed ';' at the end
        because its provided by the parent expression.


inherit

    inbetween sets
    x = x; # is used to reference the value a lot
    inherit x; # does the same thing, like a verbose drag-in

if

If,then,else are determistic, not block-scoped

    something = if x == 7 then "yes" else "no";

let

    myfunc:
    let
        x = 5; # calculate
    in {
        y = x; # goes in the build
    };
