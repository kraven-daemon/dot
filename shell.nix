# shell.nix is read by nix-shell

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
