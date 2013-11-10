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
##
## \endcond
## @file
## @brief Set version.
##
##   * @ref setversion.sh
##   * @ref setversion-min.sh
##
## \cond
##
#
########################################################################
#
# refer to source-package for unstripped sources
#
#HEADEND################################################################
#
#$Header$
#
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

#list of access points for established tunnel entries
declare -a AP;
APIDX=0;

if [ -z "$BASH" ];then
    echo "*********************************************************************"
    echo "* The UnifiedSessionsManager scripts require the \"bash\".            *"
    echo "* For the installation of this version a user driven setting of the *"
    echo "* \"bash\" shell is required.                                         *"
    echo "*                                                                   *"
    echo "* Call: 1. bash                                                     *"
    echo "*       2. <path>/utalm-install.sh <args>                               *"
    echo "*                                                                   *"
    echo "*********************************************************************"
    exit 1
fi

if [ "$HOME" == "/" ];then
    echo "The UnifiedSessionsManager requires a HOME directory differen from top=\"/\"."
    echo "If you are root, you may create \"/root\" and set this as your home."
    exit 1
fi

case ${MYOS} in
    Linux);;
#     SunOS)
# 	export PATH=/usr/xpg4/bin:/usr/share/sfw/bin:/usr/sbin:/usr/bin:/usr/openwin/bin:$PATH
# 	;;
    *)
	ABORT=1;
	printERR $LINENO $BASH_SOURCE ${ABORT} "Current OS is not supported:\"${MYOS}\""
	gotoHell $LINENO $BASH_SOURCE ${ABORT}
	;;
esac

INSTTYPE=;
INSTDIR=;
LNKDIR=;
TARGETLST=;
RUSER=;
_doctrans=;

_ARGS=;
_ARGSCALL=$*;
_RUSER0=;
LABEL=;

_BYPASSARGS=;
_AGENTFORW=;

_MODE=0;
argLst=;

_SET_B=;

_X11=;

_nTarget=;

while [ -n "$1" ];do
    case $1 in
 	'--version='*)_nVERSION=${1#*=};_nVERSION=${_nVERSION// /};_nVERSION=${_nVERSION//./_};;
 	'--release='*)_nRELEASE=${1#*=};_nRELEASE=${_nRELEASE// /};;
 	'--variant='*)_nVARIANT=${1#*=};_nVARIANT=${_nVARIANT// /};;
 	'--target='*) _nTarget=${1#*=};;

	'-d')shift;;

	'-H'|'--helpEx'|'-helpEx')shift;_HelpEx="${1:-$MYCALLNAME}";;
	'-h'|'--help'|'-help')_showToolHelp=1;;
	'-V')_printVersion=1;;
	'-X')C_TERSE=1;_BYPASSARGS="${_BYPASSARGS} $1";;
        *)
	    ABORT=1
	    printERR $LINENO $BASH_SOURCE ${ABORT} "Unknown option:<${1}>"
	    gotoHell ${ABORT}
	    ;;
    esac
    shift
done

if [ -n "$_HelpEx" ];then
    printHelpEx "${_HelpEx}";
    exit 0;
fi

if [ -n "$_showToolHelp" ];then
    showToolHelp;
    exit 0;
fi

if [ -n "$_printVersion" ];then
    printVersion;
    exit 0;
fi



