# ██╗   ██╗███████╗ ██████╗ ██████╗ ██████╗ ███████╗
# ██║   ██║██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝
# ██║   ██║███████╗██║     ██║   ██║██║  ██║█████╗
# ╚██╗ ██╔╝╚════██║██║     ██║   ██║██║  ██║██╔══╝
#  ╚████╔╝ ███████║╚██████╗╚██████╔╝██████╔╝███████╗
#   ╚═══╝  ╚══════╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
#
# Visual Studio Code configuration
# Includes extensions and settings

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        redhat.vscode-yaml
        bbenoist.nix
        esbenp.prettier-vscode
        ms-python.python
        github.copilot
        tailscale.vscode-tailscale
        catppuccin.catppuccin-vsc
        ms-azuretools.vscode-docker
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-containers
        ms-vscode.remote-explorer
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "claude-code";
          publisher = "anthropic";
          version = "2.0.65";
          sha256 = "nHZCEEWEgBdxAzpLFkQsTwNPx3JxuwhgwxKgW8LJ450=";
        }
        {
          name = "remote-ssh-edit";
          publisher = "ms-vscode-remote";
          version = "0.47.2";
          sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
        }
      ];
    })
  ];
}