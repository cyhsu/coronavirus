#!/bin/bash

source /Users/cyhsu/miniconda3/bin/activate cyhsu
HMD='/Users/cyhsu/dev/virus'

#-- UPDATES
	# Texas DSHS
	CWD="${HMD}/api/cases/Texas"
	cd ${CWD} 
	outlog='Texas.DSHS.'`date +%m-%d-%Y_%H:%M:%S`
	echo ${CWD}/${outlog} 
	ipython ./texas.py > ${CWD}/${outlog}
	##-- check file size 
	fsize=`wc -c ${CWD}/${outlog} | awk '{print $1}'`
	flimt=32

	if (( $(bc <<<"$fsize <= $flimt") )); then 
	   rm -rf ${CWD}/${outlog} 
	fi

	#-- CDC

	#-- John Hopkins

	#-- WHO


	#-- Hospital Energy, i.e. icu beds, use rate etc..
	CWD="${HMD}/api/icu"
	cd ${CWD} 
	outlog='icu.'`date +%m-%d-%Y_%H:%M:%S`
	echo ${CWD}/${outlog} 
	ipython ./hospital.py > ${CWD}/${outlog}
	##-- check file size 
	fsize=`wc -c ${CWD}/${outlog} | awk '{print $1}'`
	flimt=28

	if (( $(bc <<<"$fsize <= $flimt") )); then 
	   rm -rf ${CWD}/${outlog} 
	fi

	
	#-- County Emergency Status.
##https://arc-nhq-gis.maps.arcgis.com/apps/webappviewer/index.html?id=ebe29d4c1fca4ac292d00dbd54ed37e9&fbclid=IwAR1fimiv8LzHpyVSaLdK5crSdOzVpJlnakDHNIWQbWgAFujkTfMAf4H_GMA

#-- GitHub
GIT=`which git`
github="Update on  `date +%m-%d-%Y_%H:%M:%S`"
${GIT} add --all 
###${GIT} status
${GIT} commit -m "${github}"
${GIT} push 


echo " "
