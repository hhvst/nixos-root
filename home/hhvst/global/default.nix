{ config, ... }:
{
  
  imports = [
    ../../common/optional/starship.nix
  ];

  home.username = "hhvst";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "23.11";

  programs.zsh.enable = true;
}
