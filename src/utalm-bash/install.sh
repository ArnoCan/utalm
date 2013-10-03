#!/bin/bash
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENCE:      Apache-2.0
#VERSION:      03_01_002
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
#HEADEND################################################################

export VERBOSE=${VERBOSE:-0}
export SILENT=${SILENT:-1}
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

if [ -e ${MYCALLPATH%/*}/conf/utalm-bash.conf ];then
	. ${MYCALLPATH%/*}/conf/utalm-bash.conf
else
	if [ -e ${BASH_SOURCE%/*}/src/conf/utalm-bash.conf ];then
		. ${BASH_SOURCE%/*}/src/conf/utalm-bash.conf
	else
		if [ -e ${BASH_SOURCE%/*}/conf/utalm-bash.conf ];then
			. ${BASH_SOURCE%/*}/conf/utalm-bash.conf
		else
			if [ -e ${HOME}/conf/utalm-bash.conf ];then
				. ${HOME}/conf/utalm-bash.conf
			else
				echo "ERROR:Missing: utalm-bash.conf">&2
				echo "ERROR:${BASH_SOURCE}">&2
				echo "ERROR:${PWD}">&2
				exit 1
			fi
		fi
	fi
fi

. ${MYCALLPATH}/install.conf

CP="cp -r"
for i in ${BASE}bin/bootstrap/*;do
	displayIt "->${i}"
	$CP ${i} ${BOOTSTRAPBIN}
	chmod -R u+x ${BOOTSTRAPBIN}${i##*/} 
	$CP ${i} ${BOOTSTRAPLIB}
	chmod -R u+x ${BOOTSTRAPLIB}${i##*/} 
done

for i in ${BASE}lib/core/*;do
	displayIt "->${i}"
	$CP ${i} ${COREBIN}
	chmod -R u+x ${COREBIN}${i##*/} 
	$CP ${i} ${CORELIB}
	chmod -R u+x ${CORELIB}${i##*/} 
done

for i in ${BASE}bin/*;do
	displayIt "->${i}"
	cp -r ${i} ${BINDIR}
	chmod -R u+x ${BINDIR}${i##*/} 
done

for i in ${BASE}conf/*;do
	displayIt "->${i}"
	cp -r ${i} ${MYCONFPATH}
done


_BASE=${BASE%/}
_BASE=${_BASE%/src}
if [ "$_BASE" == src ];then
	_BASE=.
fi
_BASE=${_BASE}/
for i in ${_BASE}doc/*;do
	displayIt "->${i}"
	cp -r ${i} ${DOCBASE}
done


displayIt "->libutalm.sh $LIBDIR"
$CP ${BASE}lib/libutalm.sh $LIBDIR

$CP ${BASE}utalm-bash-show-help.sh $HOME