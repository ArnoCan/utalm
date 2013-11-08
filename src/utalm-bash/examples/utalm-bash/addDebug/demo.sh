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
## @ingroup addDebug
## @file
## @brief Demonstration of various debug calls.
##
## For additional description refer to \ref addDebug. 
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

cat << EOF
Demostrates the early-fetch of cli options by utalm, type 

    demo.sh -d l:1
    demo.sh -d l:10
    demo.sh -d i:1
    demo.sh -d info:50
    demo.sh -d w:1
    demo.sh -d wng:50

    demo.sh -d l:50
    demo.sh -d lvl:50,i:50
    demo.sh -d level:100,i:100,warning:100

EOF


# fetchDBGArgs - collexts options, is implicit called in library
#

echo "* printDBG-Call: set level >5">&2
printDBG      $S_ALL 5  $LINENO $BASH_SOURCE  "printDBG..."

echo "* printDBG-Call: set level >5 and subsystem == $S_SYS/\$S_SYS">&2
printDBG      $S_ALL 5  $LINENO $BASH_SOURCE  "printDBG..."

echo

echo "* printWNG-Call: set level >3">&2
printWNG      3 $LINENO $BASH_SOURCE 1  "printWNG..."

echo "* printINFO-Call: set level >2">&2
printINFO     2 $LINENO $BASH_SOURCE 1  "printINFO..."

echo "* printERR-Call:">&2
printERR        $LINENO $BASH_SOURCE 1   "printERR..."

echo

echo "* printFINALCALL-Call: set level >1">&2
printFINALCALL 1 $LINENO $BASH_SOURCE TEST004 "echo ABC"

echo

echo "* callErrOutWrapper-Call:'echo BCD-Here it is!'">&2
callErrOutWrapper $LINENO $BASH_SOURCE "echo 'BCD-Here it is!'"
echo "The trick is to keep the value: exit == $?"

echo

echo "* callErrOutWrapper-Call:'exit 1'">&2
callErrOutWrapper $LINENO $BASH_SOURCE "exit 1"
echo "The trick is to keep the value: exit == $?"

echo

echo "* callErrOutWrapper-Call:'eval exit 22'">&2
callErrOutWrapper $LINENO $BASH_SOURCE "eval exit 22"
echo "The trick is to keep the value: exit == $?"

echo

echo "* callErrOutWrapper-Call:'eval exit 2'">&2
callErrOutWrapper $LINENO $BASH_SOURCE "eval exit 2"
echo "The trick is to keep the value: exit == $?"

## \endcond
