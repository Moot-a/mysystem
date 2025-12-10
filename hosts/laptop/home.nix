{ config, pkgs, ... }:

{
  home.username = "moota";
  home.homeDirectory = "/home/moota";

  # Don't use a future version here – match your system, e.g. "24.11"
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  programs.git.enable = true;

  programs.zsh.enable = true;

  programs.kitty = {
    enable = true;

    # Fonts
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };

    # Kitty options that map directly to settings
    settings = {
      window_padding_width    = "6";
      cursor_shape            = "block";
      cursor_blink_interval   = "0.6";
      enable_audio_bell       = "no";
      scrollback_lines        = "10000";
      allow_remote_control    = "yes";
      confirm_os_window_close = "0";
    };

    # Extra raw config (this was wrongly inside `settings` before)
    initContent = ''
      include Argonaut.conf

      map ctrl+left  send_text all \x1b[1;5D
      map ctrl+right send_text all \x1b[1;5C
      map alt+left   send_text all \x1b[1;3D
      map alt+right  send_text all \x1b[1;3C
    '';
  };

  # These must be TOP-LEVEL, not inside programs.kitty
  xdg.configFile."kitty/Argonaut.conf".text = ''
    background            #0d0f18
    foreground            #fffaf3
    cursor                #ff0017
    selection_background  #002a3a
    color0                #222222
    color8                #444444
    color1                #ff000f
    color9                #ff273f
    color2                #8ce00a
    color10               #abe05a
    color3                #ffb900
    color11               #ffd141
    color4                #008df8
    color12               #0092ff
    color5                #6c43a5
    color13               #9a5feb
    color6                #00d7eb
    color14               #67ffef
    color7                #ffffff
    color15               #ffffff
    selection_foreground  #0d0f18
  '';

  xdg.configFile."kitty/Solarized_Light.conf".text = ''
    background            #fdf6e3
    foreground            #52676f
    cursor                #52676f
    selection_background  #e9e2cb
    color0                #e4e4e4
    color8                #ffffd7
    color1                #d70000
    color9                #d75f00
    color2                #5f8700
    color10               #585858
    color3                #af8700
    color11               #626262
    color4                #0087ff
    color12               #808080
    color5                #af005f
    color13               #5f5faf
    color6                #00afaf
    color14               #8a8a8a
    color7                #262626
    color15               #1c1c1c
    selection_foreground  #fcf4dc
  '';
}
