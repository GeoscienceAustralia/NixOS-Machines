# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "rtsx_pci_sdmmc" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/98fc7b04-6cbe-43ee-aaa0-d43c21a8f9f7";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/nvme0n1p6";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/nvme0n1p1";
      fsType = "vfat";
    };

  fileSystems."/dos" =
    { device = "/dev/nvme0n1p3";
      fsType = "ntfs-3g";
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 4;
}
