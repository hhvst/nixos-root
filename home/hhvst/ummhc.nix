{ pkgs, ... }:
{
  imports = [
    ./global
  ];

  home.packages = with pkgs; [
    httpie
    blockbench
    firefox
    prismlauncher
    stone-kingdoms
    lenmus
    widelands
    libreoffice-qt
  ];
}
