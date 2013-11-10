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
## @name bootstrap
## @file
## @brief Bootstrap functions
##
##  Used during bootstrap of current called script in order to find and
##  assign the installed runtime environment. 
##
##  Has to be located in the same directory as the callee gwhich is
##  going to set it's environment.
## \cond
##

if [ -z "$__BOOTSTRAP__" ];then #*** prevent multiple inclusion

if [ -z "$_STARTDATE" ];then
## \endcond
## _STARTDATE
# Set date of process start
_STARTDATE="$(date +%Y%m%d)"
## \cond
export _STARTDATE
fi

if [ -z "$_STARTTIME" ];then
## \endcond
## _STARTTIME
# Set time of process start
_STARTTIME="$(date +%H%M%S)"
## \cond
export _STARTTIME 
fi

## \endcond
## __BOOTSTRAP__
# Set to "1" when sourced.
# Prevents multiple inclusion
__BOOTSTRAP__=1 #*** prevent multiple inclusion
## \cond

## \endcond
## _myLIBNAME_bootstrap
# Pathname of current bootstrap file
_myLIBNAME_bootstrap="${BASH_SOURCE}"
## \cond

## \endcond
## _myLIBVERS_bootstrap
# Version of current bootstrap file
_myLIBVERS_bootstrap="03_01_009"
## \cond


declare -a LIBMAN_NAME
declare -a LIBMAN_VERS

