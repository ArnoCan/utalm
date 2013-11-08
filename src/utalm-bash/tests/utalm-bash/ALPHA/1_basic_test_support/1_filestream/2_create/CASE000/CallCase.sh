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
##
## @file
## @brief assertRefDataWithExit
##
## TestCase-007 demonstrates the controlled call of sub-process with collection
## and transparent bypass of output and exit value. Here expecting an error.
##
##	callErrOutWrapper $LINENO $BASH_SOURCE exec4ReturnError.sh -x -z 2
##
## \cond
#***MODUL_DOXYGEN_END***
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
. $(getPathToLib.sh libutalmrefpersistency.sh)
TROOT=$(getUpperTreePathMatch $PWD tests 0)
refDataInit $TROOT
export x=$(cat testdata.001)
{
	(
		TESTMODE=$T_CREATEREF assertRefDataWithExit $LINENO $BASH_SOURCE ID002 "$x"
	);
	TESTMODE=$T_COMPAREREF assertRefDataWithExit $LINENO $BASH_SOURCE ID002 "$(cat testdata.001)"
	assertWithExit $LINENO $BASH_SOURCE 1
} 2>&1 |countErrors flat=1 filter=1 sums=1 intermediate=0

## \endcond

