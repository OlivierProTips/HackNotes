# DNSMASQ

- Install dnsmasq
```bash
sudo apt install dnsmasq
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

- Uncomment `conf-dir` in /etc/dnsmasq.conf
```bash
sudo vi /etc/dnsmasq.conf
# Include all files in a directory which end in .conf
conf-dir=/etc/dnsmasq.d/,*.conf
```

- Create a personal conf file
```bash
sudo vi /etc/dnsmasq.d/olivierprotips.conf 
server=192.168.2.91
server=8.8.8.8

address=/.quotient.thm/10.10.250.116
```

- Launch service
```bash
sudo systemctl start dnsmasq
sudo systemctl enable dnsmasq
```

## DEPRECATED

```bash
sudo systemctl disable systemd-resolved.service
sudo systemctl stop systemd-resolved.service
sudo mv /etc/resolv.conf /etc/resolv.conf.bak
sudo systemctl restart network-manager.service
```