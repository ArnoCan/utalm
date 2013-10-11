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
## @name bootstrap
## @author Arno-Can Uestuensoez
## @date 2013.10.10
## @version 03_02_001
## @file
## @brief Core functions early required. 
##
## \cond
#***MODUL_DOXYGEN_END***

if [ -z "$__LIBCORE__" ];then #*** prevent multiple inclusion
__LIBCORE__=1 #*** prevent multiple inclusion

_myLIBNAME_libcore="${BASH_SOURCE}"
_myLIBVERS_libcore="03.01.009"


#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P #  Finds shell library:
#P #
#P #  	0. LIBPATH
#P #  	1. LIBEXECPATH
#P #  	2. PATH
#P #  	3. HOME/lib
#P #
#P # @param $1: libname
#P # @return Returns absolute pathname.
#P def coreGetLibPathname():
#P 	pass
## \cond
#***FUNCEND***
function coreGetLibPathname () {
    local _libpathname=${1};

    if [ -e "${_libpathname}" ];then
		echo -n "${_libpathname}"
		return
    fi

    local _i="";
    if [ -n "${LIBPATH}" ];then
    	for _i in ${LIBPATH//:/ };do
		    if [ -e "${_i}/${_libpathname}" ];then
				echo -n "${_i}/${_libpathname}"
				return
		    fi
    	done
    fi

    if [ -e "${LIBEXECPATH}/${_libpathname}" ];then
		echo -n "${LIBEXECPATH}/${_libpathname}"
		return
    fi

    if [ -n "${PATH}" ];then
    	for _i in ${PATH//:/ };do
		    if [ -e "${_i}/${_libpathname}" ];then
				echo -n "${_i}/${_libpathname}"
				return
		    fi
    	done
    fi

    if [ -e "${HOME}/lib/${_libpathname}" ];then
		echo -n "${HOME}/lib/${_libpathname}"
		return
    fi
}


function coreRegisterLib () {
	bootstrapRegisterLib $*
}


function coreListLib () {
	bootstrapListLib $*
}

#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P #  Encapsulates the input-string with appropriate escape sequences for
#P #  atributes of charachter representation.
#P #
#P #  REMARK:
#P #    Due to performance reasons for parts of common trace-output the 
#P #    values are hardcoded within the whole module.
#P #  Finds shell library:
#P #
#P # @param $1: (BOLD|UNDL|
#P #      FBLACK|FRED|FGREEN|FYELLOW|FBLUE|FMAGENTA|FCYAN|FWHITE
#P #      BBLACK|BRED|BGREEN|BYELLOW|BBLUE|BMAGENTA|BCYAN|BWHITE
#P #      RESET)
#P # @param $2-*
#P # @return 
#P #  - SUCCESS: 0 - "<esc-color>$2-*<esc-color-reset>" 
#P #  - FAILURE: 1 
#P def setFontAttrib():
#P 	pass
## \cond
#***FUNCEND***
function setFontAttrib () {
    local col=$1;shift
    [ "$UTALM_XTERM" != 0 ]&&echo -n -e "$*"||\
    case $col in
	BOLD)echo -n -e "\033[1m${*}\033[m";;
	UNDL)echo -n -e "\033[4m${*}\033[m";;

	FBLACK)echo -n -e "\033[30m${*}\033[m";;
	FRED)echo -n -e "\033[31m${*}\033[m";;
	FGREEN)echo -n -e "\033[32m${*}\033[m";;
	FYELLOW)echo -n -e "\033[33m${*}\033[m";;
	FBLUE)echo -n -e "\033[34m${*}\033[m";;
	FMAGENTA)echo -n -e "\033[35m${*}\033[m";;
	FCYAN)echo -n -e "\033[36m${*}\033[m";;
	FWHITE)echo -n -e "\033[37m${*}\033[m";;

	BBLACK)echo -n -e "\033[40m${*}\033[m";;
	BRED)echo -n -e "\033[41m${*}\033[m";;
	BGREEN)echo -n -e "\033[42m${*}\033[m";;
	BYELLOW)echo -n -e "\033[43m${*}\033[m";;
	BBLUE)echo -n -e "\033[44m${*}\033[m";;
	BMAGENTA)echo -n -e "\033[45m${*}\033[m";;
	BCYAN)echo -n -e "\033[46m${*}\033[m";;
	BWHITE)echo -n -e "\033[47m${*}\033[m";;

        RESET)echo -n -e "\033[m${*}";;

	*)    echo -n -e "$*";;
    esac
}


