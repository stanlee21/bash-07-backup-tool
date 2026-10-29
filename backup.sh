#!/bin/bash
#
# backup.sh - create timestamped backups of a folder
# Usage: backup.sh [-d DEST] [-k KEEP] [-v] SOURCE
# Author: Ama Nkeng, Rebase Code Camp
#
# ---- settings ---------------------------------------------------
DEST="$HOME/backups"
KEEP=5
VERBOSE=false
# ---- helper functions -------------------------------------------
usage() {
    cat <<EOF
Usage: $(basename "$0") [-d DEST] [-k KEEP] [-v] SOURCE

Options:
    -d DEST where to store backups (default: $DEST)
    -k KEEP how many backups to keep (default: $KEEP)
    -v verbose output
    -h show this help
EOF
}


die() {
    echo "Error: $*" >&2
    exit 1
}

# $* is all the arguments joined into one string
log() {
    if [[ "$VERBOSE" == true ]]; then
        echo "[$(date +%H:%M:%S)] $*"
    fi
}
# ---- main logic -------------------------------------------------
main() {
    # ...parse options, validate, do the work...
    : # ':' is a command that does nothing; it keeps the empty function valid
}
main "$@"