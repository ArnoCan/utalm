#!/bin/bash
## \cond
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENCE:      Apache-2.0
#VERSION:      03_02_003
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
#***MODUL_DOXYGEN_START***
## \endcond
##
## @package libutalm_bash_devel
## @author Arno-Can Uestuensoez
## @date 2013.10.10
## @version 03_02_003
## @file
## @brief Entry level help caller
##
## Demonstrates the early-fetch of cli options by utalm, call 
## 
## <pre> 
## 
##     utalm-bash-show-help.sh -d help
##     utalm-bash-show-help.sh -d help:HTML
##     utalm-bash-show-help.sh -d help:PDF
##     utalm-bash-show-help.sh -d help:MAN
## 
## </pre> 
## You can display the environment by the call 
## 
## <pre> 
## 
##     utalm-bash-show-help.sh -d help:PATHS
## 
## </pre> 
##
## You can set the following environment variables, refer to utalm-bash.conf:
## 
## <ul> 
## 	  <li>MYDOCBASE</li>
## 	  <li>MYBINPATH</li>
## 	  <li>MYLIBPATH</li>
## 	  <li>BROWSER</li>
## 	  <li>PDFVIEWER</li>
## 	  <li>MANPATH</li>
## 	  <li>LANG</li>
## </ul> 
## 
## For detailed information on <b>UTALM-bash - libutalm</b> refer to 
## <b><a href="../../man3/libutalm-bash.html">libutalm-bash(3)</a></b>
## \cond
#***MODUL_DOXYGEN_END***
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

MYVERSION=03_01_009
MYBOOTSTRAP=${MYBINPATH}/bootstrap/bootstrap-${MYVERSION}.sh
if [ ! -f "${MYBOOTSTRAP}" ];then
    echo "${MYCALLNAME}:$LINENO:"
    echo "${MYCALLNAME}:$LINENO:ERROR:Missing:MYBOOTSTRAP=${MYBOOTSTRAP}"
    echo "${MYCALLNAME}:$LINENO:ERROR:check for \"bootstrap/bootstrap-${MYVERSION}.sh\" in:"
    echo "${MYCALLNAME}:$LINENO:ERROR:   MYBINPATH=${MYBINPATH}"
    echo "${MYCALLNAME}:$LINENO:"
    echo "${MYCALLNAME}:$LINENO:INFO:You can set MYBINPATH for the call"
    echo "${MYCALLNAME}:$LINENO:INFO:   MYBINPATH=<root-of-bootstrap> ${MYCALLNAME}.sh"
    echo "${MYCALLNAME}:$LINENO:"
    exit 1
fi
. ${MYBOOTSTRAP}

MYLANG=${MYLANG:-en}
MYHELPPATH=${MYHELPPATH:-$MYLIBPATH/help/$MYLANG}
MYCONFPATH=${MYCONFPATH:-$HOME/conf}
MYMACROPATH=${MYMACROPATH:-$HOME/conf/macros}
MYPKGPATH=${MYPKGPATH:-$MYLIBPATH/plugins}

if [ ! -f "${MYLIBPATH}/libutalm.sh" ];then
    echo "${MYCALLNAME}:$LINENO:"
    echo "${MYCALLNAME}:$LINENO:ERROR:Missing library:\"libutalm.sh\""
    echo "${MYCALLNAME}:$LINENO:ERROR:   ${MYLIBPATH}/libutalm.sh"
    echo "${MYCALLNAME}:$LINENO:"
    echo "${MYCALLNAME}:$LINENO:INFO:You can set MYLIBPATH for the call"
    echo "${MYCALLNAME}:$LINENO:INFO:   MYLIBPATH=<you-lib> ${MYCALLNAME}.sh"
    echo "${MYCALLNAME}:$LINENO:"
    exit 1
fi
. ${MYLIBPATH}/libutalm.sh
bootstrapCheckInitialPath

#
###
#


cat << EOF
Demonstrates the early-fetch of cli options by utalm, call 

    ${MYCALLNAME}.sh -d help
    ${MYCALLNAME}.sh -d help:HTML
    ${MYCALLNAME}.sh -d help:PDF
    ${MYCALLNAME}.sh -d help:MAN

You can set the following environment variables, refer to utalm-bash.conf:

	LANG
	
	BROWSER
	PDFVIEWER
	MANPATH

EOF
## \endcond