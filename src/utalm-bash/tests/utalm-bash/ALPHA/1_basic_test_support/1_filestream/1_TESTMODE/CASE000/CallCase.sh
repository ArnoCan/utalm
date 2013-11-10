#!/bin/bash
## \cond
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENSE:      Apache-2.0 + CCL-BY-SA-3.0
#
#
########################################################################
#
#   Copyright [2007,2008,2010,2013] Arno-Can Uestuensoez
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
########################################################################
#
# refer to source-package for unstripped sources
#
#HEADEND################################################################
#
##
## \endcond
##
## @file
## @brief First test of internal interface for persistence  of reference data 
##
## \attention Due to required tests of \ref TESTMODE itself, this case breaks
## consequently control flow.
##
## Tests the storage and read of arbitrary data to be used in later
## calls as constant reference for assert-call variants.  
##
## For usage in test cases the macro call should be prefered:
##	assertRefDataWithExit $LINENO $BASH_SOURCE ID000 "$PATH_REF"
##
## \cond
##
#
#Execution anchor
MYCALLPATHNAME=$0
MYCALLNAME=`basename $MYCALLPATHNAME`
MYCALLNAME=${MYCALLNAME%.sh}
MYCALLPATH=`dirname $MYCALLPATHNAME`g

MYBOOTSTRAPFILE=$(getPathToBootstrapDir.sh)/bootstrap-03_03_001.sh
. ${MYBOOTSTRAPFILE}
if [ $? -ne 0 ];then
	echo "ERROR:Missing bootstrap file:configuration: ${MYBOOTSTRAPFILE}">&2
	exit 1
fi
setUTALMbash 1 $*
#
###
#
. $(getPathToLib.sh libutalmfileobjects.sh)
PATH0=$(setUpperTreeSearchPath . tests)
TROOT=$(getUpperTreePathMatch $PWD tests 0)
. $(getPathToLib.sh libutalmrefpersistency.sh)
refDataInit $TROOT 
dataX="${PATH0//$TROOT\//}"

refDataStore ID000 $dataX  

export dataX
{
	(
		TESTMODE=$T_CREATEREF  assertRefDataWithExit $LINENO $BASH_SOURCE ID001 "$dataX";
	);
	(
		TESTMODE=$T_COMPAREREF assertRefDataWithExit $LINENO $BASH_SOURCE ID001 "$dataX";
	);
	refx=$(TESTMODE=$((T_COMPAREREF|T_PRINTASSERT)) assertRefDataWithExit $LINENO $BASH_SOURCE ID001 "$dataX" 2>&1|sed '/utalm_exit:0/d')
	assertWithExit $LINENO $BASH_SOURCE "[[ \"$refx\" == \"[[ '$dataX' == '$dataX' ]]\" ]]";
} 2>&1 |countErrors flat=1 filter=1 sums=1 intermediate=0


## \endcond

