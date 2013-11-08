#!/bin/bash
## \cond
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-make
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
## @brief Error count for unit and regression test 
##
## The collection and processing of exit codes for error evaluation 
## is based on the **gotoHell** function in 
## <a href="../../html/man3/utalm-bash-API/index.sh#index_g">utalm-bash-API(3)</a>.
## Test library 
## for DevOps tools. The parameters are transparently passed to the
## library function.
##
## Some call examples are:
##
##	CALLTESTOPTS="-d f:F_EXITCODE_AS_str" make test 2>&1|\
##		countErrors.sh expect=28 flat=1 filter=1 sums=1
##	
##	CALLTESTOPTS="-d f:F_EXITCODE_AS_str" make test 2>&1|\
##		countErrors.sh expect=28 flat=1 filter=1 sums=0
##	
##
## @ingroup libutalm_make
## \cond
#***MODUL_DOXYGEN_END***
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
errcnt=0
countErrors $*
## \endcond

