#!/bin/bash
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
#***MODUL_DOXYGEN_START***
## \endcond
## @ingroup txt2tagstemplateDemo
## @file
## @brief Installer
## 
## \cond
#***MODUL_DOXYGEN_END***

export DBGX=${DBGX:-0}
#
#Execution anchor
MYCALLPATHNAME=$0
MYCALLNAME=`basename $MYCALLPATHNAME`
MYCALLNAME=${MYCALLNAME%.sh}
MYCALLPATH=`dirname $MYCALLPATHNAME`

if [ ! -e ${0##*/} -a ${PWD##*/} != src ];then
	echo "ERROR:Must be called in own directory!">&2
	exit 1
fi

#
# installation target
#
if [ -n "${INSTROOT}" ];then
	if [ -e "${INSTROOT}" ];then
		BASE=${INSTROOT}
	else
		echo "ERROR:Missing INSTROOT=${INSTROOT}">&2
		exit 1
	fi
fi
if [ -z "${INSTROOT}" ];then
	INSTROOT=${HOME}
	BASE=${HOME}
fi

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
function displayIt () {
	[[ "$DBGX" == 1 ]]&&echo $*
}

CP="cp -r"

displayIt "->Makefile* $INSTROOT"
$CP Makefile* ${INSTROOT}

displayIt "->include $INSTROOT"
$CP include ${INSTROOT}

displayIt "->tests $INSTROOT"
$CP tests ${INSTROOT}

displayIt "->lib $INSTROOT"
$CP Makefile.lib ${INSTROOT}/lib

echo ""
echo "1. Change into ${INSTROOT}/tests/utalm-bash"
echo ""
echo "2. Call: \"make test\""
echo ""
echo ""
echo "do it now..."
echo ""
echo "... BLD_ROOT=${INSTROOT} make -C ${INSTROOT}/tests/utalm-bash test"
echo ""
BLD_ROOT=${INSTROOT}/ make -C ${INSTROOT}/tests/utalm-bash test

## \endcond