if [ -n "$_nTarget" ];then
    _tDIR="${_nTarget%/*}";

    if [ ! -d ];then
	ABORT=1
	printERR $LINENO $BASH_SOURCE ${ABORT} "Missing directory:<${_tDIR}>"
	gotoHell ${ABORT}
    fi

    #LOC
    LOC=`find ${MYINSTALLPATH} -type f -name '*[!~]'  -name '[!0-9][!0-9]*' -exec cat {} \;|wc -l`

    #LOC-NET
    LOCNET=`find ${MYINSTALLPATH} -type f -name '*[!~]'  -name '[!0-9][!0-9]*' -exec cat {} \;|sed -n '/^ *#.*/d;/^$/d;p'|wc -l`
    LOD1=0
    if [ -e "${MYINSTALLPATH}/help" -a -e "${MYINSTALLPATH}/doc" ];then
	LOD1=`find ${MYINSTALLPATH}/help ${MYINSTALLPATH}/doc -type f -name '*[!~]'  -exec cat {} \;|wc -l`
    else
	if [ -e "${MYINSTALLPATH}/help" ];then
	    LOD1=`find ${MYINSTALLPATH}/help -type f -name '*[!~]'  -exec cat {} \;|wc -l`
        fi
	if [ -e "${MYINSTALLPATH}/doc" ];then
	    LOD1=`find ${MYINSTALLPATH}/doc -type f -name '*[!~]'  -exec cat {} \;|wc -l`
	fi
    fi

    #LOD
    MYDOCSOURCE="${MYINSTALLPATH%/*}/doc"
    if [ ! -d "${MYDOCSOURCE}" ];then
	MYDOCSOURCE=;
	if [ -f "${MYDOCSOURCE}" ];then
	    LOD2=`wc -l ${MYDOCSOURCE}`
	else
	    LOD2=0;
	fi
    else
	LOD2=`find ${MYDOCSOURCE} -type f -name '*.tex'  -exec cat {} \;|wc -l`
    fi

    LOD=$((LOD1+LOD2));

    echo "###version-file=${_nTarget}"
    echo "###">"${_nTarget}"
    echo "VERSION=\"${_nVERSION}\"">>"${_nTarget}"
    echo "RELEASE=\"${_nRELEASE}\"">>"${_nTarget}"
    echo "VARIANT=\"${_nVARIANT}\"">>"${_nTarget}"
    echo "DATE=${DATE}">>"${_nTarget}"
    echo "TIME=${TIME}">>"${_nTarget}"
    echo "###">>"${_nTarget}"
    echo "LOC=\"${LOC// }\"">>"${_nTarget}"
    echo "LOCNET=\"${LOCNET// }\"">>"${_nTarget}"
    echo "LOD=\"${LOD// }\"">>"${_nTarget}"

    exit 0
fi


#
#
#
UTALMVERSGEN=${MYCONFPATH}/versinfo.gen.sh

#
#
#
UTALMGETREL=${MYLIBEXECPATH}/bin/getCurUTALMRel.sh
if [ -n "${_nVERSION}" ];then
    if [ -n "${UTALMGETREL}" ];then
	sed -i 's/utalm_RELEASE=..*/utalm_RELEASE='"${_nVERSION}"'/g' ${UTALMGETREL}
    else
	ABORT=1;
	printERR $LINENO $BASH_SOURCE ${ABORT} "Missing:\"${UTALMGETREL}\""
	gotoHell ${ABORT}
    fi

    if [ -n "${utalmVERSGEN}" ];then
	sed -i 's/UTALMREL=.*$/UTALMREL='"${_nVERSION}"'/g' ${UTALMVERSGEN}
	sed -i 's/VERSION=.*$/VERSION='"${_nVERSION}"'/g' ${UTALMVERSGEN}
    fi

fi



#
#
#
UTALMGETVAR=${MYLIBEXECPATH}/bin/getCurUTALMVariant.sh
if [ -n "${_nVARIANT}" ];then
    if [ -n "${UTALMGETREL}" ];then
	sed -i 's/UTALM_VARIANT=.*$/UTALM_VARIANT='"${_nVARIANT}"'/g' ${UTALMGETVAR}
    else
	ABORT=1;
	printERR $LINENO $BASH_SOURCE ${ABORT} "Missing:\"${UTALMGETVAR}\""
	gotoHell ${ABORT}
    fi

    if [ -n "${UTALMVERSGEN}" ];then
	sed -i 's/UTALMVARIANT=.*$/UTALMVARIANT='"${_nVARIANT}"'/g' ${UTALMVERSGEN}
    fi

fi
## \endcond

