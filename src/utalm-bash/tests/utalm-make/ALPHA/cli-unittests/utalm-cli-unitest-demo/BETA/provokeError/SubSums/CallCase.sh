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
#$Header$
#
#***MODUL_DOXYGEN_START***
## \endcond
## @file
##
## \cond
#***MODUL_DOXYGEN_END***
#
shopt -s nullglob
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
. $(getPathToLib.sh Makefile.lib/Nodeaction-test.sh)
#
###
#
DBG=3
_S=2
export F_DEFAULT=$((F_CALLNAME|F_SEVERITY|F_CODE|F_NOCOLOR))
export _F=$F_DEFAULT

#
UNIT_COUNTERRORS_OPTS=${UNIT_COUNTERRORS_OPTS:-flat=1 filter=1 sums=1}
_UNIT_COUNTERRORS_OPTS=${UNIT_COUNTERRORS_OPTS}
#
printINFO $D_DATA $LINENO $BASH_SOURCE 0 "expect=5"
UNIT_COUNTERRORS_OPTS="${_UNIT_COUNTERRORS_OPTS} expect=5" CallCase CASE000
#
printINFO $D_DATA $LINENO $BASH_SOURCE 0 "expect=3"
UNIT_COUNTERRORS_OPTS="${_UNIT_COUNTERRORS_OPTS} expect=3" CallCase CASE001 
#
printINFO $D_DATA $LINENO $BASH_SOURCE 0 "expect=3"
UNIT_COUNTERRORS_OPTS="${_UNIT_COUNTERRORS_OPTS} expect=3" CallCase SubSums 

exit 0

## \endcond
