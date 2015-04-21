#!/bin/bash
# Script to swiftly toggle back and forth between the Apache and Nginx webserver.

nraw=$(service nginx status)
araw=$(service apache2 status)

#echo "$nraw"
#echo "$araw"

if [[ "$nraw" == *"is running" ]]
then
	ns=1
elif [[ "$nraw" == *"is not running" ]]
then
	ns=0
else
	echo "Could not determine nginx status. Exiting."
fi

if [[ "$araw" == *"is running" ]]
then
        as=1
elif [[ "$araw" == *"is not running" ]]
then
        as=0
else
        echo "Could not determine apache2 status. Exiting."
fi

#echo $ns
#echo $as

if [ $as == 1 ] && [ $ns == 0 ]
	then
	echo "Stopping Apache and Starting Nginx."
	sudo service apache2 stop >/dev/null
	sudo service nginx start >/dev/null
	echo "Done."
elif [ $as == 0 ] && [ $ns == 1 ]
	then
	echo "Stopping Nginx and Starting Apache."
	sudo service nginx stop >/dev/null
	sudo service apache2 start > /dev/null
	echo "Done."
elif [ $as == 0 ] && [ $ns == 0 ]
	then
	echo "Sorry Chief, but neither Apache nor Nginx are running."
elif [ $as == 1 ] && [ $ns == 1 ]
	then
	echo "Whoa, both Apache and Nginx are running!? You should, like, fix that."
else
	echo "... Something has gone horribly wrong dave..."
fi
