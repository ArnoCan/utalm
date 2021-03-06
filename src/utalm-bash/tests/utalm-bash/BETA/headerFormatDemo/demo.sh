## \cond
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENSE:      Apache-2.0 + CCL-BY-SA-3.0
#VERSION:      03_03_001
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
#***MODUL_DOXYGEN_START***
## \endcond
## @file
## @brief Demonstrates howto set correct parameters
##
## For additional description refer to \ref headerFormatDemo. 
## \cond
#***MODUL_DOXYGEN_END***
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

	printDBG  $S_ALL 1 $LINENO $BASH_SOURCE   "out-dbg"
	printINFO        1 $LINENO $BASH_SOURCE 3 "out-info"
	printWNG         1 $LINENO $BASH_SOURCE 3 "out-wng"
	printERR           $LINENO $BASH_SOURCE 3 "out-err"

	
}

echo "#################################################">&2
echo "# Default record">&2
echo "#################################################">&2
echo "#">&2
printSomeUTALM
echo "#">&2
echo "#################################################">&2
echo "#">&2

cat <<EOF
try:

demo.sh -d 1,f:F_CALLNAME%F_RLOGINIP
demo.sh -d 1,f:F_CALLNAME%F_RLOGINIP%help
demo.sh -d 1,f:F_CALLNAME%F_RLOGINIP%F_SEVERITY
demo.sh -d 1,f:F_CALLNAME%F_RLOGINDNS%F_SEVERITY%F_INDENT
demo.sh -d 1,f:F_CALLNAME%F_RLOGINDNS%F_USERNUM%F_SEVERITY%F_INDENT

demo.sh -d 1,f:help

EOF



## \endcond
