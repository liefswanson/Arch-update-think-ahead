#!/bin/bash

archNews="https://www.archlinux.org/news/"
#for testing so I don't DDOS archlinux.org by accident
localNews="news.html"

confDir=$HOME"/.anh/"
tempCache=$confDir"tempCache.html"

if [ ! -d $confDir ]
then
	mkdir $confDir
fi

curl $archNews > $tempCache
#cat $localNews > $tempCache


URL=$archNews"$(cat $tempCache | grep href=\"/news/ | head -1 | cut -d\" -f 4 | cut -c 7-)"
title="$(cat $tempCache | grep 'title=\"View: ' | head -1 | cut -d\" -f 2 | cut -c 7-)"
date="$(cat $tempCache | grep [2-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] | head -1 | cut -c 21-30 )"

#temp cache no longer needed.

# echo $URL
# echo $title
# echo $date

if [ -f $confDir"/url" -a -f $confDir"/title" -a -f $confDir"/date" ]
then
	staleURL="$(cat $confDir/url)"
	staleTitle="$(cat $confDir/title)"
	staleDate="$(cat $confDir/date)"

	# echo $staleURL
	# echo $staleTitle
	# echo $staleDate
fi

if [ ! "$URL" == "$staleURL" -a "$title" == "$staleTitle" -a "$date" == "$staleDate" -o ! -f $confDir"/url" -o ! -f $confDir"/title" -o ! -f $confDir"/date" ]
then
	echo "There is unread news on $archNews"
	echo 
	echo "$title"
	echo "Posted: $date"
	echo 

	read -p "Do you wish to open the most recent news in your default browser? [y/N/a]" browse
	case $browse in
		[Yy]* ) xdg-open $URL;;
		[Aa]* ) rm $tempCache; exit;;
	esac

	

	echo $URL > $confDir'/url'
	echo $title > $confDir'/title'
	echo $date > $confDir'/date'
else
	echo "There is no unread news on $archNews"
fi

rm $tempCache

if [ -f "/usr/bin/pacman" ]
then
	sudo pacman -Syu
else
	echo "You don't have pacman on your system. If you are on Arch, you should panic."
fi
