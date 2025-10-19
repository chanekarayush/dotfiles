#!/bin/bash

# --- CONFIG ---
API_KEY="AIzaSyBN5XUTsCDBcB0-WqmXB5q7RTZp0LaRBhI"
CX="b1255c41ee4dd4d45"
# ----------------

# Ask for a search query
QUERY=$(rofi -dmenu -i -p "Web Search:")
[ -z "$QUERY" ] && exit 0

# URL encode spaces
formattedQuery="${QUERY// /%20}"

searchEngineURI="https://customsearch.googleapis.com/customsearch/v1?cx=$CX&key=$API_KEY&q=$formattedQuery"

# Fetch search results from Google Custom Search API
RESULTS=$(curl -s "$searchEngineURI" \
  | jq -r '.items[] | "\(.title)\t\(.snippet)\t\(.formattedUrl)"' \
  | head -n 10)

echo "$RESULTS"

# Function to escape Pango markup characters
escape_markup() {
  sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g'
}

# Build Rofi menu with markup (escaped text)
#MENU=$(echo "$RESULTS" | while IFS=$'\t' read -r title snippet url; do
#  safe_title=$(echo "$title" | escape_markup)
#  safe_snippet=$(echo "$snippet" | escape_markup)
#  printf "<b><big>%s</big></b>\n%s\t%s\n" "$safe_title" "$safe_snippet" "$url"
#done)

MENU=$(echo "$RESULTS" | while IFS=$'\t' read -r title snippet url; do
    # Combine title + snippet into one "element"
    # URL is kept as the second field (tab-separated)
    echo "$title — $snippet"$'\t'"$url"
done)


# Show Rofi menu (title + snippet on one line)
SELECTED=$(echo -e "$MENU" | cut -f1 | rofi -dmenu -i -p "Google Search Results:")

# Exit if no selection
[ -z "$SELECTED" ] && exit 0

# Find corresponding URL from MENU
SELECTED_URL=$(echo -e "$MENU" | grep -F "$SELECTED" | cut -f2)

# Open in Firefox
[ -n "$SELECTED_URL" ] && firefox "$SELECTED_URL" &

# Focus Firefox window in Hyprland
sleep 0.5
ADDR=$(hyprctl clients -j | jq -r '.[] | select(.class=="firefox") | .address' | head -n 1)
[ -n "$ADDR" ] && hyprctl dispatch focuswindow address:"$ADDR"

