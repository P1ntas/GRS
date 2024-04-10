#!/bin/bash
cron && tail -f /var/log/cron.log &
while true ; do /bin/sleep 5; done