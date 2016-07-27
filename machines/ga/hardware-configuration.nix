# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

   boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "sd_mod" "sr_mod" ];

   fileSystems."/" =
     { device = "/dev/disk/by-label/nixos";
     };

  nix.maxJobs = lib.mkDefault 4;
  virtualisation.virtualbox.guest.enable = true;
}
