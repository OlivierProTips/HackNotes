#!/bin/bash

dest_folder="/opt"

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

if [[ "$#" != 1  ]]; then
  echo "Give burp jar file"
  exit
fi

if [[ ! -f "${1}" ]]; then
  echo "${1} is not a file"
  exit
fi

new_app_name=$(basename "${1}")

cp "${1}" "${dest_folder}"
ln -nfs "${dest_folder}"/"${new_app_name}" "${dest_folder}"/burpsuite 

cd /opt
