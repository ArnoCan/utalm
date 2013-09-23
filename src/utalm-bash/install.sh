#!/bin/bash
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENCE:      Apache-2.0
#VERSION:      03_01_001
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

function display () {
	if((VERBOSE==1));then
		echo $*
	else
		if((SILENT==0));then
			echo $*
		fi
	fi
}

. ${MYCALLPATH}/install.conf


CP="cp -r"
for i in src/bin/bootstrap/*;do
	display "->${i}"
	$CP ${i} ${BOOTSTRAPBIN}
	chmod -R u+x ${BOOTSTRAPBIN}/${i##*/} 
	$CP ${i} ${BOOTSTRAPLIB}
	chmod -R u+x ${BOOTSTRAPLIB}/${i##*/} 
done

for i in src/lib/core/*;do
	display "->${i}"
	$CP ${i} ${COREBIN}
	chmod -R u+x ${COREBIN}/${i##*/} 
	$CP ${i} ${CORELIB}
	chmod -R u+x ${CORELIB}/${i##*/} 
done

for i in src/bin/*;do
	display "->${i}"
	cp -r ${i} ${BINDIR}
	chmod -R u+x ${BINDIR}/${i##*/} 
done

display "->libutalm.sh $LIBDIR"
$CP src/lib/libutalm.sh $LIBDIR

