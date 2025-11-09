#!/usr/bin/env sh
# restore-packages.sh
# Usage:
#   ./restore-packages.sh                # uses ./pkglist.txt
#   ./restore-packages.sh mylist.txt     # uses given file
#   ./restore-packages.sh --dry-run      # show what would be installed
#   ./restore-packages.sh --dry-run mylist.txt

set -eu

DRY_RUN=0
FILE="pkglist.txt"

# parse args (simple)
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    -*)
      echo "Unknown option: $arg"
      exit 2
      ;;
    *)
      FILE="$arg"
      ;;
  esac
done

if [ ! -f "$FILE" ]; then
  echo "Error: file '$FILE' not found."
  echo "Create it with: yay -Qe > pkglist.txt  (or use yay -Qem for only AUR packages)"
  exit 1
fi

# Check for yay
if ! command -v yay >/dev/null 2>&1; then
  cat <<EOF
Error: 'yay' not found.
Install yay first. Quick steps (example):

  sudo pacman -S --needed --noconfirm git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay-git
  (cd /tmp/yay-git && makepkg -si)

Then re-run this script.
EOF
  exit 1
fi

# Build package list: strip comments, empty lines, and versions
# Accept lines like: package 1.2.3   or "pkgname"
PKGS=$(awk '
  BEGIN{FS="[ \t]+"}
  /^[[:space:]]*#/ { next }           # skip comment lines
  /^[[:space:]]*$/ { next }           # skip blank lines
  { print $1 }                        # first token = package name
' "$FILE" | tr '\n' ' ' | sed 's/[[:space:]]*$//')

if [ -z "$PKGS" ]; then
  echo "No packages found in '$FILE'."
  exit 0
fi

echo "Packages to process:"
echo "$PKGS" | tr ' ' '\n'
echo

if [ "$DRY_RUN" -eq 1 ]; then
  echo "[dry-run] Would run: yay -S --needed --noconfirm <packages>"
  exit 0
fi

# Install (in reasonably sized batches to avoid super long command lines)
# We'll install in batches of 50 packages
i=0
set -- $PKGS
while [ $# -gt 0 ]; do
  batch=""
  j=0
  while [ $# -gt 0 ] && [ $j -lt 50 ]; do
    batch="$batch $1"
    shift
    j=$((j + 1))
  done
  i=$((i + 1))
  echo "Installing batch #$i (packages: $j)..."
  yay -S --needed --noconfirm $batch
done

echo "Done."
