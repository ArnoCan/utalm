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
#
#$Header$
#


#FUNCEG###############################################################
#
#PROJECT:
MYPROJECT="Unified Sessions Manager"
#
#NAME:
#  ctys-setversion.sh
#
#AUTHOR:
AUTHOR="Arno-Can Uestuensoez - acue.opensource@gmail.com"
#
#FULLNAME:
FULLNAME="Unified Sessions Manager - remote execution"
#
#CALLFULLNAME:
CALLFULLNAME="ctys-setversion.sh"
#
#LICENCE:
LICENCE=GPL3
#
#TYPE:
#  sh-script
#
#VERSION:
VERSION=01_11_011
#DESCRIPTION:
#  Remote execution script.
#
#  For further information refer to help and manual.
#
#
#EXAMPLE:
#
#PARAMETERS:
#
#
#  refer to online help "-h" and/or "-H"
#
#
#OUTPUT:
#  RETURN:
#  VALUES:
#
#FUNCEND###############################################################


#list of access points for established tunnel entries
declare -a AP;
APIDX=0;

################################################################
#       System definitions - do not change these!              #
################################################################
#Execution anchor
MYCALLPATHNAME=$0
MYCALLNAME=${MYCALLPATHNAME##*/}
MYCALLNAME=${MYCALLNAME%.sh}
MYCALLPATH=${MYCALLPATHNAME%/*}

MYLIBEXECPATHNAME=$MYCALLPATHNAME

#
#identify the actual location of the callee
#
if [ -n "${MYLIBEXECPATHNAME##/*}" ];then
	MYLIBEXECPATHNAME=${PWD}/${MYLIBEXECPATHNAME}
fi
MYLIBEXECPATH=${MYLIBEXECPATHNAME%/*}

###################################################
#load basic library required for bootstrap        #
###################################################
MYBOOTSTRAP=${MYLIBEXECPATH}/bootstrap
if [ ! -d "${MYBOOTSTRAP}" ];then
    MYBOOTSTRAP=${MYCALLPATH}/bootstrap
    if [ ! -d "${MYBOOTSTRAP}" ];then
	echo "${MYCALLNAME}:$LINENO:ERROR:Missing:MYBOOTSTRAP=${MYBOOTSTRAP}"
	cat <<EOF  


DESCRIPTION:
  This directory contains the common mandatory bootstrap functions.
  Your installation my be erroneous.  

SOLUTION-PROPOSAL:
  First of all check your installation, because an error at this level
  might - for no reason - bypass the final tests.

  If this does not help please send a bug-report.

EOF
	exit 1
    fi
fi

MYBOOTSTRAP=${MYBOOTSTRAP}/bootstrap-03.01.009.sh
if [ ! -f "${MYBOOTSTRAP}" ];then
  echo "${MYCALLNAME}:$LINENO:ERROR:Missing:MYBOOTSTRAP=${MYBOOTSTRAP}"
cat <<EOF  

DESCIPTION:
  This file contains the common mandatory bootstrap functions required
  for start-up of any shell-script within this package.

  It seems though your installation is erroneous or you detected a bug.  

SOLUTION-PROPOSAL:
  First of all check your installation, because an error at this level
  might - for no reason - bypass the final tests.

  When your installation seems to be OK, you may try to set a TEMPORARY
  symbolic link to one of the files named as "bootstrap.<highest-version>".
  
    ln -s ${MYBOOTSTRAP} bootstrap.<highest-version>

  in order to continue for now. 

  Be aware, that any installation containing the required file will replace
  the symbolic link, because as convention the common boostrap files are
  never symbolic links, thus only recognized as a temporary workaround to 
  be corrected soon.

  If this does not work you could try one of the other versions.

  Please send a bug-report.

EOF
  exit 1
fi

###################################################
#Start bootstrap now                              #
###################################################
. ${MYBOOTSTRAP}
###################################################
#OK - utilities to find components of this version#
#available now.                                   #
###################################################

#
#set real path to install, resolv symbolic links
_MYLIBEXECPATHNAME=`bootstrapGetRealPathname ${MYLIBEXECPATHNAME}`
MYLIBEXECPATH=${_MYLIBEXECPATHNAME%/*}

_MYCALLPATHNAME=`bootstrapGetRealPathname ${MYCALLPATHNAME}`
MYCALLPATHNAME=${_MYCALLPATHNAME%/*}

#
###################################################
#Now find libraries might perform reliable.       #
###################################################

#current language, not really NLS
MYLANG=${MYLANG:-en}

#path for various loads: libs, help, macros, plugins
MYLIBPATH=${MYLIBEXECPATH%/*}

#path for various loads: libs, help, macros, plugins
MYHELPPATH=${MYHELPPATH:-$MYLIBPATH/help/$MYLANG}

###################################################
#Check master hook                                #
###################################################
bootstrapCheckInitialPath
###################################################
#OK - Now should work.                            #
###################################################

MYCONFPATH=${MYCONFPATH:-$MYLIBPATH/conf}
if [ ! -d "${MYCONFPATH}" ];then
  echo "${MYCALLNAME}:$LINENO:ERROR:Missing:MYCONFPATH=${MYCONFPATH}"
  exit 1
fi

if [ -f "${MYCONFPATH}/versinfo.conf.sh" ];then
    . ${MYCONFPATH}/versinfo.conf.sh
fi

MYMACROPATH=${MYMACROPATH:-$MYCONFPATH/macros}
if [ ! -d "${MYMACROPATH}" ];then
  echo "${MYCALLNAME}:$LINENO:ERROR:Missing:MYMACROPATH=${MYMACROPATH}"
  exit 1
fi

MYPKGPATH=${MYPKGPATH:-$MYLIBPATH/lib/plugins}
if [ ! -d "${MYPKGPATH}" ];then
  echo "${MYCALLNAME}:$LINENO:ERROR:Missing:MYPKGPATH=${MYPKGPATH}"
  exit 1
fi

MYINSTALLPATH= #Value is assigned in base. Symbolic links are replaced by target

##############################################
#load basic library required for bootstrap   #
##############################################

. ${MYLIBPATH}/lib/libutalm.sh
coreRegisterLib

##############################################
#Now the environment is armed, so let's go.  #
##############################################

if [ -z "$BASH" ];then
    echo "*********************************************************************"
    echo "* The UnifiedSessionsManager scripts require the \"bash\".            *"
    echo "* For the installation of this version a user driven setting of the *"
    echo "* \"bash\" shell is required.                                         *"
    echo "*                                                                   *"
    echo "* Call: 1. bash                                                     *"
    echo "*       2. <path>/ctys-install.sh <args>                               *"
    echo "*                                                                   *"
    echo "*********************************************************************"
    exit 1
fi

if [ "$HOME" == "/" ];then
    echo "The UnifiedSessionsManager requires a HOME directory differen from top=\"/\"."
    echo "If you are root, you may create \"/root\" and set this as your home."
    exit 1
fi

if [ "$MYLIBEXECPATH" == "." ];then
    MYLIBEXECPATH=${PWD%/*}
else
    MYLIBEXECPATH=${MYLIBEXECPATH%/*}
fi
export MYLIBEXECPATH
MYLIBPATH=$MYLIBEXECPATH
PATH=$MYLIBEXECPATH:$PATH

case ${MYOS} in
    Linux);;
#     SunOS)
# 	export PATH=/usr/xpg4/bin:/opt/sfw/bin:/usr/sbin:/usr/bin:/usr/openwin/bin:$PATH
# 	;;
    *)
	ABORT=1;
	printERR $LINENO $BASH_SOURCE ${ABORT} "Current OS is not supported:\"${MYOS}\""
	gotoHell ${ABORT}
	;;
esac



#Source pre-set environment from user
if [ -f "${HOME}/.ctys/ctys.conf.sh" ];then
  . "${HOME}/.ctys/ctys.conf.sh"
fi

#Source pre-set environment from installation 
if [ -f "${MYCONFPATH}/ctys.conf.sh" ];then
  . "${MYCONFPATH}/ctys.conf.sh"
fi

#system tools
if [ -f "${HOME}/.ctys/systools.conf-${MYDIST}.sh" ];then
    . "${HOME}/.ctys/systools.conf-${MYDIST}.sh"
else

    if [ -f "${MYCONFPATH}/systools.conf-${MYDIST}.sh" ];then
	. "${MYCONFPATH}/systools.conf-${MYDIST}.sh"
    else
	if [ -f "${MYLIBEXECPATH}/../conf/ctys/systools.conf-${MYDIST}.sh" ];then
	    . "${MYLIBEXECPATH}/../conf/ctys/systools.conf-${MYDIST}.sh"
	else
	    ABORT=1;
	    printERR $LINENO $BASH_SOURCE ${ABORT} "Missing system tools configuration file:\"systools.conf-${MYDIST}.sh\""
	    printERR $LINENO $BASH_SOURCE ${ABORT} "Check your installation."
	    gotoHell ${ABORT}
	fi
    fi
fi


. ${MYLIBPATH}/lib/help/help.sh
#. ${MYLIBPATH}/lib/misc.sh
#. ${MYLIBPATH}/lib/network/network.sh
#. ${MYLIBPATH}/lib/groups.sh


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
    MYDOCSOURCE="${MYINSTALLPATH%/*}/ctys-manual.${INSTVERSION}"
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
CTYSVERSGEN=${MYCONFPATH}/versinfo.gen.sh

#
#
#
CTYSGETREL=${MYLIBEXECPATH}/bin/getCurCTYSRel.sh
if [ -n "${_nVERSION}" ];then
    if [ -n "${CTYSGETREL}" ];then
	sed -i 's/CTYS_RELEASE=..*/CTYS_RELEASE='"${_nVERSION}"'/g' ${CTYSGETREL}
    else
	ABORT=1;
	printERR $LINENO $BASH_SOURCE ${ABORT} "Missing:\"${CTYSGETREL}\""
	gotoHell ${ABORT}
    fi

    if [ -n "${CTYSVERSGEN}" ];then
	sed -i 's/CTYSREL=.*$/CTYSREL='"${_nVERSION}"'/g' ${CTYSVERSGEN}
	sed -i 's/VERSION=.*$/VERSION='"${_nVERSION}"'/g' ${CTYSVERSGEN}
    fi

fi



#
#
#
CTYSGETVAR=${MYLIBEXECPATH}/bin/getCurCTYSVariant.sh
if [ -n "${_nVARIANT}" ];then
    if [ -n "${CTYSGETREL}" ];then
	sed -i 's/CTYS_VARIANT=.*$/CTYS_VARIANT='"${_nVARIANT}"'/g' ${CTYSGETVAR}
    else
	ABORT=1;
	printERR $LINENO $BASH_SOURCE ${ABORT} "Missing:\"${CTYSGETVAR}\""
	gotoHell ${ABORT}
    fi

    if [ -n "${CTYSVERSGEN}" ];then
	sed -i 's/CTYSVARIANT=.*$/CTYSVARIANT='"${_nVARIANT}"'/g' ${CTYSVERSGEN}
    fi

fi



