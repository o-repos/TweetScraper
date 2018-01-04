#!/bin/bash
source scrapy/bin/activate
echo -e "PLEASE INPUT KEYWORD, WHAT YOU WANT TO SEARCH\n------------------------------------------"
read -p "please input your keyword
(more than one keyword, use ',' to split: Feinstaub,Luftverschmutzung): " keyword
echo keyword: $keyword
echo -e "\nPLEASE INPUT TAG, WHAT YOU WANT TO SEARCH\n------------------------------------------"
read -p "When you want seach by tag, please input your tag
(more than one keyword, use ',' to split: Feinstaub,Luftverschmutzung,
search by tag must start with '#', #Feinstaub,#Luftverschmutzung.
If not start with '#', it will search by normally keyword): " tag
echo tag: $tag

if [[ "${keyword}" = ""  ]]; then
    echo "keyword is empty!!!"
    keyword=-1
else
    param=${keyword}
fi

if [[ "${tag}" = ""  ]]; then
    echo "tag is empty!!!"
    tag=-1
    if [[ "$keyword" = "-1" ]]; then
		param=-1
	fi
else
	if [[ "$keyword" = "-1" ]]; then
		echo "not have keyword"
		param="${tag}"
	else
		param="${param},${tag}"
	fi
fi

if [[ "${param}" = "-1" ]]; then
	echo "not have any keyword and tag"
else
	echo scrapy crawl TweetScraper -a queries=${param}
	scrapy crawl TweetScraper -a queries=${param}
fi
