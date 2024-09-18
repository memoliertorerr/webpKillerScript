export PATH="/usr/local/bin:$PATH"
#!/bin/bash

# Directory to watch for file changes
WATCHED_DIR="/path/to/your/directory"

# Full HD resolution for comparison
MAX_WIDTH=1920
MAX_HEIGHT=1080

# This part is not necessary but I have left it for future daemon tasks
# Full path to fswatch (I've installed it via homebrew)
FSWATCH_PATH="/opt/homebrew/bin/fswatch"  # Update this path

# Function to process images
process_image() {
  local file="$1"
  # Base name and extensions should be defined prior to the deletion of file
  local base_name="${file%.*}"
  local ext="${file##*.}"

    # Check if file exists
  if [ ! -f "$file" ]; then
    echo "File $file does not exist. Skipping."
    return
  fi

  # Check if the file is the horrendous image format webp, convert to jpg (I actually know that webp is a great format but no one uses it properly so...)
  # avif file was also added because I ran into some issues before
  if [[ "$ext" == "webp" || "$ext" == "avif" ]]; then
    echo "Converting $file to JPEGMAFIA"
    magick "$file" "${base_name}.jpeg" && rm "$file"
    file="${base_name}.jpeg"
  fi

  # Check if the file is an image
  file_type=$(file --mime-type -b "$file")
  if [[ "$file_type" == image/* ]]; then
    echo "image detected"

    # Get the resolution of said image
    resolution=$(identify -format "%wx%h" "$file")
    width=$(echo "$resolution" | cut -d'x' -f1)
    height=$(echo "$resolution" | cut -d'x' -f2)

    # Check if the image is bigger than FHD; if it is, scale the image down to save space
    if [[ "$width" -gt $MAX_WIDTH || "$height" -gt $MAX_HEIGHT ]]; then
      echo "Resizing $file from $resolution..."

      # Resize using ImageMagick while maintaining aspect ratio, max dimensions 1920x1080
      magick "$file" -resize "${MAX_WIDTH}x${MAX_HEIGHT}\>" "$file"

      echo "$file resized to $(identify -format "%wx%h" "$file")"
    fi
  fi
}

# Function to monitor the directory for new files
watch_directory() {
  echo "Watching directory: $WATCHED_DIR"
  $FSWATCH_PATH -0 "$WATCHED_DIR" | while read -d "" event; do
    if [[ "$event" == *.jpg || "$event" == *.png || "$event" == *.webp ]]; then
      process_image "$event"
    fi
  done
}

watch_directory
