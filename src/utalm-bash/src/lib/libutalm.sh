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
if [ -z "$__UnifiedTraceAndLogManager__" ];then #*** prevent multiple inclusion
__UnifiedTraceAndLogManager__=1 #*** prevent multiple inclusion

if [ -e ${BASH_SOURCE%/*}/bootstrap/bootstrap-03.01.009.sh ];then
	. ${BASH_SOURCE%/*}/bootstrap/bootstrap-03.01.009.sh
else
	. ${BASH_SOURCE%/*}/../bin/bootstrap/bootstrap-03.01.009.sh
fi
. ${BASH_SOURCE%/*}/core/libcore-03.01.009.sh

_myLIBNAME_UnifiedTraceAndLogManager="${BASH_SOURCE}"
_myLIBVERS_UnifiedTraceAndLogManager="03.01.001"

#shopt -s nullglob
#shopt -s extglob

#
#Set some common basic definitions.
#

#if not yet initialized, but pre-defined, than set it
if [ -z "${MYLIBPATH}" ];then
    MYLIBPATH=${HOME}/lib
fi
MYLIBPATH=${MYLIBPATH//\/\//\/}
MYLIBPATH=${MYLIBPATH//\/\//\/}

#moment of truth, where it is required to be set
if [ ! -d "${MYLIBPATH}" -o ! -e "${MYLIBPATH}/libutalm.sh" ];then
	MYLIBPATH=${MYLIBPATH}/lib
	if [ ! -d "${MYLIBPATH}" -o ! -e "${MYLIBPATH}/libutalm.sh" ];then
	  echo "${BASH_SOURCE##*/}:$LINENO:ERROR:${MYCALLNAME}-Missing:MYLIBPATH=${MYLIBPATH}"
	  echo "${BASH_SOURCE##*/}:$LINENO:ERROR:Required to point to the root of the"
	  echo "${BASH_SOURCE##*/}:$LINENO:ERROR:library to be used."
	  exit 1
	fi
fi

#make it absolute
if [ -n "${MYLIBPATH##/*}" ];then
    cd "${MYLIBPATH}"
    MYLIBPATH=${PWD}
    cd -
fi

MYLANG=${MYLANG:-$LANG}
case ${MYLANG} in
#    de*|De*|DE*) MYLANG=de;;
    en*|En*|EN*) MYLANG=en;;
    *)           MYLANG=en;;
esac


MYDOCBASE=${MYDOCBASE:-$HOME/doc}
if [ ! -d "${MYDOCBASE}" ];then
    echo "${MYCALLNAME}:$LINENO:ERROR:Missing:MYDOCBASE=${MYDOCBASE}"
    exit 1
fi


MYCONFPATH=${MYCONFPATH:-$HOME/conf}
if [ ! -d "${MYCONFPATH}" ];then
  echo "${MYCALLNAME}:$LINENO:ERROR:Missing:MYCONFPATH=${MYCONFPATH}"
  exit 1
fi

################################################################
#               Default definitions - 1/2                      #
################################################################
#
#For now 16bit-array, to be used in level-mode or match-mode.
#

