#!/bin/sh
n=1

for x in `cat /proc/cmdline`
do
    case $x in
        foreman.ip=*)
            server="${x//foreman.ip=}"
        ;;
        foreman.server=*)
            server="${x//foreman.server=}"
        ;;
    esac
done

echo "Testing ping to $server to see if network is up..."

until ping -w 1 -c 1 "$server" &>/dev/null ;do
    sleep 1
    n=$(( n+1 ))
    [ $n -eq 180 ] && break
done

