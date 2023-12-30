
# KALI

1. Alias

```sh
vi /root/.bash_aliases

alias ll='ls --color=always -hla'

function apt-updater { 
	apt-get update && 
	apt-get dist-upgrade -Vy && 
	apt-get autoremove -y && 
	apt-get autoclean && 
	apt-get clean &&
	searchsploit -u #&& 
	#reboot 
}

function newctf {
	_template="/home/kali/Hacks/READMECTF_TEMPLATE.md"
	_readme="README.md"
	if [[ $# == 1 && -f "${_template}" && ! -d "$1" ]]
	then
		mkdir $1
		cd $1
		cp "${_template}" "${_readme}"
		sed -i "s/ctfname/$1/" "${_readme}"
		subl "${_readme}"
	else
		if [[ $# != 1 ]]
		then
			echo "Wrong parameter"
		fi
		if [[ ! -f "${_template}" ]]
		then
			echo "${_template} does not exist"
		fi
		if [[ -d "$1" ]]
		then
			echo "$1 already exist"
		fi
	fi
}
```

In `~/.vimrc`
```sh
source $VIMRUNTIME/defaults.vim
set mouse-=a
```

```sh
sudo ln -s /home/kali/Hacks/Divers/upload_file_nc.sh /usr/local/bin/upload_file_nc
sudo ln -s /home/kali/Hacks/Divers/upload_file_wget.sh /usr/local/bin/upload_file_wget
```

2. Terminal

```sh
apt install terminator
```

3. Latest Version of Tor

```sh
echo 'deb https://deb.torproject.org/torproject.org stretch main
deb-src https://deb.torproject.org/torproject.org stretch main' > /etc/apt/sources.list.d/tor.list

wget -O- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | sudo apt-key add - 

apt-get update 

apt-get install tor deb.torproject.org-keyring 
```

4. SublimeText

```sh
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

sudo apt-get install apt-transport-https

echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt-get update

sudo apt-get install sublime-text
```

5. Change SSH Keys & Default Password

```sh
cd /etc/ssh/ 
dpkg-reconfigure openssh-server 

passwd root
```

6. Software

```sh
apt install gobuster

apt install seclists

apt install terminator

apt install steghide

sudo apt install python3-pip

pip3 install stegcracker
```

get rustscan: https://github.com/RustScan/RustScan/releases
dpkg -i deb_file

## Wifite
```sh
sudo apt install hcxdumptool
sudo apt install hcxtools
```

* Pyrit

```sh
sudo apt-get install libpcap-dev
sudo apt-get install python2.7-dev libssl-dev zlib1g-dev libpcap-dev
git clone https://github.com/JPaulMora/Pyrit.git
cd Pyrit
sudo python setup.py clean
sudo python setup.py build
sudo python setup.py install
```
```sh
sudo wifite --wpa --dict file.txt --kill
```

## VULSCAN

Install in /usr/share/nmap/scripts/vulscan or /usr/local/share/nmap/scripts/vulscan
```sh
git clone https://github.com/scipag/vulscan
nmap -sV --script=vulscan/vulscan.nse www.example.com
wget https://www.computec.ch/projekte/vulscan/download/cve.csv
wget https://www.computec.ch/projekte/vulscan/download/exploitdb.csv
wget https://www.computec.ch/projekte/vulscan/download/openvas.csv
wget https://www.computec.ch/projekte/vulscan/download/osvdb.csv
wget https://www.computec.ch/projekte/vulscan/download/scipvuldb.csv
wget https://www.computec.ch/projekte/vulscan/download/securityfocus.csv
wget https://www.computec.ch/projekte/vulscan/download/securitytracker.csv
wget https://www.computec.ch/projekte/vulscan/download/xforce.csv
``