args@{ ... }:
with builtins;
let
  kali = import ./default.nix args;
  pkgs = (import (import ./nix/sources.nix).nixpkgs) { };
in
with builtins;
let
  statsExpr =
    mapAttrs
      (_: mapAttrs (_: pkg: if isString pkg then pkg else pkg.meta.name))
      kali.kaliGroups;
  json = toJSON statsExpr;
  rubyScript = pkgs.writeScript "are-we-hackers-yet-stats-builder" ''
    #!${pkgs.ruby}/bin/ruby
    require 'json'
    require 'erb'
    include ERB::Util

    descs = JSON.parse(File.read("${./kali-descriptions.json}"))
    groups = JSON.parse(File.read("${pkgs.writeText "are-we-hackers-yet-stats-json" json}"))

    template = ERB.new(File.read("${./stats.html.erb}"))

    puts template.result_with_hash(:groups => groups, :descs => descs)
  '';
in
pkgs.runCommand "are-we-hackers-yet-stats" { } ''${rubyScript} > $out''
