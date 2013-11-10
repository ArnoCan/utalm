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
#Execution anchor
MYCALLPATHNAME=$0
MYCALLNAME=`basename $MYCALLPATHNAME`
MYCALLNAME=${MYCALLNAME%.sh}
MYCALLPATH=`dirname $MYCALLPATHNAME`

. ${BOOTSTRAPLIB}/bootstrap-03_03_001.sh
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
fetchDBGArgs $*
if [ $? -ne 0 ];then
	exit 1
fi
((DBG>0))&&echo "DARGS=$DARGS"


((DBG>0))&&echo
((DBG>0))&&echo "*************************************************"
((DBG>0))&&echo "TEST001"
((DBG>0))&&echo
((DBG>0))&&echo 'printDBG $S_LIB $D_BULK $LINENO $BASH_SOURCE TEST000'
((DBG>0))&&echo "printDBG $S_LIB $D_BULK $LINENO $BASH_SOURCE TEST000"
a=b
printDBG $S_LIB $D_BULK $LINENO $BASH_SOURCE "TEST000"
if [ $? -ne 0 ];then
	exit 1
fi
exit 0
## \endcond
