# SCRIPTS

## upload_file_wget.sh

Make file transfer easier. It displays the full command to be launched on distant server and launch an http server using python3.

Usage: `upload_file_wget.sh file [interface]`

### Install

1. Copy upload_file_wget.sh in /usr/local/bin

2. Make upload_file_wget.sh file executable
```bash
sudo chmod +x /usr/local/bin/upload_file_wget.sh
```

## monip.sh

Display all personal IPs to ease copy paste.

Usage: `monip`

### Install

1. Copy monip.sh in /usr/local/bin

2. Make monip.sh file executable
```bash
sudo chmod +x /usr/local/bin/monip.sh
```

3. Create symbolic link
```bash
sudo ln -s /usr/local/bin/monip.sh /usr/local/bin/monip
```

## vpnchoice

Display a menu that allow to select an openvpn file to be launched

Usage: `sudo vpnchoice`

### Install

1. Install simple-term-menu
```bash
sudo python3 -m pip install simple-term-menu
```

2. Copy vpnchoice.py in /usr/local/bin/vpnchoice

3. Make vpnchoice file executable
```bash
sudo chmod +x /usr/local/bin/vpnchoice
```

4. Edit `vpnlist` variable in /usr/local/bin/vpnchoice with your openvpn files

