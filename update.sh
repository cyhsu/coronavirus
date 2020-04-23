#!/bin/bash
#-- Loading Personnel Environment
source ~/.bashrc
#-- Loading ipython through conda
source /Users/cyhsu/miniconda3/bin/activate cyhsu
HMD='/Users/cyhsu/dev/virus'
GIT=`which git`

#-- UPDATES
	# Texas DSHS
	CWD="${HMD}/dataset/cases/Texas"
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


	#-- John Hopkins
	CWD="${HMD}/dataset/JohnsHopkins"
	cd ${CWD} 
	./johnshopkins.sh

	#-- WHO & CSSE
	CWD="${HMD}/dataset/CSSEGISandData"
	cd ${CWD}
	${GIT} clone "https://github.com/CSSEGISandData/COVID-19.git"
	mv COVID-19/* .
	rm -rf COVID-19
	
	#-- CDC


	#-- Hospital Energy, i.e. icu beds, use rate etc..
	CWD="${HMD}/dataset/icu"
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
	CWD="${HMD}/dataset/PublicHealthEmergencyStatus"
	cd ${CWD} 
	./PulicHealthEmergency.sh

#-- GitHub
github="Update on  `date +%m-%d-%Y_%H:%M:%S`"
${GIT} add --all 
###${GIT} status
${GIT} commit -m "${github}"
${GIT} push -u origin master


echo " "
