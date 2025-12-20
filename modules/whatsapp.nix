#  ██     ██ ██   ██  █████  ████████ ███████  █████  ██████  ██████
#  ██     ██ ██   ██ ██   ██    ██    ██      ██   ██ ██   ██ ██   ██
#  ██  █  ██ ███████ ███████    ██    ███████ ███████ ██████  ██████
#  ██ ███ ██ ██   ██ ██   ██    ██         ██ ██   ██ ██      ██
#   ███ ███  ██   ██ ██   ██    ██    ███████ ██   ██ ██      ██
#
# WhatsApp Desktop with Catppuccin Mocha theming and transparency
# Using whatsapp-for-linux (wasistlos) - native GTK3 client
#
# References:
# - whatsapp-for-linux: https://github.com/eneshecan/whatsapp-for-linux
# - Catppuccin Mocha palette: https://github.com/catppuccin/catppuccin
# - CSS injection: ~/.config/wasistlos/web.css
# - Hyprland window rules: https://wiki.hyprland.org/Configuring/Window-Rules/

{ config, lib, pkgs, ... }:

let
  # Catppuccin Mocha color palette
  # Reference: https://github.com/catppuccin/palette/blob/main/palette.json
  colors = {
    rosewater = "#f5e0dc";
    flamingo = "#f2cdcd";
    pink = "#f5c2e7";
    mauve = "#cba6f7";      # Accent color
    red = "#f38ba8";
    maroon = "#eba0ac";
    peach = "#fab387";
    yellow = "#f9e2af";
    green = "#a6e3a1";
    teal = "#94e2d5";
    sky = "#89dceb";
    sapphire = "#74c7ec";
    blue = "#89b4fa";
    lavender = "#b4befe";
    text = "#cdd6f4";
    subtext1 = "#bac2de";
    subtext0 = "#a6adc8";
    overlay2 = "#9399b2";
    overlay1 = "#7f849c";
    overlay0 = "#6c7086";
    surface2 = "#585b70";
    surface1 = "#45475a";
    surface0 = "#313244";
    base = "#1e1e2e";
    mantle = "#181825";
    crust = "#11111b";
  };

