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
## @ingroup utalm_make
## @file
##
## Performs unit tests by using TEST_DIRS.
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
TSTCALLROOT="${TSTCALLROOT:-$(getUpperTreePathMatch $PWD tests 0)}"

UNIT_COUNTERRORS_OPTS=${UNIT_COUNTERRORS_OPTS:-flat=1 filter=0 sums=1}
DBG=3
_S=2
export F_DEFAULT=$((F_CALLNAME|F_SEVERITY|F_CODE|F_NOCOLOR))
export _F=$F_DEFAULT

if [ -z "$TEST_DIRS" ];then
	TEST_DIRS=$(ls * 2>/dev/null|sed -n 's/\([^:]*\):/\1/p')
fi

## \endcond
#P ##
#P # Call subdirectories
#P #
#P # @param $1 subdirs
#P # @ingroup utalm_bash
#P def CallCase():
#P 	pass
## \cond
#***FUNCEND***
function CallCase () {
	
	#echo "4TEST:${UNIT_COUNTERRORS_OPTS}">>/tmp/xf
	local dirs=${*:-$TEST_DIRS}
	#
	#{ INDENT0="   $(INDENT0)" INDENT1="   $(IN&ENT1)"   CURSUBPATH=$(CURSUBPATH)/$(subst test_,,$@) $(TESTCALLER) $(CALLTEST)  $(CALLTESTOPTS) | awk -v indent="${INDENT1}" '{print indent $$0}' ; } 3>&2 2>&1 1>&3 |awk -v indent="${INDENT1}" '{print indent $$0}'  >&2 ;\
	CALL=;
	CALL="$CALL INDENT0='   ${INDENT0}' ";
	CALL="$CALL INDENT1='   ${INDENT1}'";
	CALL="$CALL CURSUBPATH='${CURSUBPATH}'";
	CALL="$CALL CALLTESTOPTS='${*}'";
	CALL="$CALL DBG=$DBG";
	CALL="$CALL ";
	for s in ${dirs};do
		((DBG>0))&&&&echo "Change to:$(bootstrapGetRealPathname $s)"
		CALLx="$CALL make -C $s $MFLAGS test";
		eval $CALLx 2>&1| countErrors.sh  ${UNIT_COUNTERRORS_OPTS};
		((DBG>0))&&echo "return from:$(bootstrapGetRealPathname $s)"
	done
}

## \endcond
