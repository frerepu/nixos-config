# 📖 **Complete MacBook Pro NixOS Deployment Guide**

## **Phase 1: Pre-Installation Preparation**

### **1.1 Backup Important Data**
```bash
# On your current MacBook Pro (if needed)
# Backup important files to external drive or cloud
```

### **1.2 Create NixOS Installer**
```bash
# Download NixOS ISO (on another machine)
wget https://releases.nixos.org/nixos/25.11/nixos-25.11beta/nixos-minimal-25.11pre-x86_64-linux.iso

# Write to USB stick (replace /dev/sdX with your USB device)
sudo dd if=nixos-minimal-25.11pre-x86_64-linux.iso of=/dev/sdX bs=4M status=progress
```

## **Phase 2: NixOS Installation**

### **2.1 Boot from USB**
1. Insert USB into MacBook Pro
2. Hold `Option` key during boot
3. Select the NixOS installer
4. Choose "NixOS Installer"

### **2.2 Connect to WiFi**
```bash
# Start the wifi manager
sudo systemctl start wpa_supplicant

# Connect to WiFi (interactive)
sudo wpa_cli
> scan
> scan_results
> add_network
> set_network 0 ssid "YourWiFiName"
> set_network 0 psk "YourWiFiPassword"
> enable_network 0
> quit

# Test connection
ping google.com
```

### **2.3 Partition the Disk**
```bash
# List disks
lsblk

# Usually MacBook Pro uses /dev/nvme0n1 or /dev/sda
# I'll use /dev/nvme0n1 - adjust if different

# Start partitioning
sudo parted /dev/nvme0n1

# In parted:
(parted) mklabel gpt
(parted) mkpart ESP fat32 1MiB 512MiB
(parted) set 1 esp on
(parted) mkpart primary 512MiB 100%
(parted) quit

# Format partitions
sudo mkfs.fat -F 32 -n boot /dev/nvme0n1p1
sudo mkfs.ext4 -L nixos /dev/nvme0n1p2

# Mount partitions
sudo mount /dev/nvme0n1p2 /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/nvme0n1p1 /mnt/boot
```

### **2.4 Generate Initial Configuration**
```bash
# Generate hardware config
sudo nixos-generate-config --root /mnt

# Check what was generated
ls /mnt/etc/nixos/
```

## **Phase 3: Replace with Your Dotfiles**

### **3.1 Install Git and Clone Your Repo**
```bash
# Install git temporarily
nix-shell -p git

# Move the generated hardware config (we'll need it)
sudo cp /mnt/etc/nixos/hardware-configuration.nix /tmp/

# Remove the default config
sudo rm -rf /mnt/etc/nixos/*

# Clone your dotfiles
sudo git clone https://github.com/yourusername/dotfiles.git /mnt/etc/nixos

# If you don't have it on GitHub yet, we'll set that up later
# For now, we'll copy from your current machine
```

### **3.2 Copy Hardware Configuration**
```bash
# Copy the generated hardware config to the right place
sudo cp /tmp/hardware-configuration.nix /mnt/etc/nixos/hosts/mbp15/hardware.nix

# Edit it to make it a proper module
sudo nano /mnt/etc/nixos/hosts/mbp15/hardware.nix
```

Make sure the hardware.nix looks like this:
```nix
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Your generated hardware config will be here
  # boot.initrd.availableKernelModules = [ ... ];
  # etc.
}
```

### **3.3 Verify Host Configuration**

The new modular structure means you don't need to create separate top-level config files! Just ensure your `hosts/mbp15/default.nix` looks like this:

```nix
{ config, pkgs, inputs, ... }: {
  imports = [
    ./hardware.nix
    ../common/desktop.nix  # Shared desktop configuration
  ];

  # Host-specific configuration
  networking.hostName = "mbp15";

  # MacBook Pro specific packages
  environment.systemPackages = with pkgs; [
    tlp
    powertop
    acpi
    brightnessctl
  ];

  # Power management
  services.tlp = {
    enable = true;
    settings = {
      TLP_DEFAULT_MODE = "BAT";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      START_CHARGE_THRESH_BAT0 = 20;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # Laptop-specific input configuration
  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
      clickMethod = "clickfinger";
      accelProfile = "adaptive";
    };
  };
}
```

The `mkHost` helper in `flake.nix` automatically:
- Imports `hosts/common/default.nix` (base system)
- Sets up home-manager
- Applies catppuccin theming
- Wires everything together

## **Phase 4: Set Up Git Configuration**

### **4.1 Configure Git**
```bash
# Still in the installer, configure git
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Set up SSH keys (optional, for easier pushing later)
ssh-keygen -t ed25519 -C "your.email@example.com"
# Add the public key to GitHub later
```

### **4.2 Make Initial Adjustments**
```bash
# Edit the mbp15 configuration for any immediate needs
sudo nano /mnt/etc/nixos/hosts/mbp15/default.nix

# Make sure the hostname is correct and network interface matches
# You might need to check: ip link show
```

## **Phase 5: Install NixOS**

### **5.1 Install the System**
```bash
# Install NixOS with your configuration
# The mkHost helper means you just use the host name directly
sudo nixos-install --flake /mnt/etc/nixos#mbp15

# This will take a while...
# If it fails, check the error and fix the configuration
```

