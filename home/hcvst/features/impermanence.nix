{ inputs, ... }:
{
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
  ];

  home.persistence."/persist/home/hcvst" = {
    allowOther = true;

    directories = [
      "Projects"
      "Documents"
      "Downloads"
      ".ssh"
      ".gnupg"
      ".config/gh"
      ".local/share/keyrings"
      ".local/share/fish" # fish history
    ];

    files = [ ]; # add as you discover needs
  };
}
