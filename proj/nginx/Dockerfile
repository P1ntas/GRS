FROM nginx
RUN apt update && apt install -y nano iproute2 iputils-ping tcpdump iptables dnsutils curl python3 wget gcc make openssl libssl-dev xinetd
COPY start.sh /root/start.sh
RUN mkdir ~/downloads && wget -P ~/downloads http://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz && tar xzf ~/downloads/nagios-plugins-2.2.1.tar.gz -C ~/downloads && cd ~/downloads/nagios-plugins-2.2.1 && ./configure --with-need-dh=no && make && make install && useradd nagios && usermod -a -G nagios nagios && chown nagios.nagios /usr/local/nagios && chown -R nagios.nagios /usr/local/nagios/libexec && wget https://github.com/NagiosEnterprises/nrpe/releases/download/nrpe-3.2.1/nrpe-3.2.1.tar.gz && tar xzf nrpe-3.2.1.tar.gz && cd nrpe-3.2.1 && ./configure --with-need-dh=no && make all && make install-groups-users && make install && make install-config && make install-inetd
COPY nrpe /etc/xinetd.d/nrpe
COPY nrpe.cfg /usr/local/nagios/etc/nrpe.cfg
RUN service xinetd restart
CMD /root/start.sh

# service xinetd restart - Run on startup
