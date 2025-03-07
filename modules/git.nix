#  ██████╗ ██╗████████╗
# ██╔════╝ ██║╚══██╔══╝
# ██║  ███╗██║   ██║   
# ██║   ██║██║   ██║   
# ╚██████╔╝██║   ██║   
#  ╚═════╝ ╚═╝   ╚═╝
{  
  programs.git ={
    enable = true;
    userName = "frerepu";
    userEmail = "frederic@republiekbrugge.be";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}