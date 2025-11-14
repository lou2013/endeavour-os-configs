#!/usr/bin/env bash
# restore-packages-safe.sh
# Usage:
#   ./restore-packages-safe.sh               # uses ./pkglist.txt
#   ./restore-packages-safe.sh mylist.txt
#   ./restore-packages-safe.sh --dry-run
#
# Notes:
# - Installs repo packages with pacman (uses sudo), AUR packages with yay.
# - Continues when a package fails; logs each package's output to logs/<pkg>.log.
# - Produces succeeded.txt and failed.txt in the current dir.

set -u
# don't use set -e because we want to continue on errors

FILE="pkglist.txt"
DRY_RUN=0
MAX_RETRIES=3
SLEEP_BASE=2     # seconds between retries (multiplied by attempt)

# Simple arg parse
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    -*)
      echo "Unknown option: $arg"
      exit 2
      ;;
    *) FILE="$arg" ;;
  esac
done

if [ ! -f "$FILE" ]; then
  echo "Error: file '$FILE' not found."
  echo "Create it with: yay -Qe > pkglist.txt  (or use yay -Qem for only AUR packages)"
  exit 1
fi

# Check for yay (we may still use pacman)
if ! command -v yay >/dev/null 2>&1; then
  echo "Warning: 'yay' not found. AUR installs will fail unless you install yay."
  echo "You can install yay later with:"
  echo "  sudo pacman -S --needed --noconfirm git base-devel"
  echo "  git clone https://aur.archlinux.org/yay.git /tmp/yay-git"
  echo "  (cd /tmp/yay-git && makepkg -si)"
fi

# Prepare output
mkdir -p logs
: > succeeded.txt
: > failed.txt

# Build package array: strip comments/blank lines and versions (first token per line)
mapfile -t PKGS < <(awk '
  BEGIN{FS="[ \t]+"}
  /^[[:space:]]*#/ { next }
  /^[[:space:]]*$/ { next }
  { print $1 }
' "$FILE")

if [ ${#PKGS[@]} -eq 0 ]; then
  echo "No packages found in '$FILE'."
  exit 0
fi

echo "Found ${#PKGS[@]} packages. Starting installation..."
if [ "$DRY_RUN" -eq 1 ]; then
  echo "[dry-run] packages:"
  for p in "${PKGS[@]}"; do echo "  $p"; done
  exit 0
fi

for pkg in "${PKGS[@]}"; do
  # sanitize package name for logfile (replace slashes, spaces)
  logfile="logs/${pkg//[^a-zA-Z0-9._-]/_}.log"
  echo "------------------------------------------------------------" | tee -a "$logfile"
  echo "$(date --iso-8601=seconds) - Processing package: $pkg" | tee -a "$logfile"

  attempt=1
  success=0
  while [ $attempt -le $MAX_RETRIES ]; do
    echo "Attempt #$attempt for $pkg..." | tee -a "$logfile"

    # If pacman knows this package, install with pacman (faster, canonical).
    if pacman -Si "$pkg" >/dev/null 2>&1; then
      echo "Detected in official repos: will use pacman to install $pkg" | tee -a "$logfile"
      # Use sudo for pacman
      if sudo pacman -S --needed --noconfirm "$pkg" >>"$logfile" 2>&1; then
        success=1
        break
      else
        echo "pacman install failed for $pkg (see $logfile)" | tee -a "$logfile"
      fi
    else
      # Fallback to yay
      if ! command -v yay >/dev/null 2>&1; then
        echo "yay not available; cannot install AUR package $pkg. Skipping." | tee -a "$logfile"
      else
        echo "Not in repos: using yay to build/install $pkg (AUR)..." | tee -a "$logfile"
        # pass --noprogressbar to reduce spamming the log; keep --noconfirm for non-interactive installs
        if yay -S --needed --noconfirm --noprogressbar "$pkg" >>"$logfile" 2>&1; then
          success=1
          break
        else
          echo "yay install failed for $pkg (see $logfile)" | tee -a "$logfile"
        fi
      fi
    fi

    # If we reach here, attempt failed
    attempt=$((attempt + 1))
    sleep_time=$((SLEEP_BASE * attempt))
    echo "Retrying in ${sleep_time}s..." | tee -a "$logfile"
    sleep "$sleep_time"
  done

  if [ $success -eq 1 ]; then
    echo "SUCCESS: $pkg" | tee -a "$logfile"
    echo "$pkg" >> succeeded.txt
  else
    echo "FAILED: $pkg (tried $MAX_RETRIES times). See $logfile for details." | tee -a "$logfile"
    echo "$pkg" >> failed.txt
  fi

  echo "" >> "$logfile"
done

# Summary
echo "============================================================"
echo "Install finished at: $(date --iso-8601=seconds)"
succ_count=$(wc -l < succeeded.txt || echo 0)
fail_count=$(wc -l < failed.txt || echo 0)
echo "Succeeded: $succ_count"
echo "Failed:    $fail_count"
echo ""
if [ "$fail_count" -gt 0 ]; then
  echo "Failed packages saved to: failed.txt"
  echo "Check logs/ for per-package logs (e.g. logs/google-chrome.log)"
fi
echo "Detailed logs are in the logs/ directory."
echo "Done."
