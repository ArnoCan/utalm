#!/bin/bash
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENCE:      Apache-2.0
#VERSION:      03_01_002
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
#Execution anchor
MYCALLPATHNAME=$0
MYCALLNAME=`basename $MYCALLPATHNAME`
MYCALLNAME=${MYCALLNAME%.sh}
MYCALLPATH=`dirname $MYCALLPATHNAME`

. ${MYCALLPATH}/../../install.conf

. ${BOOTSTRAPLIB}/bootstrap-03.01.009.sh
. ${CORELIB}/libcore-03.01.009.sh
. ${LIBDIR}/libutalm.sh


((SILENT==0))&&cat << EOF
CASE: $0

Following outputs are tests.
 
EOF

((SILENT==0))&&echo
((SILENT==0))&&echo "*************************************************"
((SILENT==0))&&echo "TEST000"
((SILENT==0))&&echo
((SILENT==0))&&echo 'fetchDBGArgs $*'
((SILENT==0))&&echo "fetchDBGArgs $*"
a=b
fetchDBGArgs $*
if [ $? -ne 0 ];then
	exit 1
fi
((SILENT==0))&&echo "DARGS=$DARGS"


((SILENT==0))&&echo
((SILENT==0))&&echo "*************************************************"
((SILENT==0))&&echo "TEST005"
((SILENT==0))&&echo
((SILENT==0))&&echo 'doDebug&&((SILENT==0))&&echo DBG=ON||((SILENT==0))&&echo DBG=OFF'
a=b
doDebug&&((SILENT==0))&&echo "DBG=ON"||((SILENT==0))&&echo "DBG=OFF"
a=b

