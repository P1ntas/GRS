#!/bin/sh
#
# Event handler script for restarting the web server on the local machine
#
# Note: This script will only restart the web server if the service is
#       retried 3 times (in a "soft" state) or if the web service somehow
#       manages to fall into a "hard" error state.
#
SERVICE=$1
STATE=$2
ATTEMPT=$3
echo "Event handler triggered for $SERVICE in state $STATE attempt $ATTEMPT"

# What state is the HTTP service in?
case "$1" in
OK)
	# The service just came back up, so don't do anything...
	;;
WARNING)
	# We don't really care about warning states, since the service is probably still running...
	;;
UNKNOWN)
	# We don't know what might be causing an unknown error, so don't do anything...
	;;
CRITICAL)
	# echo "hellooo" >> ~/log.txt
	# Aha!  The HTTP service appears to have a problem - perhaps we should restart the server...
	# Is this a "soft" or a "hard" state?
	case "$2" in

	# We're in a "soft" state, meaning that Nagios is in the middle of retrying the
	# check before it turns into a "hard" state and contacts get notified...
	SOFT)

		# What check attempt are we on?  We don't want to restart the web server on the first
		# check, because it may just be a fluke!
		case "$3" in

		# Wait until the check has been tried 3 times before restarting the web server.
		# If the check fails on the 4th time (after we restart the web server), the state
		# type will turn to "hard" and contacts will be notified of the problem.
		# Hopefully this will restart the web server successfully, so the 4th check will
		# result in a "soft" recovery.  If that happens no one gets notified because we
		# fixed the problem!
		3)
			echo -n "Restarting webserver service (3rd soft critical state)..."
            python3 /opt/nagios/resolution_scripts/restart_container.py proj-node_web_server-1 
			/usr/bin/printf "%b" "***** Nagios *****\n\nNotification Type: Auto restart\nHost: node web server\nAddress: 10.0.2.101\nInfo: Container restarted after $ATTEMPT on state $STATE \n\nDate/Time: $(date)$\n" | /usr/bin/mail -s "** Host Alert: Node web server RESTART **" gestaoredesesistemas@gmail.com
			;;
			esac
		;;

	# The HTTP service somehow managed to turn into a hard error without getting fixed.
	# It should have been restarted by the code above, but for some reason it didn't.
	# Let's give it one last try, shall we?  
	# Note: Contacts have already been notified of a problem with the service at this
	# point (unless you disabled notifications for this service)
	HARD)
		echo -n "Restarting webserver service..." >> /tmp/event_handler_test.log
        python3 /opt/nagios/resolution_scripts/restart_container.py proj-node_web_server-1
		/usr/bin/printf "%b" "***** Nagios *****\n\nNotification Type: Auto restart\nHost: node web server\nAddress: 10.0.2.101\nInfo: Container restarted after $ATTEMPT on state $STATE \n\nDate/Time: $(date)$\n" | /usr/bin/mail -s "** Host Alert: Node web server RESTART **" gestaoredesesistemas@gmail.com
		;;
	esac
	;;
esac
exit 0