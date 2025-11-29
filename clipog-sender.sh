#!/bin/bash
set -euo pipefail

readonly SCRIPT_PATH="$(realpath "$0" 2>/dev/null || readlink -f "$0" 2>/dev/null)"
readonly SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" >/dev/null 2>&1 && pwd)"
readonly TMP_DIR="${SCRIPT_DIR}/tmp"
readonly SCRIPT_REMOTE_DIR_PATH="/home/leo/dev/bash/clipog"
readonly SCRIPT_REMOTE_DIR_TMP_PATH="${SCRIPT_REMOTE_DIR_PATH}/tmp"
readonly REMOTE_CLIPBOARD_CONTENT_FILE="${SCRIPT_REMOTE_DIR_TMP_PATH}/clipboard_content"
readonly LOCAL_CLIPBOARD_CONTENT_FILE="${TMP_DIR}/clipboard_content"
readonly REMOTE_USER=leo
readonly REMOTE_HOSTNAME=omarchy.local

cleanup() {
    if [[ -d "${TMP_DIR}" ]]; then
        echo "Removing files ..."
        rm -f "${TMP_DIR}"/*
    fi
}

trap cleanup EXIT
trap cleanup ERR INT TERM HUP

if pbpaste > "${LOCAL_CLIPBOARD_CONTENT_FILE}"; then
    scp "${LOCAL_CLIPBOARD_CONTENT_FILE}" "${REMOTE_USER}@${REMOTE_HOSTNAME}:${REMOTE_CLIPBOARD_CONTENT_FILE}" > /dev/null 2>&1
    ssh -t "${REMOTE_USER}@${REMOTE_HOSTNAME}" "bash -lc 'wl-copy < ${REMOTE_CLIPBOARD_CONTENT_FILE} && notify-send 📋 \"Clipboard content received\" '" 2> /dev/null
fi

exit
