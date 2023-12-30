# SCRIPTS

## upload_file_wget.sh

Make file transfer easier. It displays the full command to be launched on distant server and launch an http server using python3.

Usage: `upload_file_wget.sh file [interface]`

### Install

1. Copy upload_file_wget.sh in /usr/local/bin with the following content:

2. Make upload_file_wget.sh file executable
```bash
sudo chmod +x /usr/local/bin/upload_file_wget.sh
```

## monip.sh

Display all personal IPs to ease copy paste.

Usage: `monip`

### Install

1. Copy monip.sh in /usr/local/bin with the following content:

2. Make monip.sh file executable
```bash
sudo chmod +x /usr/local/bin/monip.sh
```

3. Create symbolic link
```bash
sudo ln -s /usr/local/bin/monip.sh /usr/local/bin/monip
```