#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Registers a standard lib. 
#P #
#P # Adds an entry to info array, where all libraries will be registered
#P # with basic information, which is for now:
#P #
#P #	bootstrapRegisterLib <pkg-name> <pkg-version>
#P #
#P # @param $1 pkg-name 
#P # @param $2 pkg-version 
#P #
#P # @return with sum
#P #
#P # @ingroup bootstrap
#P def bootstrapRegisterLib($1,$2):
#P 	pass
## \cond
#***FUNCEND***
function bootstrapRegisterLib () {
  local _s=${#LIBMAN_NAME[@]}

  if [ -n "$1" ];then
    LIBMAN_NAME[$_s]="${1##/*/}"
  fi
  if [ -n "$2" ];then
    LIBMAN_VERS[$_s]="$2"
  fi
}

#
#the initial entry
bootstrapRegisterLib "${_myLIBNAME_bootstrap}" "${_myLIBVERS_bootstrap}"

#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Lists all entries from LIBMAN_NAME[] and LIBMAN_VERS[]. 
#P # This is foreseen to be applied in test process as well
#P # as part of the online help.
#P #
#P # @ingroup bootstrap
#P def bootstrapListLib():
#P 	pass
## \cond
#***FUNCEND***
function bootstrapListLib () {
    local _s=${#LIBMAN_NAME[@]}

    echo "LIBRARIES(static-loaded - generic):"
    echo
    printf "  %02s   %-43s%s\n" "Nr" "Library" "Version"
    echo "  ------------------------------------------------------------"
    for((i=0;i<_s;i++));do
	printf "  %02d   %-43s%s\n" $i ${LIBMAN_NAME[$i]} ${LIBMAN_VERS[$i]}
    done
    echo
}


#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Converts pathnames to absolute path with replaced symbolic links. 
#P #
#P #  Used during bootstrap of current called script in order to find and
#P #  assign the installed runtime environment. 
#P #  Therefore the "physical" path to the call directory is expanded
#P #  thus the well defined relative paths of project convention could
#P #  be evaluated.
#P #
#P #  The exception is, that hard links are not treated specially, thus 
#P #  symbolic links has to be used instead.
#P #
#P #  Has to be located in the same directory as the callee gwhich is
#P #  going to set it's environment.
#P #
#P # @param $1 Argument is checked for beeing a sysmbolic link, and
#P #     if so the target will be evaluated and returned,
#P #     else input is echoed.
#P #
#P # @return resolved links and absolute
#P #   Returns real target for sysmbolic links, else the 
#P #   pathname itself.
#P # @ingroup bootstrap
#P def bootstrapGetRealPathname($1):
#P 	pass
## \cond
#***FUNCEND***
function bootstrapGetRealPathname () {
    local _maxCnt=20;
    local _realPath=${1}
    local _cnt=0

    if [ "${_realPath%%/*}" == "." ];then
	_realPath="${PWD}${_realPath#.}"
    fi
    _realPath="${_realPath/\/.\///}"

    while((_cnt<_maxCnt)) ;do    
	if [ -h "${_realPath}" ];then
            _realPath=`ls -l ${1}|awk '{print $NF}'`
	else
	    break;
	fi
	let cnt++;
    done
    if((_maxCnt==0));then
	echo "$BASH_SOURCE:$LINENO:Path could not be evaluated:${1}">&2
	echo "$BASH_SOURCE:$LINENO:INFO: Seems to be a circular-chained sysmbolic link">&2
	echo "$BASH_SOURCE:$LINENO:INFO: Aborted recursion level: ${_maxCnt}">&2
        exit 1
    fi

    echo -n "$_realPath"
}


#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Check initial exec.
#P #
#P # Checks the defined root hook for existence, if not gives extensive hints.
#P #
#P # @ingroup bootstrap
#P def bootstrapCheckInitialPath():
#P 	pass
## \cond
#***FUNCEND***
function bootstrapCheckInitialPath () {
if [ ! -d "${MYLIBPATH}" ];then
  echo "${MYCALLNAME}:$LINENO:ERROR:Missing:MYLIBPATH=${MYLIBPATH}"
cat << EOF1

The installation might be corrupted, here are some hints to prerequisites
to find the required paths for utilities from project "${MYPROJECT}".

  This tool requires the project structure of ${MYPROJECT}:

    ${HOME}/lib/${MYPROJECT}/....
       All installed files of the project.

    ${HOME}/bin/${MYCALLNAME}
       This is expected to be a sysmbolic link to:
       ${HOME}/lib/${MYPROJECT}/bin/${MYCALLNAME}

Else the following environment variable is required to be
set to the containing directory of project:${MYPROJECT}

   UTALM_LIBPATH=/<base-directory>/${MYPROJECT}/{bin,lib,...}

The executables from 

   \${UTALM_LIBPATH}/bin/...

Should be set as a symbolic link to a directory within PATH, e.g.

   \${HOME}/bin/...

The variable assignment is generated as standard value during
installation into $HOME/.profile or $HOME/.bashrc.

EOF1

  exit 1
fi
}

#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Generic and platform independent which.
#P #
#P # The <b>GenericWhich</b> - <b>gwhich</b> - is a generic platform independent wrapper 
#P # for <b>which</b> with awareness of specific path locations and search-order of
#P # standard paths. For example gwhich has the knowledge about specific 
#P # filesystem paths of Linux, Solaris, OpenSolaris, BSD-Variants, and 
#P # Cygwin including native MS-Windows.
#P #
#P # @ingroup bootstrap
#P def gwhich():
#P 	pass
## \cond
#***FUNCEND***
function gwhich () {
    case ${MYOS} in
	SunOS)
	    local _xf=`which $*`;
	    local _ret=$?;
	    case $_xf in
		no*)#solaris
		    return 1;
		    ;;
		*not*found*)#opensolaris
		    return 1;
		    ;;
		*)#opensolaris
		    if [ $_ret -ne 0 ];then
			return 1;
		    fi
		    ;;
	    esac
	    echo -n -e $_xf
	    ;;
	CYGWIN)
	    #requires workaround for PATH error: "which $(which which)"
	    local _xf=;
	    local _ret=;

	    if [ -x "$*" ];then
		echo -n -e $*
		return 0
	    fi

	    local _d=${*%/*}
	    local _b=${*##*/}
	    if [ "$_b" == "$_d" ];then
		_d=;
	    fi
	    _xf=`which $_b 2>/dev/null`;
	    _ret=$?;
	    if [ -z "$_xf" ];then
		_xf=`PATH=$PATH:$_d which $_b 2>/dev/null`;
		_ret=$?;
	    fi
            # let's say: /bin == /usr/bin
