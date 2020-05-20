{ allowNur ? true
, allowUnfree ? true
, allowInsecure ? true
, pkgs ? import (import ./nix/sources.nix).nixpkgs {
    overlays = if allowNur then [ (super: _: { nur = import (import ./nix/sources.nix).nur { pkgs = super; }; }) ] else [ ];
    config.allowUnfree = allowUnfree;
    config.permittedInsecurePackages = if allowInsecure then [ "p7zip-16.02" ] else [ ];
  }
}:
with builtins;
rec {
  kaliBase = {
    cifs-utils = pkgs.cifs-utils;
    ftp = pkgs.netkittftp;
    iw = pkgs.iw;
    lvm2 = pkgs.lvm2;
    mlocate = pkgs.mlocate;
    netcat-traditional = pkgs.netcat-openbsd;
    nfs-common = pkgs.nfs-utils;
    openssh-server = pkgs.openssh;
    openvpn = pkgs.openvpn;
    p7zip-full = pkgs.p7zip.override (_: { enableUnfree = true; });
    parted = pkgs.parted;
    rfkill = pkgs.rfkill;
    samba = pkgs.samba;
    snmp = pkgs.net-snmp;
    sudo = pkgs.sudo;
    tcpdump = pkgs.tcpdump;
    testdisk = pkgs.testdisk;
    tftp = pkgs.netkittftp;
    tightvncserver = pkgs.tightvnc;
    tmux = pkgs.tmux;
    unrar = pkgs.unrar;
    vim = pkgs.vim;
    whois = pkgs.whois;
  };

  kaliTools = pkgs.callPackage ./kali-tools.nix { };
  kaliGroups = { base = kaliBase; } // mapAttrs (_: deps: listToAttrs (map (dep: { name = dep; value = kaliTools.${dep}; }) deps)) (fromJSON (readFile ./kali-groups.json));
}
