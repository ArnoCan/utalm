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
## @brief Main library of libutalm-bash component
##
## For detailed information on <b>libutalm.sh</b> refer to 
## <b><a href="../../man3/libutalm-bash.html">libutalm-bash(3)</a></b>
## and 
## <b><a href="../../man3/libutalm-make.html">libutalm-make(3)</a></b>
## \cond
#***MODUL_DOXYGEN_END***
#
if [ -z "$__UnifiedTraceAndLogManager__" ];then #*** prevent multiple inclusion
__UnifiedTraceAndLogManager__=1 #*** prevent multiple inclusion

if [ -e ${BASH_SOURCE%/*/*}/conf/utalm-bash.conf ];then
	. ${BASH_SOURCE%/*/*}/conf/utalm-bash.conf
else
	if [ -e ${MYCALLPATH%/*/*}/conf/utalm-bash.conf ];then
		. ${MYCALLPATH%/*/*}/conf/utalm-bash.conf
	else
		if [ -e ${BASH_SOURCE%/*/*/*}/conf/utalm-bash.conf ];then
			. ${BASH_SOURCE%/*/*/*}/conf/utalm-bash.conf
		else
			if [ -e ${BASH_SOURCE%/*/*/*/*}/conf/utalm-bash.conf ];then
				. ${BASH_SOURCE%/*/*/*/*}/conf/utalm-bash.conf
			else
				if [ -e ${HOME}/conf/utalm-bash.conf ];then
					. ${HOME}/conf/utalm-bash.conf
				else
					echo "ERROR:Missing: utalm-bash.conf">&2
					echo "ERROR:FROM:${BASH_SOURCE}">&2
					echo "ERROR:CALL:${PWD}">&2
					exit 1
				fi
			fi
		fi
	fi
fi

if [ -e ${BASH_SOURCE%/*}/bootstrap/bootstrap-03_01_009.sh ];then
	. ${BASH_SOURCE%/*}/bootstrap/bootstrap-03_01_009.sh
else
	. ${BASH_SOURCE%/*}/../bin/bootstrap/bootstrap-03_01_009.sh
fi
if [ -z "$__LIBCORE__" ];then 
. ${BASH_SOURCE%/*}/core/libcore-03_01_009.sh
fi

MYLIBNAME="${BASH_SOURCE##*/}"
MYLIBVERS="03.02.003"

#shopt -s nullglob
#shopt -s extglob

#
#Set some common basic definitions.
#

#**doxygen-workaround***
## \endcond
#P ## @var MYLIBPATH
#P # Root for libraries, default is relative to current.
#P #
#P MYLIBPATH="${BASH_SOURCE%/*}/"
## \cond
#if not yet initialized, but pre-defined, than set it
if [ -z "${MYLIBPATH}" ];then
    MYLIBPATH=${BASH_SOURCE%/*}/
fi
MYLIBPATH=${MYLIBPATH//\/\//\/}
MYLIBPATH=${MYLIBPATH//\/\//\/}

#moment of truth, where it is required to be set
if [ ! -d "${MYLIBPATH}" -o ! -e "${MYLIBPATH}/libutalm.sh" ];then
	MYLIBPATH=${MYLIBPATH%/lib}/lib
	if [ ! -d "${MYLIBPATH}" -o ! -e "${MYLIBPATH}/libutalm.sh" ];then
	  echo "${BASH_SOURCE##*/}:$LINENO:ERROR:${MYCALLNAME}-Missing:MYLIBPATH=${MYLIBPATH}"
	  echo "${BASH_SOURCE##*/}:$LINENO:ERROR:Required to point to the root of the"
	  echo "${BASH_SOURCE##*/}:$LINENO:ERROR:library to be used."
	  exit 1
	fi
fi

#make it absolute
if [ -n "##/*}" ];then
    cd "${MYLIBPATH}"
    MYLIBPATH=${PWD}
    cd -
fi
MYLIBPATHNAME="${MYLIBPATH}/${MYLIBNAME}"

#**doxygen-workaround***
## \endcond
#P ## @var MYLANG
#P # Language - default 'en'
#P #
#P MYLANG="${MYLANG:-$LANG}"
## \cond
MYLANG=${MYLANG:-$LANG}
case ${MYLANG} in
#    de*|De*|DE*) MYLANG=de;;
    en*|En*|EN*) MYLANG=en;;
    *)           MYLANG=en;;
esac


#**doxygen-workaround***
## \endcond
#P ## @var MYDOCBASE
#P # Base for document tree
#P #
#P MYDOCBASE="${MYDOCBASE:-$HOME/doc}"
## \cond
MYDOCBASE=${MYDOCBASE:-$HOME/doc}
if [ ! -d "${MYDOCBASE}" ];then
    echo "${MYCALLNAME}:$LINENO:ERROR:Missing:MYDOCBASE=${MYDOCBASE}"
    exit 1
fi


#**doxygen-workaround***
## \endcond
#P ## @var MYCONFPATH
#P # Base for configuration files
#P #
#P MYCONFPATH="${MYCONFPATH:-$HOME/conf}"
## \cond
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
export D_RESULTCODE=1
export D_RESULTDATA=2
export D_TESTRESULT=4
export D_TESTDATA=8
export D_TESTDEBUG=16
export D_UI=32
export D_FLOW=64
export D_UID=128
export D_DATA=256
export D_MAINT=512
export D_FRAME=1024
export D_SYS=2048
export D_STAT=4096
export D_MAKE=8192

export D_BULK=4294967296

#
#subsystems
#
export S_CONF=1
export S_BIN=2
export S_LIB=4
export S_CORE=8
export S_GEN=16
export S_CLI=32
export S_X11=64
export S_VNC=128
export S_QEMU=256
export S_VMW=512
export S_XEN=1024
export S_PM=2048
export S_KVM=4096
export S_RDP=8192
export S_VBOX=16384
export S_UTALM=32768

#
#ALL4all
#
export D_ALL=4294967296

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

#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Fetch argv
#P #
#P # Is implicitly called, fetches suboptions for '-d ...'
#P #
#P # For valid options refer to <a href="../../man3/libutalm-bash.html" target="_blank">libutalm-bash(3)</a>
#P #
#P def fetchDBGArgs():
#P 	pass
## \cond
#***FUNCEND***
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
			S_CONF|CONF)LVL=1;;
			S_BIN|BIN)LVL=2;;
			S_LIB|LIB)LVL=4;;
			S_CORE|CORE)LVL=8;;
			S_GEN|GEN)LVL=16;;
			S_CLI|CLI)LVL=32;;
			S_X11|X11)LVL=64;;
			S_VNC|VNC)LVL=128;;
			S_QEMU|QEMU)LVL=256;;
			S_VMW|VMW)LVL=512;;
			S_XEN|XEN)LVL=1024;;
			S_PM|PM)LVL=2048;;
			S_KVM|KVM)LVL=4096;;
			S_RDP|RDP)LVL=8192;;
			S_VBOX|VBOX)LVL=16382;;
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
		        D_UI|UI)LVL==1;;
			D_FLOW|FLOW)LVL=2;;
			D_UID|UID)LVL=4;;
			D_DATA|DATA)LVL=8;;
			D_MAINT|MAINT)LVL=16;;
			D_FRAME|FRAME)LVL=32;;
			D_SYS|SYS)LVL=64;;
			D_STAT|STAT)LVL=128;;
			D_TESTDEBUG|TST)LVL=256;;
			D_BULK|BULK)LVL=512;;
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
		    D_UI|UI)LVL==1;;
			D_FLOW|FLOW)LVL=2;;
			D_UID|UID)LVL=4;;
			D_DATA|DATA)LVL=8;;
			D_MAINT|MAINT)LVL=16;;
			D_FRAME|FRAME)LVL=32;;
			D_SYS|SYS)LVL=64;;
			D_STAT|STAT)LVL=128;;
			D_TESTDEBUG|TST)LVL=256;;
			D_BULK|BULK)LVL=512;;
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
			A=`echo ${ARG}|tr '[:lower:]' '[:upper:]'`
			case $A in
				PATHS)
					echo "INFO:">&2
					echo "INFO:Current library: ${MYLIBPATHNAME}">&2
					echo "INFO:">&2
					echo "INFO:Following could be pre-set by bash-environment:">&2
					echo "INFO:">&2
					echo "INFO:   Using libraries: MYLIBPATH    = ${MYLIBPATH}">&2
					echo "INFO:   Using documents: MYDOCBASE    = ${MYDOCBASE}">&2
					echo "INFO:   Using config:    MYCONFPATH   = ${MYCONFPATH}">&2
					echo "INFO:   Using language:  MYLANG       = ${MYLANG}">&2
					echo "INFO:">&2
					echo "INFO:   Using language:  MANPATH      = ${MANPATH}">&2
					echo "INFO:">&2
					echo "INFO:   Using for html:  BROWSER      = ${BROWSER}">&2
					echo "INFO:   Using for html:  DEFAULT_HELP = ${DEFAULT_HELP}">&2
					echo "INFO:">&2
					echo "INFO:   Using for pdf:   PDFVIEWER    = ${PDFVIEWER}">&2
					echo "INFO:">&2
					exit 0
				    ;;
				HTML)
					if [ -n "$BROWSER" ];then
						local _MYDOC=${DEFAULT_HELP}
						echo "CALL:$BROWSER ${_MYDOC}">&2
						if [ ! -e "${_MYDOC}" ];then
							echo "ERROR:Missing:${_MYDOC}">&2 
							echo "INFO:Check/set MYDOCBASE=${MYDOCBASE}">&2 
							exit 1
						fi
						$BROWSER ${_MYDOC} &
					fi
					exit 0
				    ;;
				PDF)
					if [ -n "$PDFVIEWER" ];then
						local _MYDOC=${MYDOCBASE}/${MYLANG}/pdf/man3/libutalm-bash.pdf
						echo "CALL:$PDFVIEWER ${_MYDOC}">&2
						if [ ! -e "${_MYDOC}" ];then
							echo "ERROR:Missing:${_MYDOC}">&2 
							echo "INFO:Check/set MYDOCBASE">&2 
							exit 1
						fi
						$PDFVIEWER ${_MYDOC} &
					fi
					exit 0
					;;
				MAN)
					echo "INFO:Using documents from:MANPATH=${MANPATH}">&2
					echo "CALL:man -M $MANPATH 3 libutalm-bash">&2
					man -M $MANPATH 3 libutalm-bash
					exit 0
					;;
			esac
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
      D_TESTDEBUG|TST
      D_BULK|BULK
      [0-9]*
   [0-9]*
   ALL
   H|HELP