#4TEST-4CYGWIN:	    if [ $_ret -eq 0 ];then
	    if [ -n "$_xf" ];then
		if [ -n "$_d" ];then
		    local _dx=${_xf%/*}
		    test "$_d" == "$_dx"
		    _ret=$?;
		    if [ "$_ret" -ne 0 ];then
			if [ "/usr${_xf%/*}" == "$_d" ];then
			    _xf=$_d/$_b;
			    _ret=0;
			fi
		    fi
		fi
		echo -n -e $_xf
	    fi
	    return $_ret
	    ;;
	*)
	    local _xf=;
	    local _ret=;
	    _xf=`which $* 2>/dev/null`;
	    _ret=$?;
	    echo -n -e $_xf
	    return $_ret
	    ;;
    esac
}

export -f gwhich 

#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Locates related configuration file utalm-bash.conf
#P #
#P # @param $1 [EXIT]
#P #     if EXIT in case of failere exit is called.
#P #     else return (==default).
#P #
#P # @ingroup bootstrap
#P def getConfigFile():
#P 	pass
## \cond
#***FUNCEND***
function getConfigFile () {
	local _x=$1;
	case $_x in
		EXIT)shift;;
		*)_x=;
	esac
	if [ -n "$MYCONFIG" ];then
		echo ${MYCONFIG}
		return
	fi
	local _mc=$(bootstrapGetRealPathname ${BASH_SOURCE})
	if [ -e ${_mc%/*/*/*}/conf/utalm-bash.conf ];then
	MYCONFIG=${_mc%/*/*/*}/conf/utalm-bash.conf
	else
		if [ -e ${BLD_ROOT}src/conf/utalm-bash.conf ];then
		MYCONFIG=${BLD_ROOT}src/conf/utalm-bash.conf
		else
			if [ -e ${BLD_ROOT}conf/utalm-bash.conf ];then
			MYCONFIG=${BLD_ROOT}conf/utalm-bash.conf
			else
				if [ -e ${BLD_ROOT}conf/utalm-bash.conf ];then
				MYCONFIG=${BLD_ROOT}conf/utalm-bash.conf
				else
					if [ -e ${HOME}conf/utalm-bash.conf ];then
					MYCONFIG=${HOME}/conf/utalm-bash.conf
					fi
				fi
			fi
		fi
	fi
	if [ -z "$MYCONFIG" ];then
		echo "ERROR:Cannot find utalm-bash.conf">&2
		if [ "$_x" == EXIT ];then exit 1;else return 1;fi
	fi
	echo -n ${MYCONFIG}
}

#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Loads utalm-bash 
#P #
#P # Sources configuration file and loads the utalm-bash environment.
#P # 
#P #  *  . ${CORELIB}/libcore-${_myLIBVERS_bootstrap}.sh
#P #  *  . ${LIBDIR}/libutalm.sh
#P #
#P # @param $1 [EXIT]
#P #     if EXIT in case of failere exit is called.
#P #     else return (==default).
#P #
#P # @ingroup bootstrap
#P def setUTALMbash():
#P 	pass
## \cond
#***FUNCEND***
function setUTALMbash () {
	local _mc=;
	local _x=$1;
	case $_x in
		EXIT)shift;;
		*)_x=;
	esac
	_mc=$(getConfigFile $_x $*)
	if [ -z "$_mc" ];then
		echo "ERROR:Cannot load utalm-bash">&2
		if [ "$_x" == EXIT ];then exit 1;else return 1;fi
	fi
	. $_mc
	_mc=${CORELIB}libcore-${_myLIBVERS_bootstrap}.sh
	. $_mc
	if [ $? -ne 0 ];then
		echo "ERROR:Cannot load libcore:$_mc">&2
		if [ "$_x" == EXIT ];then exit 1;else return 1;fi
	fi
	_mc=${LIBDIR}libutalm.sh
	. $_mc
	if [ $? -ne 0 ];then
		echo "ERROR:Cannot load libutalm:$_mc">&2
		if [ "$_x" == EXIT ];then exit 1;else return 1;fi
	fi

	MYLIBPATH=${MYLIBPATH:-$HOME/lib}
	MYBINPATH=${MYBINPATH:-$HOME/bin}

	MYHELPPATH=${MYHELPPATH:-$MYLIBPATH/help/$MYLANG}
	MYMACROPATH=${MYMACROPATH:-$HOME/conf/macros}
	MYPKGPATH=${MYPKGPATH:-$MYLIBPATH/plugins}
	PATH=${MYLIBEXECPATH:+$MYLIBEXECPATH:}$PATH

	bootstrapCheckInitialPath
	coreRegisterLib
}

fi #*** prevent multiple inclusion
## \endcond