#
#levels
#
export      D_UI=$((2#1))
export    D_FLOW=$((2#10))
export     D_UID=$((2#100))
export    D_DATA=$((2#1000))
export   D_MAINT=$((2#10000))
export   D_FRAME=$((2#100000))
export     D_SYS=$((2#1000000))
export    D_STAT=$((2#10000000000000))
export     D_TST=$((2#100000000000000))
export    D_BULK=$((2#1000000000000000))

#
#subsystems
#
export    S_CONF=$((2#1))
export     S_BIN=$((2#10))
export     S_LIB=$((2#100))
export    S_CORE=$((2#1000))
export     S_GEN=$((2#10000))
export     S_CLI=$((2#100000))
export     S_X11=$((2#1000000))
export     S_VNC=$((2#10000000))
export    S_QEMU=$((2#100000000))
export     S_VMW=$((2#1000000000))
export     S_XEN=$((2#10000000000))
export      S_PM=$((2#100000000000))
export     S_KVM=$((2#1000000000000))
export     S_RDP=$((2#10000000000000))
export    S_VBOX=$((2#100000000000000))

#
#ALL4all
#
export     D_ALL=$((16#ffff))

#mode
M=4;

#debug
DBG=0;

#info
INF=2;

#warning
WNG=2;

#Debugging
C_DARGS=;

#file-scope-list
F=0;
FLST=;
I=1;

#print final interface-pre-exec data
#<level>: prints
C_PFEXE=;

#FUNCBEG###############################################################
#NAME:
#  fetchDBGArgs
#
#TYPE:
#  bash-function
#
#DESCRIPTION:
#
#EXAMPLE:
#
#PARAMETERS:
#
#OUTPUT:
#  RETURN:
#
#  VALUES:
#
#FUNCEND###############################################################
function fetchDBGArgs () {
    if [ -n "`echo ${*}| sed -n 's/([^)]*)//g;s/-d /1/p'`" ];then
	C_DARGS=`echo " ${*} "| sed -n 's/^.*-d  *\([^ \t)]*\)[ \t)].*$/\1/p'`
	C_DARGS=${C_DARGS%%\%*};
	local i=;
	local KEY=;
	local ARG=;
	for i in ${C_DARGS//[,()]/ };do
	    KEY=`echo ${i%%:*}|tr '[:lower:]' '[:upper:]'`
	    ARG=`echo ${i}|awk -F':' '{print $2}'`
	    case $KEY in
		FILELIST|F)
		    if [ -z "${ARG}" ];then
 			echo "requires numeric value:$KEY">&2
			exit 1;
		    fi
		    FLST=${ARG//[eE][xX][cC][lL][uU][dD][eE]/};
		    if [ "$FLST" != "$ARG" ];then
			I=0;
		    else
			FLST=${FLST//[iI][nN][cC][lL][uU][dD][eE]/};
			if [ "$FLST" != "$ARG" ];then
			    I=1;
			fi
		    fi
                    F=1;
		    ;;
		SUBSYSTEM|S)
		    LVL=${ARG};
		    case ${LVL} in
			S_CONF|CONF)LVL=$((2#1));;
			S_BIN|BIN)LVL=$((2#10));;
			S_LIB|LIB)LVL=$((2#100));;
			S_CORE|CORE)LVL=$((2#1000));;
			S_GEN|GEN)LVL=$((2#10000));;
			S_CLI|CLI)LVL=$((2#100000));;
			S_X11|X11)LVL=$((2#1000000));;
			S_VNC|VNC)LVL=$((2#10000000));;
			S_QEMU|QEMU)LVL=$((2#100000000));;
			S_VMW|VMW)LVL=$((2#1000000000));;
			S_XEN|XEN)LVL=$((2#10000000000));;
			S_PM|PM)LVL=$((2#100000000000));;
			S_KVM|KVM)LVL=$((2#1000000000000));;
			S_RDP|RDP)LVL=$((2#10000000000000));;
			S_VBOX|VBOX)LVL=$((2#100000000000000));;
			*)
			    if [ -n "${LVL//[0-9]/}" ];then
				echo "requires numeric value:$KEY">&2
				exit 1;
			    fi
			    ;;
		    esac
		    S=$LVL;
		    ;;
		PATTERN|P)M=1;;
		MIN)M=2;;
		MAX)M=4;;
		WARNING|W)
		    export WNG=${ARG};
		    if [ -n "${WNG//[0-9]/}" ];then
			echo "requires numeric value:$KEY">&2
			exit 1;
		    fi
		    ;;
		INFO|I)
		    export INF=${ARG};
		    if [ -n "${I//[0-9]/}" ];then
			echo "requires numeric value:$KEY">&2
			exit 1;
		    fi
		    ;;
		LEVEL|L)
		    export LVL=${ARG};
		    case ${LVL} in
		        D_UI|UI)LVL==$((2#1));;
			D_FLOW|FLOW)LVL=$((2#10));;
			D_UID|UID)LVL=$((2#100));;
			D_DATA|DATA)LVL=$((2#1000));;
			D_MAINT|MAINT)LVL=$((2#10000));;
			D_FRAME|FRAME)LVL=$((2#100000));;
			D_SYS|SYS)LVL=$((2#1000000));;
			D_STAT|STAT)LVL=$((2#10000000000000));;
			D_TST|TST)LVL=$((2#100000000000000));;
			D_BULK|BULK)LVL=$((2#1000000000000000));;
			*)
			    if [ -n "${LVL//[0-9]/}" ];then
				echo "requires numeric value:$KEY">&2
				exit 1;
			    fi
			    ;;
		    esac
		    DBG=$LVL;
		    ;;
		[0-9]*)
		    DBG=$KEY;
		    if [ -n "${DBG//[0-9]/}" ];then
			echo "requires numeric value:$KEY">&2
			exit 1;
		    fi
		    ;;
		ALL)DBG=$D_ALL;;
		PRINTFINAL|PFIN|PF)
		    LVL=${ARG:-0};
		    case ${LVL} in
		    D_UI|UI)LVL==$((2#1));;
			D_FLOW|FLOW)LVL=$((2#10));;
			D_UID|UID)LVL=$((2#100));;
			D_DATA|DATA)LVL=$((2#1000));;
			D_MAINT|MAINT)LVL=$((2#10000));;
			D_FRAME|FRAME)LVL=$((2#100000));;
			D_SYS|SYS)LVL=$((2#1000000));;
			D_STAT|STAT)LVL=$((2#10000000000000));;
			D_TST|TST)LVL=$((2#100000000000000));;
			D_BULK|BULK)LVL=$((2#1000000000000000));;
			*)
			    if [ -n "${LVL//[0-9]/}" ];then
				echo "requires numeric value:$KEY">&2
				exit 1;
			    fi
			    ;;
		    esac
		    export C_PFEXE=$LVL;
		    ;;
		H|HELP)
		    cat <<EOF
UnifiedTraceAndLogManager-bash: libutalm.sh

CALL: 
   ...-d [DebugOptions]...
   ...--debug=[DebugOptions]...

OPTIONS:
   FILELIST|F
   SUBSYSTEM|S
      S_CONF|CONF
      S_BIN|BIN
      S_LIB|LIB
      S_CORE|CORE
      S_GEN|GEN
      S_CLI|CLI
      S_X11|X11
      S_VNC|VNC
      S_QEMU|QEMU
      S_VMW|VMW
      S_XEN|XEN
      S_PM|PM
      S_KVM|KVM
      S_RDP|RDP
      S_VBOX|VBOX
      [0-9]*
   PATTERN|P
   MIN
   MAX
   WARNING|W
   INFO|I
   LEVEL|L|PRINTFINAL|PFIN|PF
      D_UI|UI
      D_FLOW|FLOW
      D_UID|UID
      D_DATA|DATA
      D_MAINT|MAINT
      D_FRAME|FRAME
      D_SYS|SYS
      D_STAT|STAT
      D_TST|TST
      D_BULK|BULK
      [0-9]*
   [0-9]*
   ALL
   H|HELP
   
EOF
		    exit 0;
		    ;;
		*)
		    echo "DBG:unknown value:$KEY">&2
		    exit 1;
		    ;;
	    esac
	done
	C_DARGS=" -d ${C_DARGS} "
	DARGS=" ${C_DARGS} "
    fi
}
fetchDBGArgs $*

if [ -n "`echo $*| sed -n 's/-y/1/p'`" ];then
    export CTYS_XTERM=0;
fi


#FUNCBEG###############################################################
#NAME:
#  doDebug
#
#TYPE:
#  bash-function
#
#DESCRIPTION:
#  Returns wheter debug level matches. If some specific
#  actions to be done. E.g. evaluating time-intensive
#  debug actions for tests.
#
#   -> doDebug <subsys> <dbg-level> <line> <file>
#
#EXAMPLE:
#
#PARAMETERS:
#
#OUTPUT:
#  RETURN:
#    0: Debug it.
#    1: No debug.
#  VALUES:
#
#FUNCEND###############################################################
function doDebug  () {
    ((DBG>0))||return 1;
    local s=$1;shift;
    [ -n "${S}" ]&&{ ((S&s))||return 1; }
    local l=$1;shift;
    local L=$1;shift;
    local f=${1%/*/*};f=${1#$f\/};shift;
    if((M&4&&DBG>l));then echo -e "${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:$l:DBG>on">&2;return 0;fi
    if((M&2&&DBG<l));then echo -e "${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:$l:DBG<on">&2;return 0;fi
    if((M&1&&DBG&l));then echo -e "${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:$l:DBG&on">&2;return 0;fi
    return 1;
}



#FUNCBEG###############################################################
#NAME:
#  printDBG
#
#TYPE:
#  bash-function
#
#DESCRIPTION:
#  Prints only when called with more than one option and matches defined 
#  number.
#
#   -> printDBG <subsys> <dbg-level> <line> <file> <message>
#
#  implementation priority: PERFORMANCE
#
#EXAMPLE:
#PARAMETERS:
#OUTPUT:
#  RETURN:
#  VALUES:
#FUNCEND###############################################################
function printDBG {
    local r=$?;
    ((DBG>0))||return $r;
    local s=$1;shift;
    [ -n "${S}" ]&&{ ((S&s))||return $r; }
    local l=$1;shift;
    local L=$1;shift;
    local f=${1%/*/*};f=${1#$f\/};shift;
    ((F^1))&&{
	((M&4&&DBG>l))&&{ echo -e "${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:$s:$l:$*">&2;return $r; }
	((M&2&&DBG<l))&&{ echo -e "${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:$s:$l:$*">&2;return $r; }
	((M&1&&DBG&l))&&{ echo -e "${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:$s:$l:$*">&2;return $r; }
    }||{ [  "$I" == 1 -a "${FLST//$f/}" != "${FLST}" ]&&{
	    ((M&4&&DBG>l))&&{ echo -e "${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:$s:$l:$*">&2;return $r; }
	    ((M&2&&DBG<l))&&{ echo -e "${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:$s:$l:$*">&2;return $r; }
	    ((M&1&&DBG&l))&&{ echo -e "${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:$s:$l:$*">&2;return $r; }
	}
    }||{ [ "$I" == 0 -a "${FLST//$f/}" == "${FLST}" ]&&{
	    ((M&4&&DBG>l))&&{ echo -e "${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:$s:$l:$*">&2;return $r; }
	    ((M&2&&DBG<l))&&{ echo -e "${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:$s:$l:$*">&2;return $r; }
	    ((M&1&&DBG&l))&&{ echo -e "${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:$s:$l:$*">&2;return $r; }
	}
    }
    return $r
}


#FUNCBEG###############################################################
#NAME:
#  printERR
#
#TYPE:
#  bash-function
#
#DESCRIPTION:
#  Prints errors
#   -> printERR <line> <fname> <code> <message>
#
#EXAMPLE:
#PARAMETERS:
#OUTPUT:
#  RETURN:
#  VALUES:
#FUNCEND###############################################################
function printERR () {
    local r=$?;
    local L=$1;shift;
    local f=${1%/*/*};f=${1#$f\/};shift;
    if((DBG>0));then 
	if [ "$CTYS_XTERM" == 1  ];then local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:ERROR:$1";
	else local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:\033[31mERROR\033[m:$1";fi
    else
	if [ "$CTYS_XTERM" == 1  ];then local b="${MYCALLNAME}:${MYUID}@${MYHOST}:ERROR:$1";
	else local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:\033[31mERROR\033[m:$1";fi
    fi
    shift;echo -e "$b:$*" >&2;
    return $r;
}



#FUNCBEG###############################################################
#NAME:
#  printWNG
#
#TYPE:
#  bash-function
#
#DESCRIPTION:
#  Prints warnings
#   -> printWNG <warning-level> <line> <fname> <code> <message>
#
#EXAMPLE:
#
#PARAMETERS:
#
#OUTPUT:
#  RETURN:
#
#  VALUES:
#
#FUNCEND###############################################################
function printWNG () {
    local r=$?;
    local l=$1;shift;
    ((WNG>l))||return;
    local L=$1;shift;
    local f=${1%/*/*};f=${1#$f\/};shift;
    if((DBG>0));then 
	if [ "$CTYS_XTERM" == 1  ];then local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:WARNING:$1";
	else local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:\033[35mWARNING\033[m:$1";fi
    else
	if [ "$CTYS_XTERM" == 1  ];then local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:WARNING:$1";
	else local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:\033[35mWARNING\033[m:$1";fi
    fi    
    shift;echo -e "$b:$*" >&2;
    return $r;
}




#FUNCBEG###############################################################
#NAME:
#  printINFO
#
#TYPE:
#  bash-function
#
#DESCRIPTION:
#  Prints warnings
#   -> printINFO <info-level> <line> <fname> <code> <message>
#
#EXAMPLE:
#
#PARAMETERS:
#
#OUTPUT:
#  RETURN:
#
#  VALUES:
#
#FUNCEND###############################################################
function printINFO () {
    local r=$?;
    local l=$1;shift;
    ((INF>0))||return;
    local L=$1;shift;
    local f=${1%/*/*};f=${1#$f\/};shift;
    local e=$1;shift;
    local o=;
    ((DBG>0))&&o="${f}:";

    (((M&4&&INF>l)||(M&2&&INF<l)||(M&1&&INF&l)))&&{
      ((CTYS_XTERM==1))&&{
         ((F^1))&&{
            echo -e "${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$o$L:INFO:$e:$*">&2;
	 }||{
            [ \( "$I" == 0 -a "${FLST//$f/}" == "${FLST}" \)  -o  \( "$I" == 1 -a "${FLST//$f/}" != "${FLST}" \) ]&&{
	       echo -e "${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$o$L:INFO:$e:$*">&2;	
            }
         }
      }||{
	((F^1))&&{
	    echo -e "${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$o$L:\033[32mINFO\033[m:$e:$*">&2; 
	}||{ 
            [ \( "$I" == 0 -o  "$I" == 1 \) -a "${FLST//$f/}" != "${FLST}" ]&&{
	       echo -e "${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$o$L:\033[32mINFO\033[m:$e:$*">&2;
	    }
	}
      }
    }
    return $r;
}



#FUNCBEG###############################################################
#NAME:
#  printFINALCALL
#
#TYPE:
#  bash-function
#
#DESCRIPTION:
#  Prints final call strings
#   -> printFINALCALL <level> <line> <fname> <title> <exec-or-call-string>
#
#EXAMPLE:
#
#PARAMETERS:
#
#OUTPUT:
#  RETURN:
#
#  VALUES:
#
#FUNCEND###############################################################
function printFINALCALL () {
    local r=$?;
    local l=$1;shift;
    [ -n "$C_PFEXE" ]&&((C_PFEXE>=l))||return $r;
    local L=$1;shift;
    local f=${1%/*/*};f=${1#$f\/};shift;
    local t=${1};shift;
    local a=${*//  / };
    if((DBG>0));then 
	if [ "$CTYS_XTERM" == 1  ];then local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:PRINT:\n$t\n--->\n${a//  / }\n<---";
	else local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:\033[32mPRINT\033[m:\n\033[1m\033[4m$t\033[m\n\033[1m===>\033[m\n${a//  / }\n\033[1m<===\033[m";fi
    else
	if [ "$CTYS_XTERM" == 1  ];then local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:PRINT:\n$t\n--->\n${a//  / }\n<---";
	else local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:\033[32mPRINT\033[m:\n\033[1m\033[4m$t\033[m\n\033[1m===>\033[m\n${a//  / }\n\033[1m<===\033[m";fi
    fi
    shift; echo -e "$b" >&2;
    return $r;
}


#FUNCBEG###############################################################
#NAME:
#  callErrOutWrapper
#
#TYPE:
#  bash-function
#
#DESCRIPTION:
#  Fetched the User-ID and Group-UID of primary group,
#  as string in the format:
#
#    <uid>;<guid>
#
#EXAMPLE:
#
#GLOBAL:
#  CTYS_NOCALLWRAPPER
#
#PARAMETERS:
#  $1:    LINENO of caller
#  $2:    BASH_SOURCE of caller
#  $3-*:  The call to be wrapped
#
#
#OUTPUT:
#  RETURN:
#
#  VALUES:
#
#FUNCEND###############################################################
function callErrOutWrapper () {
    printDBG $S_LIB ${D_BULK} $LINENO $BASH_SOURCE "$FUNCNAME:<${@}>"

    local _originLine=$1;shift
    local _originFile=$1;shift
    local _cli=$*
    local _res=0
    printDBG $S_LIB $D_BULK $_originLine "$_originFile" 0 "$FUNCNAME:<${@}>"

    if [ -n "${CTYS_NOCALLWRAPPER}" ];then
	${_cli}
	return $?
    fi

    exec 3>&1
    exec 4>&2
    local _buf=`{ eval "${_cli}"; } 2>&1 1>&3;echo -n "_-_-_$?";`
    printDBG $S_LIB $D_BULK $_originLine "$_originFile" "$FUNCNAME:A-_buf=<${_buf}>"
    _res="${_buf##*_-_-_}"
    if [ -n "${_res//[0-9]/}" ];then
	printERR $LINENO $BASH_SOURCE 1 "${FUNCNAME}:Possible internal error, but seems recoverable, continue:"
	printERR $LINENO $BASH_SOURCE 1 "${FUNCNAME}:=>_buf=<${_buf}>"
	_res=1;
    fi

    _buf="${_buf%_-_-_*}"

    printDBG $S_LIB ${D_BULK} $_originLine "$_originFile" "$FUNCNAME:B-_buf=<${_buf}>"
    exec 3>&-
    exec 4>&-

    echo ${_buf}

    local _rd=;
    [ "$CTYS_XTERM" == 0 ]\
      &&{ [ "$_res" == 0 ]&&_rd="\033[32m OK \033[m"||_rd="\033[31m NOK \033[m"; }\
      ||{ [ "$_res" == 0 ]&&_rd=" OK "||_rd=" NOK "; }

    printDBG $S_LIB ${D_BULK} $_originLine "$_originFile" "$FUNCNAME:_res=<${_rd}>"
    printDBG $S_LIB ${D_SYS} $_originLine "$_originFile" "$FUNCNAME:`setSeverityColor TRY \"call(${_cli})\"` => [ ${_rd} ]"
    return $_res
}


fi #*** prevent multiple inclusion
