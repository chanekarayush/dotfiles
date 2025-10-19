#!/bin/bash

SEARCH_DIR="$HOME"

export XDG_DATA_DIRS="$HOME/.local/share:/usr/local/share:/usr/share:$XDG_DATA_DIRS"
# --- 1️⃣ Search local files, directories, and applications ---

CHOICE=$(fd . "$SEARCH_DIR" /usr/share/applications ~/.local/share/applications \
    --hidden --exclude ".cache" --exclude ".local/share/Trash" \
    | while read -r f; do
        rel="${f#$HOME/}"
        if [ -d "$f" ]; then
            echo "📁 $rel"
        elif [[ "$f" == *.desktop ]]; then
            echo "🚀 $(basename "${f%.desktop}")"
        elif [ -x "$f" ]; then
            echo "⚙️ $rel"
        else
            echo "📄 $rel"
        fi
    done \
    | rofi -dmenu -i -p "Spotlight Search:")

# Exit if nothing selected
[ -z "$CHOICE" ] && exit 0

# Strip emoji
CLEAN_CHOICE="${CHOICE#* }"

# --- 2️⃣ Try launching desktop apps ---
if [[ -f "/usr/share/applications/${CLEAN_CHOICE}.desktop" ]]; then
    gtk-launch "${CLEAN_CHOICE%.desktop}"
    exit 0
elif [[ -f "$HOME/.local/share/applications/${CLEAN_CHOICE}.desktop" ]]; then
    gtk-launch "${CLEAN_CHOICE%.desktop}"
    exit 0
fi

# --- 3️⃣ Try opening file/folder ---
FULL_PATH="$HOME/$CLEAN_CHOICE"
if [ -e "$FULL_PATH" ]; then
    xdg-open "$FULL_PATH"
    exit 0
fi

# --- 4️⃣ Try executing as command ---
if command -v "$CLEAN_CHOICE" >/dev/null 2>&1; then
    "$CLEAN_CHOICE" &
    exit 0
fi

# --- 5️⃣ DuckDuckGo fallback ---
# Replace spaces with +
encoded="${CHOICE// /+}"
selected_url="https://duckduckgo.com/?q=$encoded"
# echo $selected_url
firefox "$selected_url" &