#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Colors Strings for Display 
#P #
#P # Encapsulates the input-string with appropriate escape sequences for
#P # colored output. Therefore it is checked whether XTERM is set, and 
#P # only than proceeded.
#P #
#P # Operates on STATEs rather than explicitly defined colors. 
#P #
#P # REMARK:
#P #   Due to performance reasons for parts of common trace-output the 
#P #   values are hardcoded within the whole module.
#P #
#P # @param $1: ERR|WNG|INF|TRY
#P #    - ERR: Error, initally:        red(31)
#P #    - WNG: Warning, initially:     magenta(35)
#P #    - INF: Information, initially: green(32)
#P #    - TRY: Trial input, initially: blue(34)
#P # @param $2-*
#P # @return 
#P #  - SUCCESS: 0 - "<esc-color>$2-*<esc-color-reset>" 
#P #  - FAILURE: 1 
#P def setSeverityColor():
#P 	pass
## \cond
#***FUNCEND***
function setSeverityColor () {
    local col=$1;shift
    [ "$UTALM_XTERM" != 0 ]&&echo -n -e "$*"||\
    case $col in
	ERR)echo -n -e "\033[31m${*}\033[m";;
	WNG)echo -n -e "\033[35m${*}\033[m";;
	INF)echo -n -e "\033[32m${*}\033[m";;
	TRY)echo -n -e "\033[34m${*}\033[m";;
	*)    echo -n -e "$*";;
    esac
}


if [ -z "${MYLIBEXECPATH}" ];then
	MYLIBEXECPATH=${_myLIBNAME_libcore%/*/*}
fi

MYHOST=`uname -n`
if [ -z $(gwich getCurOS.sh 2>/dev/null) ];then
	P=${_myLIBNAME_libcore%/*/*/*}/bin
	P=${P//\/\//\/}
	P=${P//\/\//\/}
	if  [ -e "${P}/getCurOS.sh" ];then
		export PATH=$PATH:${P}
	fi
fi


#Basic OS info for variant decisions.
MYOS=${MYOS:-`getCurOS.sh`}
MYOSREL=${MYOSREL:-`getCurOSRel.sh`}
MYDIST=${MYDIST:-`getCurDistribution.sh`}
MYREL=${MYREL:-`getCurRelease.sh`}
MYARCH=${MYARCH:-`getCurArch.sh`}

MYUID=$USER
MYGID=`getCurGID.sh`
MYPID=$$
MYPPID=$PPID

MYACCOUNT=${USER}@${MYHOST}

DATE=`date +"%Y.%m.%d"`
TIME=`date +"%H:%M:%S"`
HOUR=${TIME%%:*};
#DATETIME=`date +"%Y%m%d%H%M%S"`
DATETIME="${DATE//.}${TIME//:}"
DAYOFWEEK=`date +"%u"`


#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Basic trace with control. 
#P #
#P # Displays string, when DBG is set.
#P # @param $1: Display string
#P def displayIt():
#P 	pass
## \cond
#***FUNCEND***
function displayIt () {
	if [ "$DBG" == 1 ];then
		echo ${LINENO}:$*
	else
		if [ "$SILENT" == 0 ];then
			echo ${LINENO}:$*
		fi
	fi
}


fi #*** prevent multiple inclusion
## \endcond
