# Windows preparation for dual-boot with Linux

> **All commands must be run in an Administrator PowerShell.**

## Disable hibernation
Hibernation locks the NTFS partition, which can cause corruption when accessed from Linux. It also disables Fast Startup, which depends on it.
```powershell
powercfg /hibernate off
```

## Fix clock desync with Linux
By default Windows stores local time in RTC, while Linux stores UTC. This causes a time offset when switching between systems. Make Windows use UTC to match Linux behavior.
```powershell
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /t REG_DWORD /d 1 /f
```