### **5.2 Set Root Password**
```bash
# Set root password when prompted
# (You'll change this later)
```

### **5.3 Create User Password**
```bash
# Set your user password
sudo nixos-enter --root /mnt
passwd faelterman
exit
```

## **Phase 6: First Boot and Setup**

### **6.1 Reboot into NixOS**
```bash
# Reboot
sudo reboot

# Remove USB stick when prompted
# Boot into NixOS
```

### **6.2 Set Up Symlink (Optional but Recommended)**
```bash
# Log in as faelterman
# Create symlink from /etc/nixos to your dotfiles
sudo rm -rf /etc/nixos  # Remove if it exists
sudo ln -sf /home/faelterman/.dotfiles /etc/nixos

# OR if your dotfiles are somewhere else:
cd /home/faelterman
git clone https://github.com/yourusername/dotfiles.git .dotfiles
sudo ln -sf /home/faelterman/.dotfiles /etc/nixos
```

### **6.3 Apply Your Configuration**
```bash
# Now rebuild with your config
sudo nixos-rebuild switch --flake ~/.dotfiles#mbp15

# This will install all your packages and apply your config
```

## **Phase 7: Final Configuration**

### **7.1 Configure Display Resolution**
```bash
# Check your actual display resolution
hyprctl monitors

# Edit your hyprland config if needed
nano ~/.dotfiles/hosts/mbp15/hyprland.nix

# Adjust the monitor line:
# "eDP-1,YOUR_ACTUAL_RESOLUTION@60,0x0,1.5"
```

### **7.2 Set Up Git Repository**
```bash
# If you haven't pushed to GitHub yet:
cd ~/.dotfiles
git remote add origin https://github.com/yourusername/dotfiles.git
git push -u origin main

# Or if you already have it:
git pull origin main
```

### **7.3 Test Everything**
```bash
# Test Hyprland starts correctly
# Log out and back in to trigger SDDM with Hyprland

# Test key bindings work
# Test trackpad gestures
# Test brightness controls
# Test WiFi connectivity
```

## **Phase 8: Understanding the New Architecture**

### **8.1 Three-Layer System**

Your configuration now uses a clean three-layer architecture:

1. **Base System** (`hosts/common/default.nix`)
   - Networking, fonts, base packages
   - Tailscale, SSH, common services
   
2. **Desktop Environment** (`hosts/common/desktop.nix`)
   - Hyprland, SDDM, audio (PipeWire)
   - XDG portals, environment variables
   - Shared across all graphical hosts

3. **Host-Specific** (`hosts/mbp15/default.nix`)
   - Hardware configuration
   - Power management (TLP)
   - Laptop-specific features

### **8.2 The mkHost Helper**

The `flake.nix` uses a helper function to eliminate duplication:

```nix
mkHost = { hostname, hostConfig, homeConfig }:
  nixpkgs-unstable.lib.nixosSystem {
    # Automatically wires everything together
  };
```

This means:
- No need for separate `mbp15-configuration.nix` files
- No duplicate home-manager setup
- Just call `mkHost` with your paths

### **8.3 Making Changes**

To customize your system:

- **System-wide changes**: Edit `hosts/common/default.nix`
- **Desktop changes**: Edit `hosts/common/desktop.nix`
- **Laptop-specific**: Edit `hosts/mbp15/default.nix`
- **Hyprland overrides**: Edit `hosts/mbp15/hyprland.nix`

## **Phase 9: Troubleshooting Common Issues**

### **9.1 If WiFi Doesn't Work**
```bash
# Check network interfaces
ip link show

# NetworkManager is enabled in common config
# Just connect via GUI or nmtui
nmtui
```

### **9.2 If Display Issues**
```bash
# Check available resolutions
hyprctl monitors

# Update hyprland config accordingly
nano ~/.dotfiles/hosts/mbp15/hyprland.nix
```

### **9.3 If Build Fails**
```bash
# Check the error and fix syntax
sudo nixos-rebuild switch --flake ~/.dotfiles#mbp15 --show-trace

# Common issues:
# - Missing comma in nix files
# - Wrong file paths
# - Hardware-specific driver issues
```

### **9.4 Broadcom WiFi Driver Issues**

If you see errors about `broadcom-sta` being insecure, this is a hardware-specific issue. You can:

1. Use an external USB WiFi adapter
2. Allow the insecure package (not recommended)
3. Use a different WiFi driver if available

## **Quick Summary Commands:**
```bash
# After fresh install, the key commands are:
sudo ln -sf /home/faelterman/.dotfiles /etc/nixos
sudo nixos-rebuild switch --flake ~/.dotfiles#mbp15

# The mkHost helper handles all the complexity!
```

---

## **Key Improvements in This Setup**

1. **No duplicate configuration files** - Everything is modular
2. **mkHost helper** - Zero boilerplate for new hosts
3. **Three-layer architecture** - Clear separation of concerns
4. **DRY principle** - ~200 lines of duplication eliminated
5. **Easy maintenance** - Change once, apply everywhere

The most important insight: Your configuration now follows the "hosts/common + host-specific" pattern, with the `mkHost` helper automating all the wiring!
