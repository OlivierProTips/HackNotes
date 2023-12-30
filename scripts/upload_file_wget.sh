#!/bin/bash

usage() {
    echo "$0 file [interface]"
    exit 1
}

if [[ $# != 1 && $# != 2 ]]; then usage; fi

if [[ ! -f "$1" ]]; then usage; fi

port=9999
active_dir=$(pwd)
file_dir=$(dirname $1)
file_name=$(basename $1)
interface=""

if [[ -n $2 ]]; then interface=$2; fi

cd "$file_dir"

echo

IPs=$(ip -br addr show $interface | sed -r 's/ +/ /g' | cut -f1,3 -d" " | sed -r 's/\/.+//g')

while IFS=' ' read -ra ADDR; do
    if [[ "${ADDR[0]}" == "lo" ]]; then continue; fi
    echo "${ADDR[0]}:"
    echo " wget http://${ADDR[1]}:$port/$file_name"
done <<< "$IPs"

echo

python3 -m http.server $port

cd "$active_dir"
