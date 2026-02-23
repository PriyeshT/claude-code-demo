#!/bin/bash

DOWNLOADS=~/Downloads

moved=0
trashed=0
misc=0
skipped=0

get_target() {
  local ext="$1"
  case "$ext" in
    pdf)                                      echo "PDFs"         ;;
    jpg|jpeg|png|gif|heic|webp|svg)           echo "Images"       ;;
    mp4|mov|mkv|avi)                          echo "Videos"       ;;
    mp3|wav|aac|m4a)                          echo "Audio"        ;;
    doc|docx|txt|pages)                       echo "Documents"    ;;
    xls|xlsx|csv|numbers)                     echo "Spreadsheets" ;;
    zip|rar|tar|gz|7z)                        echo "Archives"     ;;
    json|xml|db|sql)                          echo "Data"         ;;
    ttf|otf|woff)                             echo "Fonts"        ;;
    *)                                        echo "Misc"         ;;
  esac
}

# Only process regular files at the root level
while IFS= read -r -d '' file; do
  name=$(basename "$file")

  # Skip macOS system files
  if [ "$name" = ".DS_Store" ] || [ "$name" = ".localized" ]; then
    skipped=$((skipped + 1))
    continue
  fi

  # Extract extension (lowercase)
  case "$name" in
    *.*) ext=$(printf '%s' "${name##*.}" | tr '[:upper:]' '[:lower:]') ;;
    *)   ext="" ;;
  esac

  # Installers → Trash
  if [ "$ext" = "dmg" ] || [ "$ext" = "pkg" ]; then
    echo "  TRASH  $name"
    /usr/bin/trash "$file"
    trashed=$((trashed + 1))
    continue
  fi

  target=$(get_target "$ext")

  mkdir -p "$DOWNLOADS/$target"
  echo "  MOVE   $name  →  $target/"
  mv "$file" "$DOWNLOADS/$target/"

  if [ "$target" = "Misc" ]; then
    misc=$((misc + 1))
  else
    moved=$((moved + 1))
  fi

done < <(find "$DOWNLOADS" -maxdepth 1 -type f -print0)

echo ""
echo "Done."
echo "  Organized : $moved file(s)"
echo "  Misc      : $misc file(s)"
echo "  Trashed   : $trashed file(s)"
echo "  Skipped   : $skipped system file(s)"
