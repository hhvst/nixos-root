{pkgs,...}:
{
  users.mutableUsers = false;
  
  environment.systemPackages = with pkgs; [
    bat
    gh
    helix
    nixfmt
    tree
  ];
}

