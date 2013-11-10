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
#$Header$
#
##
## \endcond
##
## @name core
## @file
## @brief Core functions early required. 
##
## @ingroup libutalm_core
## \cond
##

if [ -z "$__LIBCORE__" ];then #*** prevent multiple inclusion

## \endcond
## __LIBCORE__
# Set to "1" when sourced.
# Prevents multiple inclusion
__LIBCORE__=1 #*** prevent multiple inclusion
## \cond

## \endcond
## _myLIBNAME_libcore
# Pathname of current libcore
_myLIBNAME_libcore="${BASH_SOURCE}"
## \cond

## \endcond
## _myLIBVERS_libcore
# Version of current libcore
_myLIBVERS_libcore="03_01_009"
## \cond


#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Finds shell library:
#P #
#P #  	0. LIBPATH
#P #  	1. LIBEXECPATH
#P #  	2. PATH
#P #  	3. HOME/lib
#P #
#P # @param $1: libname
#P # @return Returns absolute pathname.
#P # @ingroup core
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


#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # to be documented
#P #
#P # @ingroup core
#P def coreRegisterLib():
#P 	pass
## \cond
#***FUNCEND***
function coreRegisterLib () {
	bootstrapRegisterLib $*
}


#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # to be documented
#P #
#P # @ingroup core
#P def coreListLib():
#P 	pass
## \cond
#***FUNCEND***
function coreListLib () {
	bootstrapListLib $*
}

#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # ANSI escaping of displayed characters.
#P #
#P # Encapsulates the input-string with appropriate escape sequences for
#P # attributes of character representation - \ref UTALM_XTERM.
#P #
#P # REMARK:
#P #   Due to performance reasons for parts of common trace-output the 
#P #   values are hard-coded within the whole module.
#P #
#P # @param $1: (
#P #      <br />BOLD|UNDL|RESET|
#P #      <br />FBLACK|FRED|FGREEN|FYELLOW|FBLUE|FMAGENTA|FCYAN|FWHITE
#P #      <br />BBLACK|BRED|BGREEN|BYELLOW|BBLUE|BMAGENTA|BCYAN|BWHITE
#P #      <br />)
#P # <br />BOLD  : bold
#P # <br />UNDL  : underline
#P # <br />RESET : reset to terminal default
#P # <br />F*    : foreground
#P # <br />B*    : background
#P # 
#P # @param $2-*
#P # @return 
#P #  - SUCCESS: 0 - "<esc-color>$2-*<esc-color-reset>" 
#P #  - FAILURE: 1 
#P # @ingroup core
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
#P # Colors for displayed string labels of standard respond states. 
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
#P # @ingroup core
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


#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Encapsulates various OS and calls for getting hostname/hostip 
#P #
#P # Encapsulates primarily the call of hostname, gethostip, and 
#P # when fails, reads systems /etc/hosts or lmhosts.conf.
#P # This particularly ensures operability in unmanaged networks by 
#P # evaluating the file databases.
#P #  
#P # @param $1: DNS|IP
#P # @return 
#P #  - SUCCESS: 0 - "<dns-hostname>|<dotted-ip-address>" 
#P #  - FAILURE: 1 
#P # @ingroup core
#P def getMyHost($1):
#P 	pass
## \cond
#***FUNCEND***
function getMyHost () {
    local _h=$(uname -n);
    if [ "$1" == DNS ];then
		echo -n $_h
		return 0
	fi
    if [ "$1" != IP ];then
    	echo "ERROR:Unknown type:$1">&2
    	return 1
	fi
    #special gethostip
    which gethostip >/dev/null 2>/dev/null
    if [ $? -eq 0 ];then
	gethostip "$_h" >/dev/null 2>/dev/null
	ret=$?;
	if [ $ret -eq 0 ];then
	    local myAddr=$(gethostip "$_h"|awk '{print $2}');
	    if [ -n "$_h" ];then
			local myResolv=GETHOSTIP
	    fi
	fi
    fi

    #special hostname
    which hostname >/dev/null 2>/dev/null
    if [ $? -eq 0 ];then
		hostname "$_h" >/dev/null 2>/dev/null
		ret=$?;
		if [ $ret -eq 0 ];then
	    	local myAddr=$(gethostip "$_h"|awk '{print $2}');
	    	if [ -n "$_h" ];then
				local myResolv=GETHOSTIP
	    	fi
		fi
    fi

    #additional specials
    if [ -z "$_h" ];then
		case $MYOS in
		    CYGWIN)
				myAddr=$(${CTYS_NSLOOKUP} "$_h" |awk -F':'  -v d=$D -v h="$inp"  '$2~h{x=1;}x==1&&/Address/{x=2;gsub(" ","",$2);printf("%s",$2);}');
				if [ -n "$myAddr" ];then
				    myResolv=CYGWIN
				else
				    ret=1;
				fi
			;;
		esac
    fi

    #last chance
    case $myResolv in
	CYGWIN)
	    echo -n "$myAddr"
	    ;;
	GETHOSTIP)
	    echo -n "$myAddr"
	    ;;
	FILE)
	    local myResolv=FILE
	    local myHosts=/etc/hosts
	    if [ ! -e "$myHosts" ];then myHosts="";myResolv="";fi
    	local myAddr=$(cat $myHosts|awk '
			{gsub("#.*$","");}
			{gsub("^[^:]*:.*:.*$","");}
			$1~/^ *'"$_h"'/{print $2}
			$0~/'"$_h"'/&&$1!~/^ *'"$_h"'/{print $1}
		' )
	    echo -n "$myAddr"
	    ;;
	*)
	    ret=1
	    ;;
    esac
    return $ret;
}

## \endcond
## MYHOST
# Name of current node
MYHOST="$(uname -n)"
## \cond

## \endcond
## MYHOSTIP
# dotted IP address
MYHOSTIP="$(getMyHost IP)"
## \cond


#Basic OS info for variant decisions.
MYOS=${MYOS:-`getCurOS.sh`}
MYOSREL=${MYOSREL:-`getCurOSRel.sh`}
MYDIST=${MYDIST:-`getCurDistribution.sh`}
MYREL=${MYREL:-`getCurRelease.sh`}
MYARCH=${MYARCH:-`getCurArch.sh`}

MYNAME=$USER
MYUID=$UID
MYGID=$GROUPS
MYGNAME=`getCurGID.sh`
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
#P # Basic trace with control - could also be pasted into standalone utilities. 
#P #
#P # Displays string, when DBG is set.
#P # @param $1: Display string
#P # @ingroup core
#P def displayIt():
#P 	pass
## \cond
#***FUNCEND***
function displayIt () {
	[[ "$DBGX" == 1 ]]&&echo ${LINENO}:$*
}


fi #*** prevent multiple inclusion
## \endcond
