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
## @file
## @brief Test scan of command line call options by fetchDBArgs
##
## TestCase-000 with basic call test for commanline evaluation
## and controlled exit with defined display value on exit for
## post processing. The evaluation is performed by early-fetch
## in the library, thus needs no additional action. This assures
## tracing to begin when options are processes.
##
##	# Loads common bootstrap-functions
##	. ${BOOTSTRAPLIB}/bootstrap-03_03_001.sh
##	
##	# Next level of core function, still a little and very basic.
##	. ${CORELIB}/libcore-03_01_009.sh
##	
##	# The main library. 
##	. ${LIBDIR}/libutalm.sh
##	
##	gotoHell $LINENO $BASH_SOURCE 0
##
#***MODUL_DOXYGEN_END***
## \cond
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
fetchDBGArgs $*
if [ $? -ne 0 ];then
	gotoHell $LINENO $BASH_SOURCE 1
fi
gotoHell $LINENO $BASH_SOURCE 0
## \endcond
