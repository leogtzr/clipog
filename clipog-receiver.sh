#!/usr/bin/bash
set -euo pipefail
set -x

readonly SCRIPT_PATH="$(realpath "$0" 2>/dev/null || readlink -f "$0" 2>/dev/null)"
readonly SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" >/dev/null 2>&1 && pwd)"
readonly TMP_DIR="${SCRIPT_DIR}/tmp"

cleanup() {
    if [[ -d "${TMP_DIR}" ]]; then
        echo "Removing files ..."
        rm -f "${TMP_DIR}"/*
    fi
}

trap cleanup EXIT
trap cleanup ERR INT TERM HUP

# ToDo: analyze the MIMe type of the file and use wl-copy's --type option accordingly.

exit
