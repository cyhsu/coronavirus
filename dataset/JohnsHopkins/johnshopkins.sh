#!/bin/bash
WGET=`which wget`


lastfid=`ls -ltr Johns*|tail -1|awk '{print $NF}'`
outfile='Johns_Hopkins.'`date +%m-%d-%Y_%H:%M:%S`
url='https://opendata.arcgis.com/datasets/628578697fb24d8ea4c32fa0c5ae1843_0.geojson'
${WGET} -q -O ${outfile} ${url} 

if cmp -s "$lastfid" "$outfile"; then 
	printf 'File "%s" are the same with the older one. Keep the oldest one.\n' $outfile
	rm -rf $outfile
else
	echo $lastfid $outfile
	printf 'Files are not the same. Record updates.\n'
fi
