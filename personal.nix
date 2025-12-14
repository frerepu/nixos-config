# Personal information - centralized configuration
# Customize this file for your personal setup
{
  user = {
    name = "faelterman";
    fullName = "Your Full Name";  # Update with your real name
    email = "your.email@example.com";  # Update with your email
    homeDirectory = "/home/faelterman";
  };

  # Host-specific settings (override in host configs if needed)
  system = {
    isLaptop = false;  # Set to true for laptop hosts
  };

  git = {
    userName = "frerepu";
    userEmail = "frederic@republiekbrugge.be";
    signingKey = null;  # Set to your GPG key if using commit signing
  };

  bitwarden = {
    email = "frederic.aelterman@gmail.com";
    baseUrl = "https://bitwarden.faelterman.be";
  };

  ssh = {
    # SSH public keys for authorized access
    desktopKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLSC7B0/1ZFrdVTZa+yhquy674nw+JTw0oT5/+/oKGo faelterman@nixos";
  };

  paths = {
    dotfiles = "/home/faelterman/.dotfiles";
    secrets = "/home/faelterman/secrets";
    wallpaper = "/home/faelterman/.dotfiles/wallpapers/wp.jpg";
    spotifydCache = "/home/faelterman/.cache/spotifyd";
  };

  # Shell aliases shared across bash and zsh
  shellAliases = {
    ll = "ls -l";
    ".." = "cd ..";
    c = "clear";
    ls = "ls -lah --color=auto";
    cat = "bat";
    figletas = "figlet -f ~/.local/share/figlet/fonts/ansi_shadow.flf";
  };
}
