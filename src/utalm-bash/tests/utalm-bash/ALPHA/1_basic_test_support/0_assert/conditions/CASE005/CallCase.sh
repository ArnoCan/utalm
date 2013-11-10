#!/bin/bash
## \cond
echo "4TEST:$SHELL"

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
## @brief assertWithExit conditions
##
## TestCase-007 demonstrates the controlled call of sub-process with collection
## and transparent bypass of output and exit value. Here expecting an error.
##
##	callErrOutWrapper $LINENO $BASH_SOURCE exec4ReturnError.sh -x -z 2
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
. $(getPathToLib.sh libutalmfileobjects.sh)
. $(getPathToLib.sh libutalmrefpersistency.sh)
DBG=3
_S=2
export F_DEFAULT=$((F_CALLNAME|F_SEVERITY|F_CODE|F_NOCOLOR))
export _F=$F_DEFAULT
export UTALM_XTERM=1
#
assert $LINENO $BASH_SOURCE "[[ 'abc' < 'Abc' ]]"
assertWithExit $LINENO $BASH_SOURCE "[[ 'abc' < 'Abc' ]]"
## \endcond

