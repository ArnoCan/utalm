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

if [ -z "$__LIBCORE__" ];then #*** prevent multiple inclusion
__LIBCORE__=1 #*** prevent multiple inclusion

_myLIBNAME_libcore="${BASH_SOURCE}"
_myLIBVERS_libcore="03.01.009"

#MODULEBEG###############################################################
#NAME:
#  libcore
#
#TYPE:
#  bash-function-library
#
#DESCRIPTION:
#  Core functions early required. 
#
#EXAMPLE:
#
#PARAMETERS:
#
#OUTPUT:
#  RETURN:
#  VALUES:
#
#MODULEEND###############################################################



#FUNCBEG###############################################################
#NAME:
#  coreGetLibPathname
#
#TYPE:
#  bash-function
#
#DESCRIPTION:
#  Finds shell library:
#
#  0. LIBPATH
#  1. LIBEXECPATH
#  2. PATH
#  3. HOME/lib
#
#PARAMETERS:
# $1: libname
#
#OUTPUT:
#  RETURN:
#  VALUES:
#     Returns absolute pathname.
#
#FUNCEND###############################################################
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




#FUNCBEG###############################################################
#NAME:
#  setFontAttrib
#
#TYPE:
#  bash-function
#
#DESCRIPTION:
#  Encapsulates the input-string with appropriate escape sequences for
#  atributes of charachter representation.
#
#  REMARK:
#    Due to performance reasons for parts of common trace-output the 
#    values are hardcoded within the whole module.
#  
#EXAMPLE:
#
#PARAMETERS:
#  $1: BOLD|UNDL|
#      FBLACK|FRED|FGREEN|FYELLOW|FBLUE|FMAGENTA|FCYAN|FWHITE
#      BBLACK|BRED|BGREEN|BYELLOW|BBLUE|BMAGENTA|BCYAN|BWHITE
#      RESET
#  $2-*
#
#OUTPUT:
#  RETURN:
#    0: OK
#    1: NOK
#  VALUES:
#    "<esc-color>$2-*<esc-color-reset>"
#
#FUNCEND###############################################################
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


#FUNCBEG###############################################################
#NAME:
#  setSeverityColor
#
#TYPE:
#  bash-function
#
#DESCRIPTION:
#  Encapsulates the input-string with appropriate escape sequences for
#  colored output. Therefore it is checked whether XTERM is set, and 
#  only than proceeded.
#
#  Operates on STATEs rather than explicitly defined colors. 
#
#  REMARK:
#    Due to performance reasons for parts of common trace-output the 
#    values are hardcoded within the whole module.
#  
#EXAMPLE:
#
#PARAMETERS:
#  $1: ERR|WNG|INF|TRY
#
#      ERR: Error, initally:        red(31)
#      WNG: Warning, initially:     magenta(35)
#      INF: Information, initially: green(32)
#      TRY: Trial input, initially: blue(34)
#
#  $2-*
#OUTPUT:
#  RETURN:
#    0: OK
#    1: NOK
#  VALUES:
#    "<esc-color>$2-*<esc-color-reset>"
#
#FUNCEND###############################################################
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


function displayIt () {
	if [ "$DBG" == 1 ];then
		echo $*
	else
		if [ "$SILENT" == 0 ];then
			echo $*
		fi
	fi
}


fi #*** prevent multiple inclusion
