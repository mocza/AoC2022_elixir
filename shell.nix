{ pkgs ? import <nixpkgs> {} }:
  
with pkgs;

let
  inherit (lib) optional optionals;

  erlang = beam.interpreters.erlang;
  elixir = beam.packages.erlang.elixir;
in

mkShell {
  buildInputs = [git erlang elixir vscode] 
    ++ optional stdenv.isLinux inotify-tools;

    shellHook = ''
      alias mdg="mix deps.get"
      alias mps="mix phx.server"
      alias test="mix test"
      alias c="iex -S mix"
    '';
}
