# DNSMASQ

## Install

With new version of Kali, dnmasq is part of NetworkManager

If you installed dnsmasq previously, remove it

```bash
sudo apt remove dnsmasq
```

- Add `dns=dnsmasq`to /etc/NetworkManager/NetworkManager.conf
```bash
sudo vi /etc/NetworkManager/NetworkManager.conf   
[main]
dns=dnsmasq
plugins=ifupdown,keyfile

[ifupdown]
managed=false
```

- Create a personal conf file
```bash
sudo vi /etc/NetworkManager/dnsmasq.d/olivierprotips.conf 
server=8.8.8.8

address=/.quotient.thm/10.10.250.116
```

- Restart NetworkManager service
  
```bash
sudo systemctl restart NetworkManager.service
```

## Script to add entry (thanks Bigyls)

```bash
#!/bin/bash

# Usage: ./dnsmasq-update.sh <domain> <host>

if [ "$EUID" -ne 0 ]
then
    echo "ERROR: Please run as root"
    exit 1
fi

domain=$1
host=$2
config_path="/etc/NetworkManager/dnsmasq.d/"
dom_array=(`echo $domain | tr '.' '\n'`)
tld=${dom_array[${#dom_array[@]}-1]}
config_file=${config_path}${tld}".conf"

if [ $# -eq 2 ]; then

    if [ ! -e "$config_file" ]; then
        echo "server=8.8.8.8" > "$config_file"
    fi

    echo "address=/.${domain}/${host}" >> "$config_file"
    systemctl restart NetworkManager.service;
else
    echo "ERR: Incorrect arguments.";
    exit 1;
fi
```

## Demo

![Alt text](images/dnsmasq.gif)

## Troubleshooting

Sometimes, it can not work. When you ping the hostname, you get no response.

It is possible this is the fault of `systemd-resolved`

In newest Kali, this service does not exist anymore, but in old Kali, it is responsible of messing up your `/etc/resolv.conf`

- Disable systemd-resolved
  
```bash
sudo systemctl disable systemd-resolved.service
sudo systemctl stop systemd-resolved.service
```

- Modify /etc/resolv.conf

```bash
nameserver 127.0.0.1
options edns0 trust-ad
```