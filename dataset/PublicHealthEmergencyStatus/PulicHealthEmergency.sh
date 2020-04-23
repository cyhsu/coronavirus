#!/bin/bash
#---

log='AmericanRedCross.log.'`date -u +"%Y-%m-%d_%H:%M:%S"`
HWD=$PWD
CWD=${HWD}/states
cd "${CWD}"
./states.sh > ../"${log}"
cd "${HWD}"

#####--- Execute updates in ./states
####
####lastfid=`ls -ltr American*|tail -1|awk '{print $NF}'`
####outfile='AmericanRedCross.'`date +%m-%d-%Y_%H:%M:%S`
####
##### example
##### https://services.arcgis.com/pGfbNJoYypmNq86F/arcgis/rest/services/COVID19_Public_Health_Status_by_County/FeatureServer/0/query?where=state_name=%27Texas%27&outFields=*&ReturnGeometry=false&f=pgeojson
####
####url='https://services.arcgis.com/pGfbNJoYypmNq86F/arcgis/rest/services/COVID19_Public_Health_Status_by_County/FeatureServer/0/query?'
####query=`printf 'where=state_name=%s' $state_name`
####query=${query}'&outFields=*&ReturnGeometry=false&f=pgeojson'
####
####wget -q -O ${outfile} ${url} 
####
####if cmp -s "$lastfid" "$outfile"; then 
####	printf 'File "%s" are the same with the older one. Keep the oldest one.\n' $outfile
####	rm -rf $outfile
####else
####	echo $lastfid $outfile
####	printf 'Files are not the same. Record updates.\n'
####fi
