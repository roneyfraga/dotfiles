#!/bin/bash
CONFIG="$HOME/.config/sioyek/prefs_user.config"
SCRIPT="$HOME/.config/sioyek/theme.sh"

case "$1" in
  white)
    BG="1.0 1.0 1.0"
    FG="0.0 0.0 0.0"
    APP_BG="1.0 1.0 1.0"
    ;;
  sepia)
    BG="0.984 0.941 0.851"
    FG="0.396 0.263 0.129"
    APP_BG="0.984 0.941 0.851"
    ;;
  dark)
    BG="0.118 0.118 0.118"
    FG="0.851 0.902 0.902"
    APP_BG="0.118 0.118 0.118"
    ;;
  *)
    exit 1
    ;;
esac

cat > "$CONFIG" << EOF
# Theme colors
custom_background_color  $BG
custom_text_color        $FG
background_color         $APP_BG

# Enable custom color on startup
startup_commands  toggle_custom_color

# Theme switching commands
new_command _theme_white bash $SCRIPT white
new_command _theme_sepia bash $SCRIPT sepia
new_command _theme_dark  bash $SCRIPT dark
EOF