in
{
  # Install wasistlos (formerly whatsapp-for-linux)
  # Reference: https://github.com/eneshecan/whatsapp-for-linux
  # Note: Package renamed in nixpkgs from whatsapp-for-linux to wasistlos
  home.packages = [ pkgs.wasistlos ];

  # Inject Catppuccin Mocha theme with transparency
  # Reference: Custom CSS is loaded from ~/.config/wasistlos/web.css
  # Note: The config directory is "wasistlos" (German for "what is this")
  # Note: Using universal selectors for better compatibility with WhatsApp Web updates
  home.file.".config/wasistlos/web.css".text = ''
    /* ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     * Catppuccin Mocha theme for WhatsApp Web with transparency
     * Matches kitty terminal (0.8 opacity) and system theme
     * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ */

    /* === ROOT VARIABLES === */
    :root {
      --bg-main: ${colors.base};
      --bg-sidebar: ${colors.mantle};
      --bg-chat: ${colors.crust};
      --bg-panel: ${colors.surface0};
      --bg-panel-hover: ${colors.surface1};
      --text-primary: ${colors.text};
      --text-secondary: ${colors.subtext0};
      --accent: ${colors.mauve};
      --accent-hover: ${colors.pink};
      --message-out: ${colors.mauve};
      --message-in: ${colors.surface0};
    }

    /* === BACKGROUNDS === */
    /* Force dark background on EVERYTHING */
    * {
      background-color: transparent !important;
    }

    /* Main app container - Catppuccin base like kitty */
    body,
    #app,
    #app > div,
    #app > div > div,
    #app > div > span,
    #app > div > span > div,
    ._3pkkz._1b1iR,
    [data-testid="default-user"],
    [data-testid="app"],
    div[tabindex="-1"] {
      background: var(--bg-main) !important;
      background-color: var(--bg-main) !important;
    }

    /* Sidebar (left panel with chats) - mantle */
    #side,
    #side > div,
    [data-testid="chatlist"],
    [data-testid="chatlist-header"],
    ._2Ts6i._1-kWG,
    div[data-testid="chat-list"] {
      background: var(--bg-sidebar) !important;
      background-color: var(--bg-sidebar) !important;
    }

    /* Chat header and conversation area - crust */
    header[data-testid="conversation-header"],
    #main,
    #main > div,
    #main > div > div,
    ._2Ts6i._2xAQV,
    [data-testid="conversation-panel-wrapper"],
    [data-testid="conversation-panel-body"] {
      background: var(--bg-chat) !important;
      background-color: var(--bg-chat) !important;
    }

    /* === TEXT COLORS === */
    /* Force ALL text to be WHITE - very aggressive */
    body, body * {
      color: ${colors.text} !important;
    }

    /* Primary text - WHITE/BRIGHT */
    span:not([data-icon]),
    p,
    div:not([data-icon]),
    h1, h2, h3, h4, h5, h6,
    div[contenteditable="true"],
    [data-testid="default-user"] span,
    ._11JPr,
    ._3Jvyf,
    [role="gridcell"] span:not([data-icon]),
    [role="row"] span:not([data-icon]),
    .selectable-text {
      color: ${colors.text} !important;
    }

    /* Chat names and titles - BRIGHT WHITE */
    [data-testid="cell-frame-title"],
    [data-testid="cell-frame-title"] span,
    [data-testid="conversation-info-header-chat-title"],
    ._11JPr.selectable-text {
      color: ${colors.text} !important;
      font-weight: 600 !important;
    }

    /* Secondary text - light grey */
    [data-testid="last-msg-status"],
    [data-testid="last-msg-status"] span,
    [data-testid="last-msg-time"],
    [data-testid="status"],
    ._3Bxar,
    ._3j7s9,
    time {
      color: ${colors.subtext0} !important;
    }

    /* === CHAT LIST ITEMS === */
    /* Chat items with dividing lines */
    [data-testid="cell-frame-container"] {
      background: var(--bg-panel) !important;
      border-radius: 8px !important;
      margin: 4px 8px !important;
      padding: 8px !important;
      border-bottom: 1px solid rgba(203, 166, 247, 0.1) !important;
      transition: background 0.2s !important;
    }

    /* Hover state */
    [data-testid="cell-frame-container"]:hover {
      background: var(--bg-panel-hover) !important;
    }

    /* Selected chat */
    [data-testid="cell-frame-container"][aria-selected="true"],
    [data-testid="list-item-"]:has([aria-selected="true"]) {
      background: var(--accent) !important;
      background: linear-gradient(90deg,
        rgba(203, 166, 247, 0.4) 0%,
        rgba(203, 166, 247, 0.2) 100%) !important;
      border-left: 4px solid var(--accent) !important;
    }

    /* Selected chat text - make it brighter */
    [data-testid="cell-frame-container"][aria-selected="true"] * {
      color: var(--text-primary) !important;
    }

    /* === MESSAGE BUBBLES === */
    /* Outgoing messages (yours) - mauve */
    [data-testid="msg-container"].message-out > div > div {
      background: var(--message-out) !important;
      color: ${colors.crust} !important;
    }

    [data-testid="msg-container"].message-out span {
      color: ${colors.crust} !important;
    }

    /* Incoming messages */
    [data-testid="msg-container"].message-in > div > div {
      background: var(--message-in) !important;
      color: var(--text-primary) !important;
    }

    /* === INPUT AREAS === */
    /* Message compose box */
    footer,
    [data-testid="conversation-compose-box-input"],
    [contenteditable="true"][data-testid] {
      background: var(--bg-panel) !important;
      color: var(--text-primary) !important;
    }

    /* Search box */
    [data-testid="chat-list-search"],
    [data-testid="search-input"] {
      background: var(--bg-panel) !important;
      color: var(--text-primary) !important;
    }

    /* === SCROLLBARS === */
    ::-webkit-scrollbar {
      width: 8px;
      height: 8px;
    }

    ::-webkit-scrollbar-track {
      background: transparent !important;
    }

    ::-webkit-scrollbar-thumb {
      background: var(--accent) !important;
      border-radius: 4px;
    }

    ::-webkit-scrollbar-thumb:hover {
      background: var(--accent-hover) !important;
    }

    /* === ICONS === */
    /* Default icons - white/grey for passive state */
    svg,
    span[data-icon],
    svg path {
      color: ${colors.subtext0} !important;
      fill: ${colors.subtext0} !important;
    }

    /* Active/selected chat icons - mauve */
    [data-testid="cell-frame-container"][aria-selected="true"] svg,
    [data-testid="cell-frame-container"][aria-selected="true"] span[data-icon],
    [aria-selected="true"] svg path {
      color: ${colors.mauve} !important;
      fill: ${colors.mauve} !important;
    }

    /* Hover state icons - lighter grey */
    [data-testid="cell-frame-container"]:hover svg,
    button:hover svg,
    button:hover span[data-icon] {
      color: ${colors.text} !important;
      fill: ${colors.text} !important;
    }

    /* Active buttons and interactive icons - mauve */
    button[aria-pressed="true"] svg,
    button.active svg,
    [data-icon="status-check"] {
      color: ${colors.mauve} !important;
      fill: ${colors.mauve} !important;
    }

    /* === BUTTONS === */
    button {
      color: var(--text-primary) !important;
    }

    button:hover {
      background: rgba(203, 166, 247, 0.2) !important;
      border-radius: 8px !important;
    }

    /* === UNREAD BADGES === */
    [data-testid="unread-count"],
    ._38M1B,
    ._1V6mh {
      background: ${colors.green} !important;
      color: ${colors.crust} !important;
      font-weight: bold !important;
    }

    /* === BORDERS AND DIVIDERS === */
    /* Header borders */
    header {
      border-bottom: 2px solid rgba(203, 166, 247, 0.2) !important;
    }

    /* Sidebar border - separates chat list from conversation */
    #side {
      border-right: 2px solid rgba(203, 166, 247, 0.15) !important;
    }

    /* Search box border */
    [data-testid="chat-list-search"] {
      border-bottom: 1px solid rgba(203, 166, 247, 0.1) !important;
    }

    /* Individual chat item borders for clear separation */
    [role="listitem"] {
      border-bottom: 1px solid rgba(69, 71, 90, 0.5) !important;
    }

    /* === MODALS AND MENUS === */
    [role="dialog"],
    [role="menu"],
    ._3iBPz {
      background: var(--bg-sidebar) !important;
      border: 1px solid var(--bg-panel) !important;
      border-radius: 12px !important;
    }

    /* Menu items hover */
    [role="menuitem"]:hover {
      background: rgba(203, 166, 247, 0.2) !important;
    }

    /* === IMAGES AND MEDIA === */
    img,
    video {
      border-radius: 8px !important;
    }

    /* === LINKS === */
    a {
      color: ${colors.blue} !important;
    }

    a:hover {
      color: ${colors.sapphire} !important;
    }
  '';

  # Configure Hyprland window rules for transparency and aesthetics
  # Reference: Window class for whatsapp-for-linux is "wasistlos"
  # Note: https://github.com/NixOS/nixpkgs/issues/377920
  wayland.windowManager.hyprland = lib.mkIf config.wayland.windowManager.hyprland.enable {
    settings = {
      windowrule = [
        # Apply transparency matching kitty (0.8 opacity)
        "opacity 0.8 0.8,class:^(wasistlos)$"
      ];

      windowrulev2 = [
        # Disable blur for picture-in-picture to maintain performance
        "noblur,class:^(wasistlos)$,title:^(Picture-in-Picture)$"
      ];
    };
  };
}
