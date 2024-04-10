FROM ubuntu:20.04
RUN apt update && apt install -y vim iproute2 iputils-ping tcpdump iptables dnsutils curl apache2-utils cron
COPY sleep.sh /root/sleep.sh

COPY crontab /etc/cron.d/crontab
RUN chmod 0644 /etc/cron.d/crontab
RUN crontab /etc/cron.d/crontab
RUN touch /var/log/cron.log
