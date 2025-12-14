#  ██████╗ ██╗████████╗
# ██╔════╝ ██║╚══██╔══╝
# ██║  ███╗██║   ██║
# ██║   ██║██║   ██║
# ╚██████╔╝██║   ██║
#  ╚═════╝ ╚═╝   ╚═╝
{ ... }:
let
  personal = import ../personal.nix;
in
{
  programs.git = {
    enable = true;
    settings = {
      user.name = personal.git.userName;
      user.email = personal.git.userEmail;
      init.defaultBranch = "main";
    };
  };
}