Special cases:

  - for extended HELP:   $0 -d help:html   
  - for toubleshooting:  $0 -d help:paths
  - extended troubleshooting
    - install devel package
    - call "make test" in install-root, this
      is also done by install package for 
      verification, aou can add "DBG=1" for
      (lots of) verbose output
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
    export UTALM_XTERM=0;
fi

## \endcond
#P ##
#P # Fetch argv
#P #
#P #  Returns wheter debug level matches. If some specific
#P #  actions to be done. E.g. evaluating time-intensive
#P #  debug actions for tests.
#P #
#P #	doDebug <subsys> <dbg-level> <line> <file>
#P #
#P def doDebug():
#P 	pass
## \cond
#***FUNCEND***
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


#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Print trace/log-string
#P # 
#P # Prints a trace/log-string when called with more than one option 
#P # and matches defined number.
#P # 
#P #	printDBG <subsys> <dbg-level> <line> <file> <message>
#P # 
#P # Implementation priority: PERFORMANCE
#P # 
#P # @param $1 subsys
#P # @param $2 dbg-level
#P # @param $3 line
#P # @param $4 file
#P # @param $5 message
#P def printDBG($1,$2,$3,$4,$5):
#P 	pass
## \cond
#***FUNCEND***
function printDBG () {
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


#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Print trace/log-string for errors
#P # 
#P # Prints a trace/log-string when called with more than one option. 
#P # 
#P #	printERR <line> <fname> <code> <message>
#P # 
#P # Implementation priority: PERFORMANCE
#P # 
#P # @param $1 line
#P # @param $2 file
#P # @param $3 code
#P # @param $4 message
#P def printERR($1,$2,$3,$4):
#P 	pass
## \cond
#***FUNCEND***
function printERR () {
    local r=$?;
    local L=$1;shift;
    local f=${1%/*/*};f=${1#$f\/};shift;
    if((DBG>0));then 
	if [ "$UTALM_XTERM" == 1  ];then local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:ERROR:$1";
	else local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:\033[31mERROR\033[m:$1";fi
    else
	if [ "$UTALM_XTERM" == 1  ];then local b="${MYCALLNAME}:${MYUID}@${MYHOST}:ERROR:$1";
	else local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:\033[31mERROR\033[m:$1";fi
    fi
    shift;echo -e "$b:$*" >&2;
    return $r;
}

#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Print trace/log-string for warnings
#P # 
#P # Prints a trace/log-string when called with more than one option 
#P # and matches current level. 
#P # 
#P #	printWNG <warning-level> <line> <fname> <code> <message>
#P # 
#P # Implementation priority: PERFORMANCE
#P # 
#P # @param $1 warning-level
#P # @param $2 line
#P # @param $3 fname
#P # @param $4 code
#P # @param $5 message
#P def printWNG($1,$2,$3,$4,$5):
#P 	pass
## \cond
#***FUNCEND***
function printWNG () {
    local r=$?;
    local l=$1;shift;
    ((WNG>l))||return;
    local L=$1;shift;
    local f=${1%/*/*};f=${1#$f\/};shift;
    if((DBG>0));then 
	if [ "$UTALM_XTERM" == 1  ];then local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:WARNING:$1";
	else local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:\033[35mWARNING\033[m:$1";fi
    else
	if [ "$UTALM_XTERM" == 1  ];then local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:WARNING:$1";
	else local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:\033[35mWARNING\033[m:$1";fi
    fi    
    shift;echo -e "$b:$*" >&2;
    return $r;
}

#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Print trace/log-string for info
#P # 
#P # Prints a trace/log-string when called with more than one option 
#P # and matches current level. 
#P # 
#P #	printINFO <info-level> <line> <fname> <code> <message>
#P # 
#P # Implementation priority: PERFORMANCE
#P # 
#P # @param $1 info-level
#P # @param $2 line
#P # @param $3 fname
#P # @param $4 code
#P # @param $5 message
#P def printINFO($1,$2,$3,$4,$5):
#P 	pass
## \cond
#***FUNCEND***
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
      ((UTALM_XTERM==1))&&{
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

#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Prints final call strings
#P # 
#P # Prints a trace/log-string of a string prepared to be executed when called with more
#P # than one option and matches current level. 
#P # 
#P #	printFINALCALL <level> <line> <fname> <title> <exec-or-call-string>
#P # 
#P # Implementation priority: PERFORMANCE
#P # 
#P # @param $1 level
#P # @param $2 line
#P # @param $3 fname
#P # @param $4 title
#P # @param $5 exec-or-call-string
#P def printFINALCALL($1,$2,$3,$4,$5):
#P 	pass
## \cond
#***FUNCEND***
function printFINALCALL () {
    local r=$?;
    local l=$1;shift;
    [ -n "$C_PFEXE" ]&&((C_PFEXE>=l))||return $r;
    local L=$1;shift;
    local f=${1%/*/*};f=${1#$f\/};shift;
    local t=${1};shift;
    local a=${*//  / };
    if((DBG>0));then 
	if [ "$UTALM_XTERM" == 1  ];then local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:PRINT:\n$t\n--->\n${a//  / }\n<---";
	else local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:\033[32mPRINT\033[m:\n\033[1m\033[4m$t\033[m\n\033[1m===>\033[m\n${a//  / }\n\033[1m<===\033[m";fi
    else
	if [ "$UTALM_XTERM" == 1  ];then local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:PRINT:\n$t\n--->\n${a//  / }\n<---";
	else local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:\033[32mPRINT\033[m:\n\033[1m\033[4m$t\033[m\n\033[1m===>\033[m\n${a//  / }\n\033[1m<===\033[m";fi
    fi
    shift; echo -e "$b" >&2;
    return $r;
}

#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Prints final call strings
#P # 
#P # Prints a trace/log-string of a string prepared to be executed when called with more
#P # than one option and matches current level. 
#P # 
#P #	callErrOutWrapper <line> <fname> <exec-or-call-string>
#P # 
#P # Implementation priority: PERFORMANCE
#P # 
#P # @param $1 line LINENO of caller
#P # @param $2 file BASH_SOURCE of caller
#P # @param $3 exec-or-call-string The call to be wrapped
#P def callErrOutWrapper($1,$2,$3):
#P 	pass
## \cond
#***FUNCEND***
function callErrOutWrapper () {
    printDBG $S_LIB ${D_BULK} $LINENO $BASH_SOURCE "$FUNCNAME:<${@}>"

    local _originLine=$1;shift
    local _originFile=$1;shift
    local _cli=$*
    local _res=0
    printDBG $S_LIB $D_BULK $_originLine "$_originFile" 0 "$FUNCNAME:<${@}>"

    if [ -n "${UTALM_NOCALLWRAPPER}" ];then
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
    [ "$UTALM_XTERM" == 0 ]\
      &&{ [ "$_res" == 0 ]&&_rd="\033[32m OK \033[m"||_rd="\033[31m NOK \033[m"; }\
      ||{ [ "$_res" == 0 ]&&_rd=" OK "||_rd=" NOK "; }

    printDBG $S_LIB ${D_BULK} $_originLine "$_originFile" "$FUNCNAME:_res=<${_rd}>"
    printDBG $S_LIB ${D_SYS} $_originLine "$_originFile" "$FUNCNAME:`setSeverityColor TRY \"call(${_cli})\"` => [ ${_rd} ]"
    return $_res
}

#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Evaluates pathname with awareness of console-call
#P # 
#P # Due to some wrappers, e.g. "consolehelper" for CentOS/RHEL, the 
#P # function evaluates the PATH variable only when run from a console,
#P # else hard-coded paths are checked. The paths has to be specifically
#P # adapted to the different platforms of course.
#P #
#P # This approach includes support for pre-configured authorization by 
#P # usage of PAM modules for specific console-wrappers.1
#P # 
#P # Implementation priority: PERFORMANCE
#P # 
#P # @param $1: LINENO of caller
#P # @param $2: BASH_SOURCE of caller
#P # @param $3: ERROR|WARNING|WARNINGEXT
#P # <ul>
#P #   <li>ERROR<br>
#P #        Prints an error message and exits.
#P #   </li>
#P #   <li>WARNING<br>  
#P #        Prints a warning and continues.
#P #   </li>
#P #   <li>WARNINGEXT<br>
#P #        Prints a warning-extended when activated by "-w" and continues.
#P #   </li>
#P # </ul>
#P # @param $4: exec callee
#P # @param $5: default path
#P # @return 
#P # <ul>
#P #   <li>SUCCESS:= 0 + echo absolute-pathname</li>
#P #   <li>FAILURE:= 1</li>
#P # </ul>
#P # 
#P def getPathName($1,$2,$3,$4,$5):
#P 	pass
## \cond
#***FUNCEND***
 getPathName () {
    local _pname=;
    local _ret=1;

    #if not on console trouble is caused by several console-wrappers
    checkConsole 2>/dev/null >/dev/null
    if [ $? -eq 0 ];then
        #try whether access is permitted, else continue with usual business
	_pname=`gwhich $4 2>/dev/null`
	_ret=$?
    fi
    if [ -z "$_pname" ];then
        #try the system specific path
	if [ -n "${5}" ];then
	    _pname=`gwhich ${5}/${4} 2>/dev/null`
	    _ret=$?
	else
	    case $3 in
		ERROR)printERR $1 $2 1  "Missing required default path";gotoHell 1;;
		WARNING)printWNG 1 $1 $2 1  "Missing required default path";;
		WARNINGEXT|*)printWNG 2 $1 $2 1  "Missing required default path";;
	    esac
	fi
    fi
    if [ $_ret -ne 0 ];then
    	case $3 in
	    ERROR)printERR $1 $2 1  "Can not evaluate exec-access to \"`setSeverityColor ERR ${4}`\"";gotoHell 1;;
	    WARNING)printWNG 1 $1 $2 1  "Can not evaluate exec-access to \"`setSeverityColor WNG ${4}`\"";;
	    WARNINGEXT|*)printWNG 2 $1 $2 1  "Can not evaluate exec-access to \"`setSeverityColor WNG ${4}`\"";;
	esac
	
    fi
    [ -n "${_pname}" -a $_ret -eq 0 ]&&_disp=`setSeverityColor INF ${_pname}`||_disp=`setSeverityColor WNG "ABSENT(${5}/${4})"`;
    if [ $_ret -eq 0 ];then
	echo "$_pname"	
    fi
    return $_ret
}

#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Exits with stardard string output
#P # 
#P #  Exits with "grep" string for unit evaluation.
#P #    "utalm_exit:#value"
#P #
#P # Examples:
#P #    "utalm_exit:0"
#P #    "utalm_exit:2"
#P #
#P #  The name gotoHell is honouring my very first colleagues -
#P #  actually skilled - not wanna-be-super-gurus.
#P # @param $1: LINENO of caller
#P # @param $2: BASH_SOURCE of caller
#P # @param $3: EXIT values.
#P # @exit with given code
#P def gotoHell($1,$2,$3):
#P 	pass
## \cond
#***FUNCEND***
function gotoHell () {
	printINFO 0 $1 $2 1  "Requested exit:$3"
	echo "utalm_exit:$3">&2
	exit $3	
}

#***FUNCBEG***
#**doxygen-workaround***
## \endcond
#P ##
#P # Counts errors for SUnit and regression tests. 
#P # 
#P # Counts error exits generated by gotoHell.
#P #   "utalm_sum_of_errors:#sum-value"
#P #
#P # @return with sum
#P def countErrors():
#P 	pass
## \cond
#***FUNCEND***
function countErrors () {
	awk -F':' '
		BEGIN{
			ecnt=0;
		}
		$0~/utalm_exit/{
			if($2!=0){ecnt+=1;}print "ecnt=" ecnt " " $0
		}
		END{
			print "utalm_sum_of_errors:" ecnt
		}'>&2
}

fi #*** prevent multiple inclusion
## \endcond
