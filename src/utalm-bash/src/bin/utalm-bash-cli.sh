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
#$Header$
#
##
## \endcond
## @file
## @brief CLI wrapper for utalm-bash.sh
##
## Provides a command line interface for the features of utalm-bash.sh.
## The call interface is almost the same as the function call.
##
##	utalm-bash-cli.sh [<call-opts>] <utalm-bash-function> [<function-opts>]
##
## The following options are available:
##
##	<call-opts> := (-X|<debug-options>)
##	 
##	 	-X
##	 		Generates a standard output string with execution state for 
##			unit and regression tests by application of \ref collectErrors.sh 
##	 
##	 	<debug-options>
##			Standard option '-d' for activating the debugging. Could be	 
##	 		a bypassed call option when applied embedded ito a script.
##
## The following options are related to the requested call of the library
## funcion. 
##
##	<utalm-bash-function> [<function-opts>]	 
##	
##		<utalm-bash-function> := (
##			fetchDBGArgs
##			| doDebug
##			| printDBG
##			| printERR
##			| printWNG
##			| printINFO
##			| printFINALCALL
##			| callErrOutWrapper
##			| getPathName
##			| gotoHell
##		)
##
##		<function-opts>
##			Options as defined by the called function. These are transparenty	 
##	 		bypassed to the callee.
##	 
## The following examples demonstrate the call interface.
##
## - Online help.
##
##	- utalm-bash-cli.sh -d help
##	- utalm-bash-cli.sh -d help:HTML
##	- utalm-bash-cli.sh -d help:PDF
##	- utalm-bash-cli.sh -d help:MAN
## 
## - Warning output by printWNG.
##
##	utalm-bash-cli.sh -d 10 printWNG 1 10 myfile 11 "This is a test"
##
## - Debug output by printDBG.
##
##	utalm-bash-cli.sh -d 10 printDBG 1 1 10 myfile "This is a test"
##
## - Whereas the previos example performs silently, just returning the 
##   exit code as the sum of faild units/error cases, the following in 
##   addition displays a string containing the information for postprocessing 
##   in automated runtime environments.
##
##	utalm-bash-cli.sh -X -d 10 printDBG 1 1 10 myfile "This is a test"
##
## - A controlled exit with standard postprocessing format by gotoHell.
##   This could be applied for example within scripts as well as within 
##   makefiles.
##
##	utalm-bash-cli.sh -d 10 gotoHell 10 myfile 99
##
## 
## @ingroup utalm_bash
## \cond
##
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
ARGS=$*
for i in $*;do
	case $i in
		-d|--debug)shift;
		fetchDBGArgs $1
		;;
		fetchDBGArgs)
		displayIt ">>>"
		fetchDBGArgs $@
		ret=$?
		displayIt "<<<"
		((NOEXIT))&&gotoHell 0 0 $?
		;;
		doDebug)
		displayIt ">>>"
		doDebug $@
		ret=$?
		displayIt "<<<"
		((NOEXIT))&&gotoHell 0 0 $?
		;;
		printDBG)
		displayIt ">>>"
		printDBG $@
		ret=$?
		displayIt "<<<"
		((NOEXIT))&&gotoHell 0 0 $?
		;;
		printERR)
		displayIt ">>>"
		printERR $@
		ret=$?
		displayIt "<<<"
		((NOEXIT))&&gotoHell 0 0 $?
		;;
		printWNG)
		displayIt ">>>"
		printWNG $@
		ret=$?
		displayIt "<<<"
		((NOEXIT))&&gotoHell 0 0 $?
		;;
		printINFO)
		displayIt ">>>"
		printINFO $@
		ret=$?
		displayIt "<<<"
		((NOEXIT))&&gotoHell 0 0 $?
		;;
		printFINALCALL)
		displayIt ">>>"
		printFINALCALL $@
		ret=$?
		displayIt "<<<"
		((NOEXIT))&&gotoHell 0 0 $?
		;;
		callErrOutWrapper)
		displayIt ">>>"
		callErrOutWrapper $@
		ret=$?
		displayIt "<<<"
		((NOEXIT))&&gotoHell 0 0 $?
		;;
		getPathName)
		displayIt ">>>"
		getPathName $@
		ret=$?
		displayIt "<<<"
		((NOEXIT))&&gotoHell 0 0 $?
		;;
		gotoHell)
		displayIt ">>>"
		((NOEXIT))&&gotoHell $@
		;;
		'-X')
		NOEXIT=1
		shift
		;;
				
	esac
	shift
done
exit $ret
## \endcond
