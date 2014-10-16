#!/bin/bash

archnews="https://archlinux.org/news/"
localnews="news.html"

#grabs the relative link to the most recent news post then completes it into a complete url
#firsturl=archnews"$(curl $archnews | grep href=\"/news/ | head -1 | cut -c 49- | rev | cut -c 2- | rev)"
firsturl=$archnews"$(cat $localnews | grep href=\"/news/ | head -1 | cut -c 49- | rev | cut -c 2- | rev)"
localfirsturl="latest.html"

echo $firsturl

#grabs the date of the most recent news post
#dateofurl="$(curl $archnews | grep [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] | head -1 | cut -c 21-30 )"
dateofurl="$(cat $localnews | grep [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] | head -1 | cut -c 21-30 )"

echo $dateofurl

read -p "Do you wish to open the most recent news in your default browser? [y/N]" yn
case $yn in
	[Yy]* ) xdg-open $firsturl;
esac

if [ -f "/usr/bin/yaourt" ];
then
	yaourt -Syu
fi
