#!/bin/bash

echo

IPs=$(ip -br addr show | sed -r 's/ +/ /g' | cut -f1,3 -d" " | sed -r 's/\/.+//g')

while IFS=' ' read -ra ADDR; do
    if [[ "${ADDR[0]}" == "lo" ]]; then continue; fi
    echo "${ADDR[0]}: ${ADDR[1]}"
done <<< "$IPs"

echo