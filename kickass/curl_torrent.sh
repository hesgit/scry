#!/bin/bash
# Downloads .torrent files from kickass.com links
# following redirects and getting the actual torrent
# filename, then runs transmission torrent client

AGENT="'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20070802 SeaMonkey/1.1.4)'"

function usage(){
	echo "Usage: $0 [Kickass Torrent URL]"
		exit 1
}

if [ ! -n "$1" ]
then
    usage
fi

mkdir -p torrents
name=`echo $1 | sed 's/.*kickass.to.//'`".torrent"
echo $name
curl --globoff --compressed -A '$AGENT' -L --post302 $1 > 'torrents/'$name'.tmp'
cd torrents && mv $name'.tmp' $name
transmission-gtk -m $name & 



