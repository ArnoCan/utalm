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
#$Header$
#
##
## \endcond
## @file
## @brief HowTo set correct parameters
## 
## For additional description refer to \ref findParameterError. 
## \cond
##
#
#Execution anchor
MYCALLPATHNAME=$0
MYCALLNAME=`basename $MYCALLPATHNAME`
MYCALLNAME=${MYCALLNAME%.sh}
MYCALLPATH=`dirname $MYCALLPATHNAME`

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


function printSomeUTALM () {
	#
	printDBG $S_ALL 1 $LINENO $BASH_SOURCE "#"
	printDBG $S_ALL 1 $LINENO $BASH_SOURCE "######################################"
	printDBG $S_ALL 1 $LINENO $BASH_SOURCE "#"
	printDBG $S_ALL 1 $LINENO $BASH_SOURCE "DBG"
	printDBG $S_ALL 1 $LINENO $BASH_SOURCE "#"
	printDBG $S_ALL 1 $LINENO $BASH_SOURCE "DEMO-PARAMETER-ERROR:The next 'printDBG' may cause an error"
	printDBG $S_ALL 1 $LINENO $BASH_SOURCE "#"
	printDBG $S_ALL 1 a$LINENO $BASH_SOURCE "DEMO-PARAMETER-ERROR:Wrong #linenumber type"
	printDBG $S_ALL 1 $LINENO $BASH_SOURCE "#"
	printDBG $S_ALL 1 $LINENO $BASH_SOURCE "DEMO-PARAMETER-ERROR:This is the correct call"
	printDBG $S_ALL 1 $LINENO $BASH_SOURCE "######################################"
	printDBG $S_ALL 1 $LINENO $BASH_SOURCE "#"
	printDBG $S_ALL 1 $LINENO $BASH_SOURCE "DEMO-PARAMETER-ERROR:The next 'printDBG' may cause an error"
	printDBG $S_ALL 1 $LINENO $BASH_SOURCE "#"
	printDBG $S_ALL a1 $LINENO $BASH_SOURCE "DEMO-PARAMETER-ERROR:Wrong #linenumber type"
	printDBG $S_ALL 1 $LINENO $BASH_SOURCE "#"
	printDBG $S_ALL 1 $LINENO $BASH_SOURCE "DEMO-PARAMETER-ERROR:This is the correct call"
	printDBG $S_ALL 1 $LINENO $BASH_SOURCE "######################################"
	printDBG $S_ALL 1 $LINENO $BASH_SOURCE "#"
	echo>&2
	printINFO 1 $LINENO $BASH_SOURCE 0 "#"
	printINFO 1 $LINENO $BASH_SOURCE 1 "######################################"
	printINFO 1 $LINENO $BASH_SOURCE 2 "#"
	printINFO 1 $LINENO $BASH_SOURCE 3 "INFO"
	printINFO 1 $LINENO $BASH_SOURCE 4 "#"
	printINFO 1 $LINENO $BASH_SOURCE 5 "DEMO-PARAMETER-ERROR:The next 'printINFO' may cause an error"
	printINFO 1 $LINENO $BASH_SOURCE 6 "#"
	printINFO 1 $LINENO $BASH_SOURCE $missing "DEMO-PARAMETER-ERROR:Missing <code>"
	printINFO 1 $LINENO $BASH_SOURCE 8 "#"
	printINFO 1 $LINENO $BASH_SOURCE ${missing:-9} "DEMO-PARAMETER-ERROR:This is the correct call"
	printINFO 1 $LINENO $BASH_SOURCE 10 "######################################"
	printINFO 1 $LINENO $BASH_SOURCE 11 "#"
	printINFO 1 $LINENO $BASH_SOURCE 12 "DEMO-PARAMETER-ERROR:The next 'printINFO' may cause an error"
	printINFO 1 $LINENO $BASH_SOURCE 13 "#"
	printINFO 1 a$LINENO $BASH_SOURCE 14 "DEMO-PARAMETER-ERROR:Wrong #linenumber type"
	printINFO 1 $LINENO $BASH_SOURCE 15 "#"
	printINFO 1 $LINENO $BASH_SOURCE 16 "DEMO-PARAMETER-ERROR:This is the correct call"
	printINFO 1 $LINENO $BASH_SOURCE 17 "######################################"
	printINFO 1 $LINENO $BASH_SOURCE 18 "#"
	printINFO 1 $LINENO $BASH_SOURCE 19 "DEMO-PARAMETER-ERROR:The next 'printINFO' may cause an error"
	printINFO 1 $LINENO $BASH_SOURCE 20 "#"
	printINFO a1 $LINENO $BASH_SOURCE 21 "DEMO-PARAMETER-ERROR:Wrong #linenumber type"
	printINFO 1 $LINENO $BASH_SOURCE 22 "#"
	printINFO 1 $LINENO $BASH_SOURCE 23 "DEMO-PARAMETER-ERROR:This is the correct call"
	printINFO 1 $LINENO $BASH_SOURCE 24 "######################################"
	printINFO 1 $LINENO $BASH_SOURCE 25 "#"
	echo>&2
	printWNG 1 $LINENO $BASH_SOURCE 0 "#"
	printWNG 1 $LINENO $BASH_SOURCE 1 "######################################"
	printWNG 1 $LINENO $BASH_SOURCE 2 "#"
	printWNG 1 $LINENO $BASH_SOURCE 3 "WNG"
	printWNG 1 $LINENO $BASH_SOURCE 4 "#"
	printWNG 1 $LINENO $BASH_SOURCE 5 "DEMO-PARAMETER-ERROR:The next 'printWNG' may cause an error"
	printWNG 1 $LINENO $BASH_SOURCE 6 "#"
	printWNG 1 $LINENO $BASH_SOURCE $missing "DEMO-PARAMETER-ERROR:Missing <code>"
	printWNG 1 $LINENO $BASH_SOURCE 8 "#"
	printWNG 1 $LINENO $BASH_SOURCE ${missing:-9} "DEMO-PARAMETER-ERROR:This is the correct call"
	printWNG 1 $LINENO $BASH_SOURCE 10 "######################################"
	printWNG 1 $LINENO $BASH_SOURCE 11 "#"
	printWNG 1 $LINENO $BASH_SOURCE 12 "DEMO-PARAMETER-ERROR:The next 'printWNG' may cause an error"
	printWNG 1 $LINENO $BASH_SOURCE 13 "#"
	printWNG 1 a$LINENO $BASH_SOURCE 14 "DEMO-PARAMETER-ERROR:Wrong #linenumber type"
	printWNG 1 $LINENO $BASH_SOURCE 15 "#"
	printWNG 1 $LINENO $BASH_SOURCE 16 "DEMO-PARAMETER-ERROR:This is the correct call"
	printWNG 1 $LINENO $BASH_SOURCE 17 "######################################"
	printWNG 1 $LINENO $BASH_SOURCE 18 "#"
	printWNG 1 $LINENO $BASH_SOURCE 19 "DEMO-PARAMETER-ERROR:The next 'printWNG' may cause an error"
	printWNG 1 $LINENO $BASH_SOURCE 20 "#"
	printWNG a1 $LINENO $BASH_SOURCE 21 "DEMO-PARAMETER-ERROR:Wrong #linenumber type"
	printWNG 1 $LINENO $BASH_SOURCE 22 "#"
	printWNG 1 $LINENO $BASH_SOURCE 23 "DEMO-PARAMETER-ERROR:This is the correct call"
	printWNG 1 $LINENO $BASH_SOURCE 24 "######################################"
	printWNG 1 $LINENO $BASH_SOURCE 25 "#"
	echo>&2
	printERR  $LINENO $BASH_SOURCE 0 "#"
	printERR  $LINENO $BASH_SOURCE 1 "######################################"
	printERR  $LINENO $BASH_SOURCE 2 "#"
	printERR  $LINENO $BASH_SOURCE 3 "ERR"
	printERR  $LINENO $BASH_SOURCE 4 "#"
	printERR  $LINENO $BASH_SOURCE 5 "DEMO-PARAMETER-ERROR:The next 'printERR' may cause an error"
	printERR  $LINENO $BASH_SOURCE 6 "#"
	printERR  $LINENO $BASH_SOURCE $missing "DEMO-PARAMETER-ERROR:Missing <code>"
	printERR  $LINENO $BASH_SOURCE 8 "#"
	printERR  $LINENO $BASH_SOURCE ${missing:-9} "DEMO-PARAMETER-ERROR:This is the correct call"
	printERR  $LINENO $BASH_SOURCE 10 "######################################"
	printERR  $LINENO $BASH_SOURCE 11 "#"
	printERR  $LINENO $BASH_SOURCE 12 "DEMO-PARAMETER-ERROR:The next 'printERR' may cause an error"
	printERR  $LINENO $BASH_SOURCE 13 "#"
	printERR  a$LINENO $BASH_SOURCE 14 "DEMO-PARAMETER-ERROR:Wrong #linenumber type"
	printERR  $LINENO $BASH_SOURCE 15 "#"
	printERR  $LINENO $BASH_SOURCE 16 "DEMO-PARAMETER-ERROR:This is the correct call"
	printERR  $LINENO $BASH_SOURCE 24 "######################################"
	printERR  $LINENO $BASH_SOURCE 25 "#"

	
}

printSomeUTALM

echo "DBG=$DBG">&1
doDebug $S_ALL 0 $LINENO $BASH_SOURCE
if [ $? -eq 0 ];then
	echo "DODEBUG">&2
fi

printINFO 1 $LINENO $BASH_SOURCE 0 "#"
printINFO 1 $LINENO $BASH_SOURCE 1 "printFINALCALL shows required mask of shell key-characters"
printINFO 1 $LINENO $BASH_SOURCE 2 "printFINALCALL from a call-variable"
myCall="uname -a|awk '{print \$2\" \"\$3\" \"\$(NF-1)\" \"\$NF}'"
printFINALCALL RESULTDATA $LINENO $BASH_SOURCE "MyCall" $myCall 

printINFO 1 $LINENO $BASH_SOURCE 4 "printFINALCALL from appended call string"
printFINALCALL RESULTDATA $LINENO $BASH_SOURCE "MyCall" uname -a\|awk '{print $2" "$3" "$(NF-1)" "$NF}'
printINFO 1 $LINENO $BASH_SOURCE 6 "#"


## \endcond
