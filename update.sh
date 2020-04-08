#!/bin/bash

source /Users/cyhsu/miniconda3/bin/activate cyhsu
PWD='/Users/cyhsu/dev/virus'
#   '/Users/cyhsu/dev/virus/api/icu'

#-- UPDATES

	#-- Cases.
	## Texas DSHS ##

	#-- CDC

	#-- John Hopkins

	#-- WHO


	#-- Hospital Energy, i.e. icu beds, use rate etc..
	CWD="${PWD}/api/icu"
	cd ${CWD} 
	outlog='icu.'`date +%m-%d-%Y_%H:%M:%S`
	echo ${PWD}/${outlog} 
	ipython ./hospital.py > ${PWD}/${outlog}
	##-- check file size 
	fsize=`wc -c ${PWD}/${outlog} | awk '{print $1}'`
	flimt=28

	if (( $(bc <<<"$fsize <= $flimt") )); then 
	   rm -rf ${PWD}/${outlog} 
	fi

	
	#-- County Emergency Status.
##https://arc-nhq-gis.maps.arcgis.com/apps/webappviewer/index.html?id=ebe29d4c1fca4ac292d00dbd54ed37e9&fbclid=IwAR1fimiv8LzHpyVSaLdK5crSdOzVpJlnakDHNIWQbWgAFujkTfMAf4H_GMA

#-- GitHub
GIT=`which git`
github="Update on  `date +%m-%d-%Y_%H:%M:%S`"
echo ${github}
${GIT} add --all 
###${GIT} status
${GIT} commit -m "${github}"
###${GIT} push 


echo " "
