#!/bin/bash
## \cond
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENCE:      Apache-2.0
#VERSION:      03_02_003
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
#HEADEND################################################################
#
#***MODUL_DOXYGEN_START***
## \endcond
##
## @package libutalm_bash_devel
## @author Arno-Can Uestuensoez
## @date 2013.10.10
## @version 03_02_001
## @file
## @brief Test printERR
##
## TestCase-002 adds basic trace calls using predefined "const-like"
## values.
##
##	printERR $LINENO $BASH_SOURCE 1 TEST000
##
## \cond
#***MODUL_DOXYGEN_END***
#
#Execution anchor
MYCALLPATHNAME=$0
MYCALLNAME=`basename $MYCALLPATHNAME`
MYCALLNAME=${MYCALLNAME%.sh}
MYCALLPATH=`dirname $MYCALLPATHNAME`

if [ -e ${BLD_ROOT}src/conf/utalm-bash.conf ];then
. ${BLD_ROOT}src/conf/utalm-bash.conf
else
	if [ -e ${BLD_ROOT}conf/utalm-bash.conf ];then
	. ${BLD_ROOT}conf/utalm-bash.conf
	else
		if [ -e ${BLD_ROOT}conf/utalm-bash.conf ];then
		. ${BLD_ROOT}conf/utalm-bash.conf
		else
		. ${HOME}/conf/utalm-bash.conf
		fi
	fi
fi

. ${BOOTSTRAPLIB}/bootstrap-03_01_009.sh
. ${CORELIB}/libcore-03_01_009.sh
. ${LIBDIR}/libutalm.sh


((DBG>0))&&cat << EOF
CASE: $0

Following outputs are tests.
 
EOF

((DBG>0))&&echo
((DBG>0))&&echo "*************************************************"
((DBG>0))&&echo "TEST000"
((DBG>0))&&echo
((DBG>0))&&echo 'fetchDBGArgs $*'
((DBG>0))&&echo "fetchDBGArgs $*"
a=b
fetchDBGArgs $*
if [ $? -ne 0 ];then
	gotoHell $LINENO $BASH_SOURCE 1
fi
((DBG>0))&&echo "DARGS=$DARGS"

((DBG>0))&&echo
((DBG>0))&&echo "*************************************************"
((DBG>0))&&echo "TEST002"
((DBG>0))&&echo
((DBG>0))&&echo 'printERR $LINENO $BASH_SOURCE 1 TEST000'
((DBG>0))&&echo "printERR $LINENO $BASH_SOURCE 1 TEST000"
a=b
printERR $LINENO $BASH_SOURCE 1 TEST000
if [ $? -ne 0 ];then
	gotoHell $LINENO $BASH_SOURCE 1
fi
gotoHell $LINENO $BASH_SOURCE 0

## \endcond
