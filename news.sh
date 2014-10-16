#!/bin/bash
#mainpage=curl https://archlinux.org/news/
#mainpage=$(cat ./news.html)

archnews="https://archlinux.org/news/"

#grabs the relative link to the most recent news post then completes it into a complete url
firsturl=$archnews"$(cat ./news.html | grep href=\"/news/ | head -1 | cut -c 49- | rev | cut -c 2- | rev)"

echo $firsturl

#grabs the date of the most recent news post
dateofnews="$(cat ./news.html | grep [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] | head -1 | cut -c 21-30 )"

echo $dateofnews
