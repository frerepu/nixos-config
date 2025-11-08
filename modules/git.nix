#  ██████╗ ██╗████████╗
# ██╔════╝ ██║╚══██╔══╝
# ██║  ███╗██║   ██║
# ██║   ██║██║   ██║
# ╚██████╔╝██║   ██║
#  ╚═════╝ ╚═╝   ╚═╝
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "frerepu";
      user.email = "frederic@republiekbrugge.be";
      init.defaultBranch = "main";
    };
  };
}