# Agenix secrets configuration
# Defines which age keys can decrypt which secrets
let
  # Age public key derived from SSH host key
  desktop = "age18h2pty7jtx6erzku9v46g35cj2q3299uetzllgexc4spscn8myns75q86y";

  # User's SSH public key (for manual secret editing)
  # Convert with: cat ~/.ssh/id_ed25519.pub | ssh-to-age
  user = "age1yubikey1...";  # TODO: Add your user age key if you want to edit secrets manually

  # Admin keys (can decrypt all secrets)
  allKeys = [ desktop ];
in
{
  # Tailscale authentication key
  "tailscale-authkey.age".publicKeys = allKeys;

  # Spotify username
  "spotify-username.age".publicKeys = allKeys;
}
