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
## @brief Installer for runtime system
##
## The runtime system contains the libraries required for the applications
## based on utaml-bash and utalm-awk.
##
## The application for creation of templates requires the SDK utaml-bash-devel.
##
## \cond
##

export DBGX=${DBGX:-0}
#
#Execution anchor
MYCALLPATHNAME=$0
MYCALLNAME=`basename $MYCALLPATHNAME`
MYCALLNAME=${MYCALLNAME%.sh}
MYCALLPATH=`dirname $MYCALLPATHNAME`

if [ ! -e ${0##*/} -a ${PWD##*/} != src ];then
	echo "ERROR:Must be called in own directory!">&2
	exit 1
fi
#
# installation source
#
INSTSOURCE=$PWD

function displayIt () {
	[[ "$DBGX" == 1 ]]&&echo $*
}

#
# installation target
#
if [ -n "${INSTROOT}" ];then
	if [  ! -e "${INSTROOT}" ];then
	   echo "ERROR:Missing INSTROOT=${INSTROOT}">&2
	   exit 1
	fi
fi
if [ -z "${INSTROOT}" ];then
   INSTROOT=${HOME}
fi

BOOTSTRAPDIR=$(getPathToBootstrapDir.sh)
BOOTSTRAP=${BOOTSTRAPDIR}/bootstrap-03_03_001.sh
. ${BOOTSTRAP}
if [ $? -ne 0 ];then
	echo "ERROR:Missing bootstrap file:configuration: ${BOOTSTRAP}">&2
	exit 1
fi
setUTALMbash 1 $*
#
###
#
CP="cp -r"

###
#bootstrap
#
for i in ${INSTSOURCE}/bin/bootstrap/*;do
        _B=${INSTROOT}/bin/bootstrap
        mkdir -p $_B
	displayIt "->${i}"
	$CP ${i} ${_B}
	chmod -R u+x ${_B}/${i##*/}
done

###
#core
#
for i in ${INSTSOURCE}/lib/core/*;do
        _B=${INSTROOT}/lib/core
        mkdir -p $_B
	displayIt "->${i}"
	$CP ${i} ${_B}
	chmod -R u+x ${_B}/${i##*/}
done

###
#bin
#
for i in ${INSTSOURCE}/bin/*;do
        _B=${INSTROOT}/bin
        mkdir -p $_B
	displayIt "->${i}"
	$CP ${i} ${_B}
	chmod -R u+x ${_B}/${i##*/}
done

###
#lib
#
for i in ${INSTSOURCE}/lib/*;do
        _B=${INSTROOT}/lib
        mkdir -p $_B
	displayIt "->${i}"
	$CP ${i} ${_B}
	chmod -R u+x ${_B}/${i##*/}
done

###
#conf
#
for i in ${INSTSOURCE}/conf/*;do
        _B=${INSTROOT}/conf
        mkdir -p $_B
	displayIt "->${i}"
	$CP ${i} ${_B}
	chmod -R u+x ${_B}/${i##*/}
done


###
#include
#
for i in ${INSTSOURCE}/include/Makefile-root.mk ${INSTSOURCE}/include/Makefile-version.mk ;do
        _B=${INSTROOT}/include
        mkdir -p $_B
	displayIt "->${i}"
	$CP ${i} ${_B}
	chmod -R u+x ${_B}/${i##*/}
done


###
#doc
#
for i in ${INSTSOURCE}/doc/*;do
        _B=${INSTROOT}/doc
        mkdir -p $_B
	displayIt "->${i}"
	$CP ${i} ${_B}
	chmod -R u+x ${_B}/${i##*/}
done


###
#examples
#
for i in ${INSTSOURCE}/examples/*;do
        _B=${INSTROOT}/examples
        mkdir -p $_B
	displayIt "->${i}"
	if [ "${i//decsription.dox}" != "$i" ];then
		continue
	fi
	$CP ${i} ${_B}
	chmod -R u+x ${_B}/${i##*/}
done

$CP ${INSTSOURCE}/sourceEnvironment.sh $INSTROOT
$CP ${INSTSOURCE}/Makefile-root.mk $INSTROOT
$CP ${INSTSOURCE}/Makefile-version.mk $INSTROOT

echo
echo "   Successfully installed"
echo
echo "   -> Change to HOME:"
echo "      -> cd "
echo ""
echo "   -> Set HOME-Environment:"
echo "      -> . sourceEnvironment.sh"
echo ""
echo "   -> For help:"
echo "      -> utalmhelp.sh help"
echo "      -> utalmhelp.sh intro"
echo "      -> utalmhelp.sh api"
echo ""
echo "   -> Evetually install the devel-package and"
echo "   -> run unit test for shell and awk scripts SUnit by UTALM."
echo


## \endcond
