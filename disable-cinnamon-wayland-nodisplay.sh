#!/bin/bash

SESSION_FILE="/usr/share/wayland-sessions/cinnamon-wayland.desktop"

if [ -f "$SESSION_FILE" ]; then
  # Prüfen, ob NoDisplay=true schon gesetzt ist
  if grep -q '^NoDisplay=true' "$SESSION_FILE"; then
    echo "NoDisplay=true ist bereits gesetzt."
  else
    echo "NoDisplay=true" | sudo tee -a "$SESSION_FILE"
    echo "NoDisplay=true wurde zu $SESSION_FILE hinzugefügt."
  fi
else
  echo "Die Datei $SESSION_FILE existiert nicht!"
fi