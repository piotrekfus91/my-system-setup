#!/bin/bash

if [ $# -lt 1 ] ; then
    echo "Usage: $0 server:port [-a]"
    exit 1
fi

server=$1
printAll=$2
protocolVersions="ssl2 ssl3 tls1 tls1_1 tls1_2"

for protocolVersion in $protocolVersions; do
    for cipher in $(openssl ciphers 'ALL:eNULL' | tr ':' ' '); do
        openssl s_client -connect $server -cipher $cipher -$protocolVersion < /dev/null > /dev/null 2>&1
        result=$?
        if [ "-a" == "$printAll" ] ; then
            if [ $result -eq 0 ] ; then
                echo -e "\033[32mOK\t$protocolVersion\t$cipher\033[0m"
            else
                echo -e "\033[31mFAIL\t$protocolVersion\t$cipher\033[0m"
            fi
        else
            if [ $result -eq 0 ] ; then
                echo -e "$protocolVersion\t$cipher"
            fi
        fi
    done
done

rm -f tags
