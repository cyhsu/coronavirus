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
		echo ${PWD}/${outlog} 
	   rm -rf ${PWD}/${outlog} 
	fi

	

#-- GitHub
GIT=`which git`
github="Update on  "`date +%m-%d-%Y_%H:%M:%S`
${GIT} add .
${GIT} comment -m $github
${GIT} push https://github.com/cyhsu/coronavirus.git master


echo " "
