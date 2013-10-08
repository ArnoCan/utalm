#!/bin/bash
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENCE:      Apache-2.0
#VERSION:      03_02_001
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
#
#$Header$
#


shopt -s nullglob

#
#Execution anchor
MYCALLPATHNAME=$0
MYCALLNAME=`basename $MYCALLPATHNAME`; MYCALLNAME=${MYCALLNAME%.sh}
MYCALLPATH=`dirname $MYCALLPATHNAME`

#
MYLIBPATH=${MYLIBPATH:-$HOME/lib}
MYBINPATH=${MYBINPATH:-$HOME/bin}

MYBOOTSTRAP=${MYBINPATH}/bootstrap/bootstrap-03.01.009.sh
if [ ! -f "${MYBOOTSTRAP}" ];then
    echo "${MYCALLNAME}:$LINENO:ERROR:Missing:MYBOOTSTRAP=${MYBOOTSTRAP}"
    exit 1
fi
. ${MYBOOTSTRAP}

MYLANG=${MYLANG:-en}
MYHELPPATH=${MYHELPPATH:-$MYLIBPATH/help/$MYLANG}
MYCONFPATH=${MYCONFPATH:-$HOME/conf}
MYMACROPATH=${MYMACROPATH:-$HOME/conf/macros}
MYPKGPATH=${MYPKGPATH:-$MYLIBPATH/plugins}

. ${MYLIBPATH}/libutalm.sh
bootstrapCheckInitialPath

#
###
#


cat << EOF
Demostrates the early-fetch of cli options by utalm, type 

    demo.sh -d help
    demo.sh -d help:HTML
    demo.sh -d help:PDF
    demo.sh -d help:MAN

You can set the following environment variables, refer to utalm-bash.conf:

	LANG
	
	BROWSER
	PDFVIEWER
	MANPATH

EOF

