#!/bin/bash
HMD=$PWD
WGET=`which wget`
URL='https://services.arcgis.com/pGfbNJoYypmNq86F/arcgis/rest/services/COVID19_Public_Health_Status_by_County/FeatureServer/0/query?'

printf ' Current Dir (Parent): %s\n' $PWD
printf ' --Process Begin-- \n'
while read state_name
do
	#-- Check the directory whether it is existed.
	#-- If existed, move to work directory. If not, create one. 
	CWD="${HMD}/${state_name}"
	if [ ! -d "${CWD}" ]; then 
		mkdir "${CWD}"
	fi
	cd "${CWD}"
	###-- printf
	printf '    Current Dir         : %s\n' "$PWD"

	#-- Find the last update file ${lastfid}
	#-- Give name of the download data ${outfile}
	lastfid='Ameri'`ls -ltr AmericanRedCross.*|tail -1|awk -F 'Ameri' '{print $NF}'`
	outfile=`printf 'AmericanRedCross.%s.' "${state_name}"`
	outfile=${outfile}`date +%m-%d-%Y_%H:%M:%S`
	###-- printf
	printf '    --- last update file & given file name ---\n'

	#-- Construct the download URL ${query}
	query=`printf "where=state_name='%s'" "${state_name}"`
	query=${URL}${query}'&outFields=*&ReturnGeometry=false&f=pgeojson'
	###-- printf
	printf '    --- Construct the download URL ---\n'
	printf '        URL: %s\n' "${query}"

   ${WGET} -q -O "${outfile}" "${query}"

	#-- Check file status
	if cmp -s "$lastfid" "$outfile"; then 
	   printf '        Files are the same. Keep the oldest one.\n' "${outfile}"
	   rm -rf "${outfile}"
	else
		printf '        Last Update : %s\n' "${lastfid}"
		printf '        New Download: %s\n' "${outfile}"
	   printf '        Files are not the same. Record updates.\n'
	fi

	#-- Back to Home Directory
	cd $HMD
	###-- printf
	printf '        Current Dir (Parent): %s\n\n\n' $PWD

done < alphabetical_list_of_states.sh

printf ' --Process Done -- \n'
