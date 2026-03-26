{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.hcvst = {
    isNormalUser = true;
    description = "Hans Christian v. Stockhausen";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
    # openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../home/hcvst/ssh.pub);
    hashedPasswordFile = config.sops.secrets."hashedPassword".path;
  };

  programs.zsh.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.hcvst = import ../../../home/hcvst/${config.networking.hostName}.nix;
}
