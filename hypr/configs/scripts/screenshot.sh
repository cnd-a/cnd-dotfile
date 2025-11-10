#!/bin/bash

# Create timestamped screenshot directory
save_dir="$HOME/Pictures/Screenshots/$(date +%Y)/$(date +%B)"
mkdir -p "$save_dir"

# Get active window info
window_info=$(hyprctl activewindow -j)
app_name=$(jq -r '.class' <<< "$window_info")
window_title=$(jq -r '.title' <<< "$window_info")

# Clean and shorten title
clean_title=$(sed 's/[^[:alnum:][:space:]-]/ /g; s/^ *//; s/ *$//' <<< "$window_title" | tr -s ' ' | cut -c1-40)

# Build safe base filename
base_name="${app_name}${clean_title:+ - $clean_title}"
safe_base=$(sed 's/[\/:*?"<>|]/_/g' <<< "$base_name")

# Handle duplicate filenames
filename="$safe_base.png"
counter=1
while [[ -e "$save_dir/$filename" ]]; do
    filename="${safe_base}(${counter}).png"
    ((counter++))
done
fullpath="$save_dir/$filename"

# Take screenshot, copy to clipboard, notify
grim -g "$(slurp)" "$fullpath" &&
wl-copy --type image/png < "$fullpath" &&
notify-send -i "$fullpath" "Screenshot saved" "$base_name"
