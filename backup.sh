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
    exit "$status"
}

# $* is all the arguments joined into one string
log() {
    if [[ "$VERBOSE" == true ]]; then
        echo "[$(date +%H:%M:%S)] $*"
    fi
}

#create_backup with date and tar
create_backup() {
    local SOURCE="$1"
    local DEST="$2"
    local folder_name
    local timestamp
    local archive

    # Get the source folder's name
    folder_name="$(basename "$SOURCE")"

    # Create the destination folder if it doesn't exist
    mkdir -p "$DEST" || die 1 "Could not create destination: $DEST"

    timestamp="$(date +%Y%m%d-%H%M%S)"
    archive="$DEST/$folder_name-$timestamp.tar.gz"

    # Prevent overwriting an existing archive
    local suffix=1
    while [[ -e "$archive" ]]; do
        archive="$DEST/$folder_name-$timestamp($suffix).tar.gz"
        suffix=$((suffix + 1))
    done

    # Create the compressed backup
    if tar -czf "$archive" -C "$(dirname "$SOURCE")" "$folder_name"; then
        log "Backup created: $archive"
        printf 'Backup successful: %s\n' "$archive"
    else
        rm -f "$archive"
        die 1 "Backup failed for: $SOURCE"
    fi
}


rotate_backups() {
    local SOURCE="$1"
    local DEST="$2"
    local KEEP="$3"
    local folder_name
    local count=0
    local archive

    folder_name="$(basename "$SOURCE")"

    while IFS= read -r archive; do
        count=$((count + 1))

        if (( count > KEEP )); then
            rm -f -- "$archive" ||
                die 1 "Could not remove: $archive"

            log "Removed old backup: $archive"
        fi
    done < <(
        find "$DEST" -maxdepth 1 -type f \
            -name "$folder_name-*.tar.gz" \
            -printf '%f\n' |
        sort -r |
        sed "s|^|$DEST/|"
    )
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

    # Resolve the source to an absolute path
    SOURCE="$(cd "$SOURCE" && pwd -P)" ||
        die 2 "Could not resolve source directory"

    # Create the backup
    create_backup "$SOURCE" "$DEST"

    # Remove older backups
    rotate_backups "$SOURCE" "$DEST" "$KEEP"

}
main "$@"