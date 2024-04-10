FROM nginx
RUN apt update && apt install -y vim iproute2 iputils-ping tcpdump iptables dnsutils curl python3
COPY start.sh /root/start.sh
CMD /root/start.sh
