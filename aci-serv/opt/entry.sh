#!/bin/sh

#   Usage of /usr/bin/acserver:
#   acserver SERVER_NAME ACI_DIRECTORY TEMPLATE_DIRECTORY USERNAME PASSWORD
#   Flags:
#     -https
#           Whether or not to provide https URLs for meta discovery
#     -port int
#           The port to run the server on (default 3000)
#     -pubkeys string
#           Path to gpg public keys images will be signed with

exec_path() {
    type -P $1
}

ensure_file() {
    local "$@" ; [[ -e "$target" ]] || cp -f "$source" "$target"
}

defaults() {
    [[ "$SERVER_DIR" ]] || SERVER_DIR="/var/aci"
    [[ "$SERVER_TLS" ]] || SERVER_TLS="no"
    [[ "$ACI_DIRECTORY" ]] || ACI_DIRECTORY="$SERVER_DIR/store"
    [[ "$TEMPLATE_DIRECTORY" ]] || TEMPLATE_DIRECTORY="$SERVER_DIR/templates"
    [[ "$SERVER_NAME" ]] || SERVER_NAME="default"
    [[ "$USERNAME" ]] || USERNAME="default"
    [[ "$PASSWORD" ]] || PASSWORD="default"
    [[ "$SERVER_PORT" ]] || SERVER_PORT="80"
    [[ "$SERVER_KEYS" ]] || SERVER_KEYS="$SERVER_DIR/keys.pub"
}

directories() {
    [[ -e "$SERVER_DIR" ]] || mkdir -p "$SERVER_DIR"
    [[ -e "$ACI_DIRECTORY" ]] || mkdir -p "$ACI_DIRECTORY"
    [[ -e "$TEMPLATE_DIRECTORY" ]] || mkdir -p "$TEMPLATE_DIRECTORY"
}

server_files() {
    ensure_file source="$location/keys.pub" target="$SERVER_KEYS"
    ensure_file source="$location/index.html" target="$TEMPLATE_DIRECTORY/index.html"
}

###

location=$(dirname $0)

defaults
directories
server_files

server_tls=$([[ $SERVER_TLS == 'yes' ]] && echo '-https')

command="\
    $(exec_path acserver) \
    $server_tls \
    -port "$SERVER_PORT" \
    -pubkeys "$SERVER_KEYS" \
    "$SERVER_NAME" \
    "$ACI_DIRECTORY" \
    "$TEMPLATE_DIRECTORY" \
    "$USERNAME" \
    "$PASSWORD" \
"

exec $command
