# This is me learning nix
# Warning, too many comments are going to follow

# shell.nix is read by nix-shell
# this is to avoid running `nix-shell -p <program>` each time

# now just run nix-shell to initialize the dev environnement
{ pkgs ? import <nixpkgs> {} # imports the set of functions from "nixpkgs"
}:
pkgs.mkShell {           # apparently this is an helper function runned each time you step in your shell env 
        name="node-dev";  # that as a name
        buildInputs = [           # with a list of deps to run the env
            pkgs.nodejs
        ];

        shellHooks = ''             # running in the shell at ready
            echo "start developping"
        '';
}
