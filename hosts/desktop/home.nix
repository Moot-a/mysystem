{ config, pkgs, ... }:

{
  home.stateVersion = "24.11";

  # keep whatever is already there, and add:
  programs.zsh = {
    enable = true;
    initContent = ''
      alias ns="sudo nixos-rebuild switch --flake ~/mysystem#moota-desktop"
    '';
  };
}
