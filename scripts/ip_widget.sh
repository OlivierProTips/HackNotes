#!/bin/bash

IP=$(ip -br addr show | grep -i "tun" | sed -r 's/ +/ /g' | cut -f3 -d" " | sed -r 's/\/.+//g' | head -n1)
if [[ -z $IP ]]; then
    IP=$(ip -br addr show | grep -i "eth" | sed -r 's/ +/ /g' | cut -f3 -d" " | sed -r 's/\/.+//g' | head -n1)
fi

echo $IP
