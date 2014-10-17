#!/bin/bash

archNews="https://archlinux.org/news/"
localNews="news.html"

#grabs the relative link to the most recent news post then completes it into a complete url
#firsturl=archNews"$(curl $archNews | grep href=\"/news/ | head -1 | cut -c 49- | rev | cut -c 2- | rev)"
postURL=$archNews"$(cat $localNews | grep href=\"/news/ | head -1 | cut -c 49- | rev | cut -c 2- | rev)"
localfirsturl="latest.html"

echo $postURL

postTitle="$(cat $localNews | grep title=\"View:.*\"\> | head -1 | cut -d\" -f 2 | cut -c 7-)"

echo $postTitle

#grabs the date of the most recent news post
#dateofurl="$(curl $archNews | grep [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] | head -1 | cut -c 21-30 )"
dateOfPost="$(cat $localNews | grep [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] | head -1 | cut -c 21-30 )"

echo $dateOfPost

read -p "Do you wish to open the most recent news in your default browser? [y/N/a]" yn
case $yn in
	[Yy]* ) xdg-open $firstURL;;
	[Aa]* ) exit;;
esac

if [ -f "/usr/bin/yaourt" ];
then
	yaourt -Syu
fi
