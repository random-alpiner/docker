#!/bin/bash

# {{ ansible_managed }}

# udhcpc script
# https://udhcp.busybox.net/README.udhcpc
# https://github.com/mirror/busybox/tree/master/examples/udhcp

log() {
    logger -t "entry" "$DHCP_RUNNER : $@" 
}

route_create() {
    [[ "$interface" ]] || { log "missing interface" ; return ; } 
    [[ "$router" ]] || { log "missing router" ; return ; } 
    local entry=
    for entry in $router ; do
        ip route add default via $entry dev $interface
    done    
}

route_delete() {
    [[ "$interface" ]] || { log "missing interface" ; return ; } 
    while ip route del dev $interface 2> /dev/null ; do
        :
    done
}

address_create() {
    [[ "$interface" ]] || { log "missing interface" ; return ; } 
    [[ "$subnet" ]] || { log "missing subnet" ; return ; } 
    [[ "$broadcast" ]] || { log "missing broadcast" ; return ; } 
    ip address add $ip/$subnet broadcast $broadcast dev $interface
}

address_delete() {
    [[ "$interface" ]] || { log "missing interface" ; return ; } 
    ip address flush dev $interface
}

dhcp_create() {
    log "create"
    env | sort > "$DHCP_STATUS"
    address_create
    route_create
}

dhcp_ensure() {
    log "ensure"
    dhcp_delete
    dhcp_create
}

dhcp_delete() {
    log "delete"
    rm -f "$DHCP_STATUS"
    route_delete
    address_delete
}

dhcp_error() {
    log "error: message=$message"
}

arguments() {
    readonly DHCP_RUNNER="$BASH_SOURCE"
    readonly DHCP_STATUS="$DHCP_RUNNER.status"
}

main() {
    arguments
    case "$command" in
        bound)    dhcp_create ;;
        renew)    dhcp_ensure ;;
        deconfig) dhcp_delete ;;
        nak)      dhcp_error  ;;
        *)        log "wrong command $command" ;;
    esac
}

###

export readonly command="$1"

main
