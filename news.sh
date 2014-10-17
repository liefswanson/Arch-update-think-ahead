#!/bin/bash

archNews="https://archlinux.org/news/"
#for testing so I don't DDOS archlinux.org by accident
localNews="news.html"

confDir=$HOME"/.anh/"
tempCache=$confDir"tempCache.html"
staleCache=$confDir"cache.html"

#curl $archNews > $tempCache
cat $localNews > $tempCache


#grabs the relative link to the most recent news post then completes it into a complete url
URL=$archNews"$(cat $tempCache | grep href=\"/news/ | head -1 | cut -d\" -f 4)"

echo $URL

title="$(cat $tempCache | grep 'title=\"View: ' | head -1 | cut -d\" -f 2 | cut -c 7-)"

echo $title

#grabs the date of the most recent news post
date="$(cat $tempCache | grep [2-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] | head -1 | cut -c 21-30 )"

echo $date

staleURL=$archNews"$(cat $staleCache | grep href=\"/news/ | head -1 | cut -d\" -f 4)" 
staleTitle="$(cat $staleCache | grep 'title=\"View: ' | head -1 | cut -d\" -f 2 | cut -c 7-)"
staleDate="$(cat $staleCache | grep [2-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] | head -1 | cut -c 21-30 )"

echo $staleURL
echo $staleTitle
echo $staleDate

if [ ! "$URL" == "$staleURL" -a "$title" == "$staleTitle" -a "$date" == "$staleDate" ]
then

	
	
	read -p "Do you wish to open the most recent news in your default browser? [y/N/a]" browse
	case $browse in
		[Yy]* ) xdg-open $postURL;;
		[Aa]* ) exit;;
	esac

	sleep 10

	if [ -f "/usr/bin/pacman" ]
	then
		yaourt -Syu
	fi
else
	echo "No new news."
fi

