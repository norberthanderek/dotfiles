#!/bin/zsh
set -e

SCRIPT_DIR="${0:A:h}"
SRC="$SCRIPT_DIR/sway-nvidia.desktop"

# The session dir is per display manager, so refuse to guess it.
# /usr/local survives package upgrades and GDM scans it before /usr/share.
DM=$(systemctl show display-manager.service -p Id --value 2>/dev/null)
case "$DM" in
    gdm.service|gdm3.service)
        DEST="/usr/local/share/wayland-sessions/sway-nvidia.desktop" ;;
    *)
        echo "Unsupported display manager: ${DM:-none}." >&2
        echo "Check where it looks for wayland sessions, then add a branch here." >&2
        exit 1 ;;
esac

if cmp -s "$SRC" "$DEST"; then
    echo "Already current: $DEST"
else
    echo "+ sudo install -D -m 644 $SRC $DEST"
    sudo install -D -m 644 "$SRC" "$DEST"
fi

for expected in WLR_NO_HARDWARE_CURSORS=1 WLR_RENDERER=vulkan --unsupported-gpu; do
    grep -q -- "$expected" "$DEST" || { echo "FAIL: $expected missing from $DEST" >&2; exit 1; }
done

echo "Verified:"
grep '^Exec=' "$DEST"
