## \cond
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-make
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
## @ingroup libutalm_make
## @file
## @brief Helper utility for check of completion of mask
##
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

if [ -z "$AWKPATH" ];then
	AWKPATH=${MYCALLPATH}:${LIBDIR}
fi
export AWKPATH

function scantarget () {
local fname=$1
awk '
	#
	# requires AWKPATH
	@include "libutalm.awk"

	/[\\@]cond/&&NR<3{exit(0);}
	/[\\@]cond/&&NR>2{printERR(1,"'"${LINENO}"'","'"${BASH_SOURCE}"'",1,"Missing immediate start cond:"FILENAME);gotoHell(1,FILENAME,1);}
	{printINFO(2,"'"${LINENO}"'","'"${BASH_SOURCE}"'",0,"Current file:"FILENAME);}
' $fname
}

{
if [ -f "${FILEONLY}" ];then
	scantarget ${FILEONLY}
else
	if [ -n "${FILEONLY}" ];then
		_baseabs=${FILEONLY}
	else
		_baseabs=$PWD
	fi
	{
		_curbase=;
		for _curbase in ${_baseabs};do
	    	find ${_curbase} -type f -name '*' \
			-exec awk -F'=' -v matchMin=4 \
			-f ${MYCALLPATH}/doxygenfilter.awk {} \; \
			#			-print 2>/dev/null
			ret=$?;
			if [  $ret -ne 0  ];then
				printWNG 1 $LINENO $BASH_SOURCE ${ret:-0} "SCAN-DOXYGEN-FILES:Partial access error/check permissions:$MYUID@$MYHOST with \"find ${_curbase} ...(ret=$ret)\""
			fi
		done
    }|\
    while read X;do
        f=${X%%:*};
        l=${X%:*};l=${l#*:};
        s=${X##*:};
    	printDBG $S_UTALM ${D_DATA} $LINENO $BASH_SOURCE "$FUNCNAME:MATCH=${X}"
		scantarget $f
	done
fi
}

## \endcond
