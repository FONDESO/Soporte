![Encabezado](https://raw.githubusercontent.com/FONDESO/IdentidadGrafica/main/PNG/encabezado75.png)

Windows 11 Clean Setup
======================

## PowerShell

Uninstall Built-In Apps:
```powershell
Get-AppxPackage -AllUsers | Remove-AppPackage
```

Restore Microsoft Store:
```powershell
Get-AppXPackage *WindowsStore* -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
```
Restore Windows Terminal:
```powershell
Get-AppXPackage *WindowsTerminal* -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
```
### Install OpenSSH using PowerShell
To install OpenSSH using PowerShell, run PowerShell as an Administrator. To make sure that OpenSSH is available, run the following cmdlet:
```powershell
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
```
This should return the following output if neither are already installed:

```powershell
Name  : OpenSSH.Client~~~~0.0.1.0
State : NotPresent

Name  : OpenSSH.Server~~~~0.0.1.0
State : NotPresent
```
Then, install the server or client components as needed:
```powershell
# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```
Both of these should return the following output:
```powershell
Path          :
Online        : True
RestartNeeded : False
```
### Start and configure OpenSSH Server
To start and configure OpenSSH Server for initial use, open PowerShell as an administrator, then run the following commands to start the `sshd service`:
```powershell
# Start the sshd service
Start-Service sshd

# OPTIONAL but recommended:
Set-Service -Name sshd -StartupType 'Automatic'

# Confirm the Firewall rule is configured. It should be created automatically by setup. Run the following to verify
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}
```
### Connect to OpenSSH Server
Once installed, you can connect to OpenSSH Server from a Windows 10 or Windows Server 2019 device with the OpenSSH client installed using PowerShell as follows. Be sure to run PowerShell as an administrator:
```powershell
ssh username@servername
```
Once connected, you get a message similar to the following:
```powershell
The authenticity of host 'servername (10.00.00.001)' can't be established.
ECDSA key fingerprint is SHA256:(<a large string>).
Are you sure you want to continue connecting (yes/no)?
```
Selecting yes adds that server to the list of known SSH hosts on your Windows client.

You are prompted for the password at this point. As a security precaution, your password will not be displayed as you type.

Once connected, you will see the Windows command shell prompt:
```powershell
domain\username@SERVERNAME C:\Users\username>
```
### Install WSL
You can now install everything you need to run Windows Subsystem for Linux (WSL) by entering this command in an administrator PowerShell or Windows Command Prompt and then restarting your machine:
```powershell
wsl --install
```
This command will enable the required optional components, download the latest Linux kernel, set WSL 2 as your default, and install a Linux distribution for you (*Ubuntu by default, see below to change this*).

The first time you launch a newly installed Linux distribution, a console window will open and you'll be asked to wait for files to de-compress and be stored on your machine. All future launches should take less than a second.

#### Change the default Linux distribution installed
By default, the installed Linux distribution will be Ubuntu. This can be changed using the -d flag.

- To change the distribution installed, enter: `wsl --install -d <Distribution Name>`. Replace `<Distribution Name>` with the name of the distribution you would like to install.
- To see a list of available Linux distributions available for download through the online store, enter: `wsl --list --online` or `wsl -l -o`.
- To install additional Linux distributions after the initial install, you may also use the command: `wsl --install -d <Distribution Name>`.

If you want to install additional distributions from inside a Linux/Bash command line (rather than from PowerShell or Command Prompt), you must use .exe in the command: `wsl.exe --install -d <Distribution Name>` or to list available distributions: `wsl.exe -l -o`.
    
## Windows Management Instrumentation Command-Line (wmic)

List All Installed Programs, Version & Path:
```
wmic product get name
```
Alternatively, you can even find all possible information in one command:
```
wmic product get name, version, installlocation
```
Use `wmic product name` command to remove the program you want:
```cmd
wmic product where name ="<PROGRAM NAME HERE>" call uninstall /nointeractive
```
If you do not use the `/nointeractive` switch, `wmic` will prompt the user to confirm the uninstall, which likely defeats the purpose of scripting the uninstall

Also note that wild cards can be used with WMIC but the command is slightly different:
```cmd
wmic product where "name like '<PROGRAM NAME HERE>%%'" call uninstall
```
You also may want to clean up the installation folder, if it still exists using:
```cmd
rd /s /q C:\Program Files\<PROGRAM FOLDER NAME HERE>
```
