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

command="/usr/bin/acserver \
    -port $SERVER_PORT \
    $SERVER_NAME \
    $ACI_DIRECTORY \
    $TEMPLATE_DIRECTORY \
    $USERNAME \
    $PASSWORD \
"

exec $command
