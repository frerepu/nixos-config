# ██╗    ██╗ ██████╗ ███████╗██╗
# ██║    ██║██╔═══██╗██╔════╝██║
# ██║ █╗ ██║██║   ██║█████╗  ██║
# ██║███╗██║██║   ██║██╔══╝  ██║
# ╚███╔███╔╝╚██████╔╝██║     ██║
#  ╚══╝╚══╝  ╚═════╝ ╚═╝     ╚═╝
{
  programs.wofi = {
    enable = true;
    settings = {
      allow_markup = true;
      allow_images = true;
      width = 650;
      height = 450;
    };
  };

  home.file.".config/wofi/style.css".source = ./style.css;
}