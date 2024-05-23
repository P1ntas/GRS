FROM jasonrivers/nagios
RUN apt update && apt install -y nagios-nrpe-plugin vim iproute2 iputils-ping tcpdump iptables dnsutils curl xinetd
#Install docker sdk for python
RUN pip3 install docker

COPY sasl_passwd /etc/postfix/sasl_passwd
COPY sasl_passwd.db /etc/postfix/sasl_passwd.db

#Copy eventhandlers and give permissions
COPY ./eventhandlers /opt/nagios/libexec/eventhandlers
RUN chown -R root:root /opt/nagios/libexec/eventhandlers

#Copy resolution scripts and give permissions
COPY ./resolution_scripts /opt/nagios/resolution_scripts
RUN chmod +x /opt/nagios/libexec/eventhandlers/*

#Add permissions to nagios user to use the docker socket
RUN usermod -aG runit-log nagios
RUN mkdir ~/downloads && wget -P ~/downloads https://github.com/NagiosEnterprises/nrpe/releases/download/nrpe-3.2.1/nrpe-3.2.1.tar.gz && tar xzf ~/downloads/nrpe-3.2.1.tar.gz -C ~/downloads && cd ~/downloads/nrpe-3.2.1 && ./configure --with-need-dh=no && make check_nrpe && make install-plugin
RUN rm /etc/postfix/main.cf
COPY main.cf /etc/postfix/main.cf