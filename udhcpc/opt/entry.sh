#!/bin/sh

command="udhcpc \
        --fqdn $MACHINE_NAME \
        --interface $MACHINE_FACE \
        --script $DHCP_RUNNER \
        --retries 0 \
        --timeout 1 \
        --tryagain 1 \
        --release \
        --foreground \
"

exec $command
