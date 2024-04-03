#!bin/bash

ip r d default via 172.16.123.140
ip r a default via 172.16.123.139
/usr/sbind/named -g -c /etc/bind/named.conf -u bind