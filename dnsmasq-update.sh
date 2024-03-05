#!/bin/bash

# by Bigyls

# Usage 1: ./dnsmasq-update.sh add <host> <domain>
    # host = X.X.X.X
    # domain = domain.name

# Usage 2: ./dnsmasq-update.sh remove <domain>
    # domain = domain.name

# Usage 3: ./dnsmasq-update.sh list
    # list available tld (top-level domains)

# Usage 4: ./dnsmasq-update.sh list <tld>
    # tld = top-level domain (e.g. com, net, org, htb, etc.)

# Check if running as root
if [ "$EUID" -ne 0 ]
then
    echo "ERROR: Please run as root"
    exit 1
fi

# Contants
RED="\033[0;31m"
GREEN="\033[0;32m"
ENDCOLOR="\033[0m"

# Variables
config_path="/etc/NetworkManager/dnsmasq.d/"

# Add domain to dnsmasq
if [ $1 == "add" ]; then

    if [ $# -ne 3 ]; then
        # Inform user
        echo -e "${RED}[-] Incorrect number of arguments.${ENDCOLOR}";
        exit 1;
    fi

    if [ $# -eq 3 ]; then
        # Arguments
        action=$1
        host=$2
        domain=$3
        config_file=${config_path}${tld}".conf"
        sed 's/\// /g' ${config_file}

        # If config file does not exist, put the default server
        if [ ! -e "$config_file" ]; then
            echo "server=8.8.8.8" > "$config_file"
        fi

        # Check if domain already exists
        if grep -q "${domain}" "$config_file"; then
            echo -e "${GREEN}[+] Domain already exists.${ENCOLOR}";
            exit 1;
        fi

        # Add domain to config file
        echo "address=/.${domain}/${host}" >> "$config_file"

        # Restart NetworkManager to apply modifications
        systemctl restart NetworkManager.service;

        # Check if domain was added
        if grep -q "${domain}" "$config_file"; then

            # Inform user
            echo -e "${GREEN}[+] Successful Update.${ENCOLOR}";
            exit 0;
        else
            # Inform user
            echo -e "${RED}[-] Failed to update.${ENCOLOR}";
            exit 1;
        fi

    fi

fi

# Remove domain from dnsmasq
if [ $1 == "remove" ]; then

    if [ $# -ne 2 ]; then
        # Inform user
        echo -e "${RED}[-] Incorrect number of arguments.${ENDCOLOR}";
        exit 1;
    fi

    if [ $# -eq 2 ]; then
        # Arguments
        action=$1
        domain=$2

        # Local variables
        dom_array=(`echo $domain | tr '.' '\n'`)
        tld=${dom_array[${#dom_array[@]}-1]}
        config_file=${config_path}${tld}".conf"

        if [ -e "$config_file" ]; then
            sed -i "/${domain}/d" "$config_file"
            # Check if only server=8.8.8.8 remains in the file
            if [ $(wc -l < "$config_file") -eq 1 ]; then
                rm "$config_file"
            fi
            # Restart NetworkManager to apply modifications
            systemctl restart NetworkManager.service;
            # Check if domain was removed

            if ! grep -q "${domain}" "$config_file" 2>/dev/null; then
                # Inform user
                echo -e "${GREEN}[+] Successful Update.${ENCOLOR}";
                exit 0;

            else
                # Inform user
                echo -e "${RED}[-] Failed to update.${ENCOLOR}";
                exit 1;
            fi

        else
            # Inform user
            echo -e "${GREEN}[+] Domain not found.${ENCOLOR}";
            exit 1;
        fi

    else
        # Inform user
        echo -e "${RED}[-] Incorrect arguments.${ENCOLOR}";
        exit 1;
    fi

fi

# List domains from dnsmasq
if [ $1 == "list" ]; then

    if [ $# -eq 1 ]; then
        # Local variables
        tlds=(`ls ${config_path} | awk -F'.' '{print $1}'`);

        # Check if there are any tlds
        if [ ${#tlds[@]} -eq 0 ]; then
            # Inform user
            echo -e "${RED}[-] No TLDs found.${ENCOLOR}";
            exit 1;
        fi

        # Inform user
        echo -e "${GREEN}[+] TLDs:${ENDCOLOR}\n${tlds[@]}";
        exit 0;
    fi

    if [ $# -eq 2 ]; then

        # Arguments
        action=$1
        tld=$2

        # Local variables
        config_file=${config_path}${tld}".conf"

        if [ -e "$config_file" ]; then
            echo -e "${GREEN}[+] Domains:${ENDCOLOR}\n$(cat $config_file | grep -v 'server=' | awk -F'=/' '{print $2}' | sed 's/\// /g')";
            exit 0;
        else
            # Inform user
            echo -e "${RED}[-] TLD not found.${ENCOLOR}";
            exit 1;
        fi

    fi

fi
