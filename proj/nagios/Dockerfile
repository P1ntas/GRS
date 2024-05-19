FROM jasonrivers/nagios
RUN apt update && apt install -y nagios-nrpe-plugin vim iproute2 iputils-ping tcpdump iptables dnsutils curl
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
RUN rm /etc/postfix/main.cf
COPY main.cf /etc/postfix/main.cf