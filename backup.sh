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

    local status="$1"
    shift

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

    local opt
    local SOURCE

    # Process command-line options
    while getopts ":d:k:vh" opt; do
        case "$opt" in
            d)
                DEST="$OPTARG"
                ;;
            k)
                KEEP="$OPTARG"
                ;;
            v)
                VERBOSE=true
                ;;
            h)
                usage
                exit 0
                ;;
            :)
                die 2 "Option -$OPTARG requires an argument"
                ;;
            \?)
                die 2 "Unknown option: -$OPTARG"
                ;;
        esac
    done

    # Remove processed options
    shift "$((OPTIND - 1))"

    # Get the remaining source argument
    SOURCE="${1:-}"

    # Validate the source argument
    if [[ -z "$SOURCE" ]]; then
        die 2 "Source directory is required"
    fi

    # Check that the source exists and is a directory
    if [[ ! -d "$SOURCE" ]]; then
        die 2 "Source is not a valid directory: $SOURCE"
    fi

    # Validate KEEP: it must be a positive whole number
    if [[ ! "$KEEP" =~ ^[1-9][0-9]*$ ]]; then
        die 2 "KEEP must be a positive whole number"
    fi


    # Remove processed options from the argument list
    shift "$((OPTIND - 1))"

    # The remaining positional argument is the source
    SOURCE="${1:-}"

    # Temporary output for testing Slice 2
    printf 'SOURCE: %s\n' "$SOURCE"
    printf 'DEST: %s\n' "$DEST"
    printf 'KEEP: %s\n' "$KEEP"
    printf 'VERBOSE: %s\n' "$VERBOSE"

}
main "$@"