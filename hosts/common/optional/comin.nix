{ inputs, ... }:
{
  imports = [
    inputs.comin.nixosModules.comin
  ];

  services.comin = {
    enable = true;
    remotes = [
      {
        name = "origin";
        url = "https://github.com/hcvst/nixos-root.git";
        branches.main.name = "main";
      }
    ];
  };

}
