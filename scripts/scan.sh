#!/bin/bash
# Enable job control.
set -m
host=$1
# Check if ping returns 0 or truthy.
# Redirect stdout and stderr to /dev/null.
if ping -c 1 $host &> /dev/null
then
        # Create a new nmap directory.
        mkdir ./nmap
        # Scan both all and the top 1000 ports on the host in parallel.
        # Save the output in all formats including as files inside our newly created nmap directory. 
        nmap -A $host -p- -T4 -v -oA ./nmap/all_ports & nmap -A $host -v -oA ./nmap/top_ports && fg
else
        echo "error"
fi
