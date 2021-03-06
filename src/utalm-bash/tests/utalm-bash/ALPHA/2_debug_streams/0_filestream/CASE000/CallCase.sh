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
##
## \endcond
##
## @file
## @brief ring buffer
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
TSTCALLROOT=${TSTCALLROOT:-$(getUpperTreePathMatch $PWD tests 0)}
. $(getPathToLib.sh libutalmrefpersistency.sh)
refDataInit $TSTCALLROOT 

#
refDataStore tst0 ""
f0=$(refDataStorePath tst0)
refDataStore tst1 ""
f1=$(refDataStorePath tst1)

#echo 4TEST:$f0
#echo 4TEST:$f1


#
fetchDBGArgs "-d LOGOUT:$f0,l:$D_ALL"
#
#header-less for simple comparison
setFormat $F_NONE

cnt=10
for((re=0;re<cnt;re++));do
	printDBG $S_ON $D_ON $LINENO $BASH_SOURCE "testRecord-${re}"
done  

#
fetchDBGArgs "-d LOGOUT:$f1,l:$D_ALL"
#
#header-less for simple comparison
setFormat $F_NONE

cnt=10
for((re=0;re<cnt;re++));do
	printDBG $S_ON $D_ON $LINENO $BASH_SOURCE "testRecord-${re}"
done  

# redirect to stdout
fetchDBGArgs "-d LOGOUT:stderr,l:$D_ALL"

#
#compare both logs
diff -q $f0 $f1
assertWithExit $LINENO $BASH_SOURCE "[[ $? -eq 0 ]]"

## \endcond

