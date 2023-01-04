#!/usr/bin/env python3

"""
Before using this script, install simple-term-menu
    sudo python3 -m pip install simple-term-menu
"""

from simple_term_menu import TerminalMenu
import os

# Check if it is launched using sudo
# as openvpn must be launch with admin rights
if os.geteuid() != 0:
    print("Launch it with sudo")
    exit()

# List of openvpn files
# Use your own files path here
ovpn_files_folder = "/home/kali/ctf/ovpn_files"
vpnlist = {
    "TryHackMe": f"{ovpn_files_folder}/tryhackme.ovpn",
    "HackTheBox": f"{ovpn_files_folder}/hackthebox.ovpn",
    "ProvingGrounds": f"{ovpn_files_folder}/pg.ovpn"
}

# Display menu
main_menu_title = "Select an openvpn file:"
options = []
for site in vpnlist.keys():
    options.append(site)
terminal_menu = TerminalMenu(options, title=main_menu_title)
menu_entry_index = terminal_menu.show()

# ESC key and CRTL+C return None
if menu_entry_index != None:
    os.system(f"openvpn {vpnlist[options[menu_entry_index]]}")
