#!/bin/bash
# Script to swiftly toggle back and forth between the Apache and Nginx webservers.

#grab current status of services
nraw=$(service nginx status)
araw=$(service apache2 status)

#parse nginx status
if [[ "$nraw" == *"is running" ]]
then
	ns=1
elif [[ "$nraw" == *"is not running" ]]
then
	ns=0
else
	echo "Could not determine nginx status. Exiting."
fi

#parse apache status
if [[ "$araw" == *"is running" ]]
then
        as=1
elif [[ "$araw" == *"is not running" ]]
then
        as=0
else
        echo "Could not determine apache2 status. Exiting."
fi

if [ $as == 1 ] && [ $ns == 0 ]
	then
	#If apache running switch to nginx.
	echo "Stopping Apache and Starting Nginx."
	sudo service apache2 stop >/dev/null
	sudo service nginx start >/dev/null
	echo "Done."
elif [ $as == 0 ] && [ $ns == 1 ]
	then
	#If nginx running, switch to apache.
	echo "Stopping Nginx and Starting Apache."
	sudo service nginx stop >/dev/null
	sudo service apache2 start > /dev/null
	echo "Done."
elif [ $as == 0 ] && [ $ns == 0 ]
	then
	#if neither running, cancel.
	echo "Sorry Chief, but neither Apache nor Nginx are running."
elif [ $as == 1 ] && [ $ns == 1 ]
	then
	#if both running, cancel.
	echo "Whoa, both Apache and Nginx are running!? You should, like, fix that."
else
	#??? how would this even happen?
	echo "... Something has gone horribly wrong... I'm frightened..."
fi
