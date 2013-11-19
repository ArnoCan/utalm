## <!--#***HEADSTART***-->
## \cond
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENSE:      Apache-2.0 - code 
#LICENSE:      CCL-BY-SA - specification, interfaces, and inline documentation
#
#
#***
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
#***
#
#<!-- $Header$ -->
#
## \endcond
##
## @ingroup utalm_bash
## @file
## @brief Main library of utalm-bash component
##
## For command line application syntax refer to \ref cliSyntaxBash.
##
##  * Source and documentation: @ref libutalm.sh
##  * Stripped runtime version: @ref libutalm-min.sh
##
## For detailed information on <b>libutalm.sh</b> refer to:
## <ul>
##   <li> 
##     <b><a href="../../man3/utalm-bash.html">utalm-bash(3)</a></b>
##   </li> 
##   <li> 
##     <b><a href="../../man3/utalm-bash-API/index.html">utalm-bash-API(3)</a></b>
##   </li> 
## </ul>
##
## \cond #KEEP# PERSISTENT
## <!--#***HEADEND***-->
#
if [ -z "$MYCALLNAME" ];then
	MYCALLNAME=${0##*/}
	MYCALLNAME=${MYCALLNAME%.*}
fi
export MYCALLNAME

if [ -z "$__UTALM__" ];then #*** prevent multiple inclusion
## \endcond
## __UTALM__
# Set to "1" when sourced.
# Prevents multiple inclusion
__UTALM__=1 #*** prevent multiple inclusion
## \cond

## \endcond
## _myLIBNAME_utalm
# Pathname of current libutalm.sh
_myLIBNAME_utalm="${BASH_SOURCE}"
## \cond

## \endcond
## MYLIBPATHNAME
# Pathname of current libutalm.sh
MYLIBPATHNAME="${_myLIBNAME_utalm}"
## \cond

## \endcond
## _MYLIBNAME
# Name of current libutalm.sh
MYLIBNAME="${BASH_SOURCE##*/}"
## \cond

## \endcond
## _myLIBVERS_utalm
# Version of current libutalm.sh, fixed.
_myLIBVERS_utalm="03_01_009"
## \cond

## \endcond
## MYLIBVERS
# Version of current libutalm.sh, current active lib.
MYLIBVERS="${_myLIBVERS_utalm}"
## \cond


## LOG
# Output stream.
LOG=${LOG:-/dev/fd/2}
LR=${LR:-0}
_Rx=0
LM=${LM:-10000}
_Mx=0

## _OF
# Output filter control.
_OF=0

## outfilter
# Output filter.
outfilter=""

# verify bootstrap - STAGE0a
if [ $__BOOTSTRAP__ -ne 1 ];then
	echo "ERROR:bootstrap required">>$LOG
	echo "ERROR:$BASH_SOURCE:$LINENO">>$LOG
fi
if [ ! -e "${_myLIBNAME_bootstrap}" ];then
	echo "ERROR:cannot find bootstrap">>$LOG
	echo "ERROR:${_myLIBNAME_bootstrap}">>$LOG
fi
if [ "${_myLIBVERS_utalm}" != "${_myLIBVERS_bootstrap}" ];then
	echo "ERROR:${MYLIBNAME}:${LINENO}:Version mismatch">>$LOG
	echo "ERROR:libutalm.sh - ${_myLIBVERS_utalm}">>$LOG
	echo "ERROR:bootstrap   - ${_myLIBVERS_bootstrap}">>$LOG
fi

# verify core - STAGE0b
if [ $__LIBCORE__ -ne 1 ];then
	echo "ERROR:libcore required">>$LOG
	echo "ERROR:$BASH_SOURCE:$LINENO">>$LOG
fi
if [ ! -e "${_myLIBNAME_libcore}" ];then
	echo "ERROR:cannot find libcore">>$LOG
	echo "ERROR:${_myLIBNAME_libcore}">>$LOG
fi
if [ "${_myLIBVERS_utalm}" != "${_myLIBVERS_libcore}" ];then
	echo "ERROR:${MYLIBNAME}:${LINENO}:Version mismatch">>$LOG
	echo "ERROR:libutalm.sh - ${_myLIBVERS_utalm}">>$LOG
	echo "ERROR:libcore     - ${_myLIBVERS_libcore}">>$LOG
fi
#shopt -s nullglob
#shopt -s extglob

#
#Set some common basic definitions.
#

#P # Root for libraries, default is relative to current.
#P #
#P # @ingroup utalm_bash
#if not yet initialized, but pre-defined, than set it
if [ -z "${MYLIBPATH}" ];then
## \endcond
        MYLIBPATH="${BASH_SOURCE%/*}/"
## \cond
fi

MYLIBPATH=${MYLIBPATH//\/\//\/}
MYLIBPATH=${MYLIBPATH//\/\//\/}


#moment of truth, where it is required to be set
if [ ! -d "${MYLIBPATH}" -o ! -e "${MYLIBPATH}/libutalm.sh" ];then
	MYLIBPATH=${MYLIBPATH%/lib}/lib
	if [ ! -d "${MYLIBPATH}" -o ! -e "${MYLIBPATH}/libutalm.sh" ];then
	  echo "${MYLIBNAME}:$LINENO:ERROR:${MYCALLNAME}-Missing:MYLIBPATH=${MYLIBPATH}"
	  echo "${MYLIBNAME}:$LINENO:ERROR:Required to point to the root of the"
	  echo "${MYLIBNAME}:$LINENO:ERROR:library to be used."
	  exit 1
	fi
fi

#make it absolute
if [ -n "##/*}" ];then
    cd "${MYLIBPATH}"
    MYLIBPATH=${PWD}
    cd ->/dev/null
fi
## \endcond

## Full pathname of library.
##
## @ingroup utalm_bash
MYLIBPATHNAME="${MYLIBPATH}/${MYLIBNAME}"

## Language - default 'en'
##
## @ingroup utalm_bash
MYLANG="${MYLANG:-$LANG}"

## \cond
case ${MYLANG} in
#    de*|De*|DE*) MYLANG=de;;
    en*|En*|EN*) MYLANG=en;;
    *)           MYLANG=en;;
esac
## \endcond

## Base for document tree
##
## @ingroup utalm_bash
MYDOCBASE="${MYDOCBASE:-$HOME/doc}"
## \cond
if [ ! -d "${MYDOCBASE}" ];then
    echo "${MYCALLNAME}:$LINENO:ERROR:Missing:MYDOCBASE=${MYDOCBASE}"
    exit 1
fi
## \endcond

## Base for configuration files
##
## @ingroup utalm_bash
MYCONFPATH="${MYCONFPATH:-$HOME/conf}"
## \cond
if [ ! -d "${MYCONFPATH}" ];then
  echo "${MYCALLNAME}:$LINENO:ERROR:Missing:MYCONFPATH=${MYCONFPATH}"
  exit 1
fi
## \endcond

# Output LOG stream.
##
## @ingroup utalm_bash
LOG="${LOG:-/dev/fd/2}"


#
################################################################
#               Default definitions - 1/2                      #
################################################################
#
#For now 16bit-array, to be used in level-mode or match-mode.
#

#
#exit constants
#
## @ingroup utalm_bash
E_OK=0
## \cond
export E_OK
## \endcond

## @ingroup utalm_bash
E_PARAM=1
## \cond
export E_PARAM
## \endcond

## @ingroup utalm_bash
E_SYS=2
## \cond
export E_SYS
## \endcond

## @ingroup utalm_bash
E_CONFIG=3
## \cond
export E_CONFIG
## \endcond

#
#levels
#
## None.
##
## @ingroup utalm_bash
D_NONE=0
## \cond
export D_NONE
## \endcond

## Force on.
##
## @ingroup utalm_bash
D_ON=0
## \cond
export D_ON
## \endcond

## User defined.
##
## @ingroup utalm_bash
D_USR0=1
## \cond
export D_USR0
## \endcond

## User defined.
##
## @ingroup utalm_bash
D_USR1=2
## \cond
export D_USR1
## \endcond

## User defined.
##
## @ingroup utalm_bash
D_USR2=4
## \cond
export D_USR2
## \endcond

## User defined.
##
## @ingroup utalm_bash
D_USR3=8
## \cond
export D_USR3
## \endcond

## User defined.
##
## @ingroup utalm_bash
D_USR4=16
## \cond
export D_USR4
## \endcond

## User defined.
##
## @ingroup utalm_bash
D_USR5=32
## \cond
export D_USR5
## \endcond

## User defined.
##
## @ingroup utalm_bash
D_USR6=64
## \cond
export D_USR6
## \endcond

## User defined.
##
## @ingroup utalm_bash
D_USR7=128
## \cond
export D_USR7

## \endcond
## Data flow traces.
##
## @ingroup utalm_bash
D_FLOW=256
## \cond
export D_FLOW

## \endcond
## Data changes, when a central structure exists. 
##
## @ingroup utalm_bash
D_DATA=512
## \cond
export D_DATA

## \endcond
## Result code.
##
## @ingroup utalm_bash
D_IN=1024
## \cond
export D_IN

## \endcond
## Result data.
##
## @ingroup utalm_bash
D_OUT=2048
## \cond
export D_OUT

## \endcond
### @var D_SYS
## System calls. 
##
## @ingroup utalm_bash
D_SYS=4096
## \cond
export D_SYS

## \endcond
## Test debug.
##
## @ingroup utalm_bash
D_TSTU=8192
## \cond
export D_TSTU

## \endcond
## Bulk data. 
##
## @ingroup utalm_bash
D_BULK=16384
## \cond
export D_BULK

## \endcond
## Internal detected erroneous value. 
##
## Occurs when a non-integer is provided, where int is expected.
## @ingroup utalm_bash
D_ERR=32768
## \cond
export D_ERR

## \endcond
## All. 
##
## @ingroup utalm_bash
D_ALL=65535
## \cond
export D_ALL

#
#subsystems
#
## \endcond
## None.
##
## @ingroup utalm_bash
S_NONE=0
## \cond
export S_NONE

## \endcond
## Force on.
##
## @ingroup utalm_bash
S_ON=0
## \cond
export S_ON

## \endcond
## Subsystem configuration. 
##
## @ingroup utalm_bash
S_USR0=2
## \cond
export S_USR0

## \endcond
## Subsystem configuration. 
##
## @ingroup utalm_bash
S_USR1=4
## \cond
export S_USR1

## \endcond
## Subsystem configuration. 
##
## @ingroup utalm_bash
S_USR2=8
## \cond
export S_USR2

## \endcond
## Subsystem configuration. 
##
## @ingroup utalm_bash
S_USR3=16
## \cond
export S_USR3

## \endcond
## Subsystem configuration. 
##
## @ingroup utalm_bash
S_USR4=32
## \cond
export S_USR4

## \endcond
## Subsystem configuration. 
##
## @ingroup utalm_bash
S_USR5=64
## \cond
export S_USR5

## \endcond
## Subsystem configuration. 
##
## @ingroup utalm_bash
S_USR6=128
## \cond
export S_USR6

## \endcond
## Subsystem configuration. 
##
## @ingroup utalm_bash
S_USR7=256
## \cond
export S_USR7

## \endcond
## Subsystem configuration. 
##
## @ingroup utalm_bash
S_USR8=512
## \cond
export S_USR8

## \endcond
## Subsystem configuration. 
##
## @ingroup utalm_bash
S_USR9=1024
## \cond
export S_USR9

## \endcond
## Subsystem configuration. 
##
## @ingroup utalm_bash
S_USR10=2048
## \cond
export S_USR10

## \endcond
## Subsystem configuration. 
##
## @ingroup utalm_bash
S_USR11=4096
## \cond
export S_USR11

## \endcond
## Subsystem configuration. 
##
## @ingroup utalm_bash
S_USR12=8192
## \cond
export S_USR12

## \endcond
## Subsystem configuration. 
##
## @ingroup utalm_bash
S_CONF=16384
## \cond
export S_CONF

## \endcond
## Binaries. 
##
## @ingroup utalm_bash
S_BIN=32768
## \cond
export S_BIN

## \endcond
## Libraries. 
##
## @ingroup utalm_bash
S_LIB=65536
## \cond
export S_LIB

## \endcond
## Core systems. 
##
## @ingroup utalm_bash
S_CORE=131072
## \cond
export S_CORE

## \endcond
## Generic system components, mainly systems provided base classes. 
##
## @ingroup utalm_bash
S_GEN=262144
## \cond
export S_GEN

## \endcond
## Command line interface component. 
##
## @ingroup utalm_bash
S_CLI=524288
## \cond
export S_CLI

## \endcond
## X11 component. 
##
## @ingroup utalm_bash
S_X11=1048576
## \cond
export S_X11

## \endcond
## VNC component. 
##
## @ingroup utalm_bash
S_VNC=2097152
## \cond
export S_VNC

## \endcond
## QEMU component. 
##
## @ingroup utalm_bash
S_QEMU=4194304
## \cond
export S_QEMU

## \endcond
## VMW component. 
##
## @ingroup utalm_bash
S_VMW=8388608
## \cond
export S_VMW

## \endcond
## XEN component. 
##
## @ingroup utalm_bash
S_XEN=16777216
## \cond
export S_XEN

## \endcond
## PM component. 
##
## @ingroup utalm_bash
S_PM=33554432
## \cond
export S_PM

## \endcond
## KVM component. 
##
## @ingroup utalm_bash
S_KVM=67108864
## \cond
export S_KVM

## \endcond
## RDP component. 
##
## @ingroup utalm_bash
S_RDP=134217728
## \cond
export S_RDP

## \endcond
## VBOX component. 
##
## @ingroup utalm_bash
S_VBOX=268435456
## \cond
export S_VBOX

## \endcond
## UTALM component. 
##
## @ingroup utalm_bash
S_UTALM=536870912
## \cond
export S_UTALM

## \endcond
## Internal detected erroneous value. 
##
## Occurs when a non-integer is provided, where int is expected.
## @ingroup utalm_bash
S_MAKE=1073741824
## \cond
export S_MAKE

## \endcond
## ALL components. 
##
## @ingroup utalm_bash
S_ALL=4294967295
## \cond
export S_ALL

## \endcond
## Internal detected erroneous value. 
##
## Occurs when a non-integer is provided, where int is expected.
## @ingroup utalm_bash
S_ERR=4294967296
## \cond
export S_MAKE

## \endcond
## Current mode of decision. Has to be set by command line parameter only. 
##
##	mode := ( (PATTERN|P) | MIN | MAX )
##
## @ingroup utalm_bash
MTYPE=4
M=4
## \cond

## \endcond
## Current DEBUG level. Has to be set by command line parameter only. 
##
## @ingroup utalm_bash
#P DBG=0
## \cond
DBG=${DBG:-0}

## \endcond
## Current INFO level. Has to be set by command line parameter only. 
##
## @ingroup utalm_bash
#P S_DEFAULT=S_ALL
## \cond
S_DEFAULT=$S_ALL
_S=$S_DEFAULT

## \endcond
## Current INFO level. Has to be set by command line parameter only. 
##
## @ingroup utalm_bash
#P INF=2
## \cond
export INF=${INF:-2}

## \endcond
## Current WARNING level. Has to be set by command line parameter only. 
##
## @ingroup utalm_bash
#P WNG=2
## \cond
WNG=${WNG:-2}

#Debugging
C_DARGS=;

#print final interface-pre-exec data
#<level>: prints
C_PFEXE=;


## \endcond
## All output fileds active. 
##
## @ingroup utalm_bash
#P F_ALL=0b1111111111111111
## \cond
F_ALL=4294967295
#

## \endcond
## None.
##
## @ingroup utalm_bash
F_NONE=0
## \cond

## \endcond
## Call name of current cli command. 
##
## @ingroup utalm_bash
#P F_CALLNAME=1
## \cond
F_CALLNAME=1

## \endcond
## Call name of current user ID. 
## @ingroup utalm_bash
#P F_USERNUM=2
## \cond
F_USERNUM=2

## \endcond
## Call name of current user name. 
## @ingroup utalm_bash
#P F_USERSTR=4
## \cond
F_USERSTR=4

## \endcond
## Call name of current group ID. 
## @ingroup utalm_bash
#P F_GROUPNUM=8
## \cond
F_GROUPNUM=8

## \endcond
## Call name of current group name. 
## @ingroup utalm_bash
#P F_GROUPSTR=16
## \cond
F_GROUPSTR=16

## \endcond
## Call name of current remote login.
## Format: <user-name>@<host> 
## @ingroup utalm_bash
#P F_RLOGINDNS=32
## \cond
F_RLOGINDNS=32

## \endcond
## Call name of current remote login.
## Format: <user-name>@<ip-address> 
## @ingroup utalm_bash
#P F_RLOGINIP=64
## \cond
F_RLOGINIP=64

## \endcond
## Current timestamp. 
## Format is:  hhmmss
## @ingroup utalm_bash
#P F_TIME=128
## \cond
F_TIME=128

## \endcond
## Current date. 
## Format is:  yymmdd
## @ingroup utalm_bash
#P F_DATE=256
## \cond
F_DATE=256

## \endcond
## Current pid. 
## @ingroup utalm_bash
#P F_PID=512
## \cond
F_PID=512

## \endcond
## Current ppid. 
## @ingroup utalm_bash
#P F_PPID=1024
## \cond
F_PPID=1024

## \endcond
## Current ppid. 
## @ingroup utalm_bash
#P F_LIBRARY=2048
## \cond
F_LIBRARY=2048

## \endcond
## Current ppid. 
## @ingroup utalm_bash
#P F_PACKAGE=4096
## \cond
F_PACKAGE=4096

## \endcond
## Current filename. 
## @ingroup utalm_bash
#P F_FILENAME=8192
## \cond
F_FILENAME=8192

## \endcond
## Current filename. 
## @ingroup utalm_bash
#P F_FILEPATHNAME=16384
## \cond
F_FILEPATHNAME=16384

## \endcond
## Current linenumber. 
## @ingroup utalm_bash
#P F_CLASSNAME=32768
## \cond
F_CLASSNAME=32768

## \endcond
## Current linenumber. 
## @ingroup utalm_bash
#P F_FUNCNAME=65536
## \cond
F_FUNCNAME=65536

## \endcond
## Current linenumber. 
## @ingroup utalm_bash
#P F_LINENUMBER=131072
## \cond
F_LINENUMBER=131072

## \endcond
## Current subsystem enum. 
## @ingroup utalm_bash
#P F_SEVERITY=262144
## \cond
F_SEVERITY=262144

## \endcond
## Current subsystem numeric. 
## @ingroup utalm_bash
#P F_SUBSYSRAW=524288
## \cond
F_SUBSYSRAW=524288

## \endcond
## Current subsystem numeric. 
## @ingroup utalm_bash
#P F_SUBSYSNUM=1048576
## \cond
F_SUBSYSNUM=1048576

## \endcond
## Current subsystem enum. 
## @ingroup utalm_bash
#P F_SUBSYSSTR=2097152
## \cond
F_SUBSYSSTR=2097152

## \endcond
## Current debug level. 
## @ingroup utalm_bash
#P F_LEVELRAW=4194304
## \cond
F_LEVELRAW=4194304

## \endcond
## Current debug level. 
## @ingroup utalm_bash
#P F_LEVELNUM=8388608
## \cond
F_LEVELNUM=8388608

## \endcond
## Current debug level. 
## @ingroup utalm_bash
#P F_LEVELSTR=16777216
## \cond
F_LEVELSTR=16777216

## \endcond
## Current code. 
## @ingroup utalm_bash
#P F_CODE=33554432
## \cond
F_CODE=33554432

## \endcond
## Current message. 
## @ingroup utalm_bash
#P F_MESSAGE=67108864
## \cond
F_MESSAGE=67108864

## \endcond
## Force colored output 
## @ingroup utalm_bash
#P F_COLOR=134217728
## \cond
F_COLOR=134217728

## \endcond
## Suppress colored output 
## @ingroup utalm_bash
#P F_NOCOLOR=268435456
## \cond
F_NOCOLOR=268435456

## \endcond
## Display exit values for gotoHell as enum when available. 
## @ingroup utalm_bash
#P F_EXITCODE_AS_STR=536870912
## \cond
F_EXITCODE_AS_STR=536870912

## \endcond
## Current output format 
## @ingroup utalm_bash
F_FORM=0
## \cond

## \endcond
## Format as stream for console display 
## @ingroup utalm_bash
F_CON=0
## \cond

## \endcond
## Format as table for console display 
## @ingroup utalm_bash
F_TAB=1
## \cond

## \endcond
## Format for syslog 
## @ingroup utalm_bash
F_SYS=2
## \cond

## \endcond
## Format compatible with LOG4J 
## @ingroup utalm_bash
F_LOG4J=3
## \cond

## \endcond
## Format as XML 
## @ingroup utalm_bash
F_CSV=4
## \cond

## \endcond
## Format as XML 
## @ingroup utalm_bash
F_XML=5
## \cond

## \endcond
## Format as HTML 
## @ingroup utalm_bash
F_HTML=6
## \cond

## \endcond
## Format as JSON 
## @ingroup utalm_bash
F_JSON=7
## \cond

## \endcond
## Current field seperator for output records of line-type 
## @ingroup utalm_bash
F_FS=":"
export F_FS
## \cond

## \endcond
## Current indent 
## @ingroup utalm_bash
#P F_INDENT='0'
## \cond
F_I=0


## \endcond
#P ##
#P # Convert subsys to string
#P #
#P # @param a $1:= subsys
#P # @ingroup utalm_bash
#P def subsysToNum(a):
#P 	pass
## \cond
function subsysToNum () {
    local s=$(echo $1|tr '[a-z]' '[A-Z]');
    local S=0;
	for sx in ${s//[%|]/ }; do
    case ${sx} in
	S_NONE|NONE|S_ON|ON)S=$S_NONE;;
	
	#***
	#
    # Custom values for subsytems
    #
	S_USR0|USR0)S=$((S|S_USR0));;
	S_USR1|USR1)S=$((S|S_USR1));;
	S_USR2|USR2)S=$((S|S_USR2));;
	S_USR3|USR3)S=$((S|S_USR3));;
	S_USR4|USR4)S=$((S|S_USR4));;
	S_USR5|USR5)S=$((S|S_USR5));;
	S_USR6|USR6)S=$((S|S_USR6));;
	S_USR7|USR7)S=$((S|S_USR7));;
	S_USR8|USR8)S=$((S|S_USR8));;
	S_USR9|USR9)S=$((S|S_USR9));;
	S_USR10|USR10)S=$((S|S_USR10));;
	S_USR11|USR11)S=$((S|S_USR11));;
	S_USR12|USR12)S=$((S|S_USR12));;
	#
	#***

	S_CONF|CONF)S=$((S|S_CONF));;
	S_BIN|BIN)S=$((S|S_BIN));;
	S_LIB|LIB)S=$((S|S_LIB));;
	S_CORE|CORE)S=$((S|S_CORE));;
	S_GEN|GEN)S=$((S|S_GEN));;
	S_CLI|CLI)S=$((S|S_CLI));;
	S_X11|X11)S=$((S|S_X11));;
	S_VNC|VNC)S=$((S|S_VNC));;
	S_QEMU|QEMU)S=$((S|S_QEMU));;
	S_VMW|VMW)S=$((S|S_VMW));;
	S_XEN|XEN)S=$((S|S_XEN));;
	S_PM|PM)S=$((S|S_PM));;
	S_KVM|KVM)S=$((S|S_KVM));;
	S_RDP|RDP)S=$((S|S_RDP));;
	S_VBOX|VBOX)S=$((S|S_VBOX));;
	S_UTALM|UTALM)S=$((S|S_UTALM));;
	S_MAKE|MAKE)S=$((S|S_MAKE));;
	S_ALL|ALL)S=$((S|S_ALL));;
	S_ERR)S=$((S|S_ERR));;
	[0-9]*)S=$((S|sx));;
	HELP)subsysList;echo -n "-1";exit 0;;
	*)
	    if [ -n "${sx//[0-9]/}" ];then
		echo "Subsytem requires label or numeric value:$sx">>$LOG
		exit 1;
	    fi
	    ;;
    esac
	done
    echo -n $S
}


## \endcond
#P ##
#P # Convert string to \#subsys
#P #
#P # @param a $1:= subsys
#P # @ingroup utalm_bash
#P def subsysToStr(a):
#P 	pass
## \cond
function subsysToStr () {
    local S=$(echo $1|tr '[a-z]' '[A-Z]');
    case ${S} in
	$S_NONE|S_NONE|NONE|S_ON|ON)S=S_NONE;;
	
	#***
	#
    # Custom values for subsytems
    #
	$S_USR0|S_USR0|USR0)S=S_USR0;;
	$S_USR1|S_USR1|USR1)S=S_USR1;;
	$S_USR2|S_USR2|USR2)S=S_USR2;;
	$S_USR3|S_USR3|USR3)S=S_USR3;;
	$S_USR4|S_USR4|USR4)S=S_USR4;;
	$S_USR5|S_USR5|USR5)S=S_USR5;;
	$S_USR6|S_USR6|USR6)S=S_USR6;;
	$S_USR7|S_USR7|USR7)S=S_USR7;;
	$S_USR8|S_USR8|USR8)S=S_USR8;;
	$S_USR9|S_USR9|USR9)S=S_USR9;;
	$S_USR10|S_USR10|USR10)S=S_USR10;;
	$S_USR11|S_USR11|USR11)S=S_USR11;;
	$S_USR12|S_USR12|USR12)S=S_USR12;;
	#
    #***

	$S_CONF|S_CONF|CONF)S=S_CONF;;
	$S_BIN|S_BIN|BIN)S=S_BIN;;
	$S_LIB|S_LIB|LIB)S=S_LIB;;
	$S_CORE|S_CORE|CORE)S=S_CORE;;
	$S_GEN|S_GEN|GEN)S=S_GEN;;
	$S_CLI|S_CLI|CLI)S=S_CLI;;
	$S_X11|S_X11|X11)S=S_X11;;
	$S_VNC|S_VNC|VNC)S=S_VNC;;
	$S_QEMU|S_QEMU|QEMU)S=S_QEMU;;
	$S_VMW|S_VMW|VMW)S=S_VMW;;
	$S_XEN|S_XEN|XEN)S=S_XEN;;
	$S_PM|S_PM|PM)S=S_PM;;
	$S_KVM|S_KVM|KVM)S=S_KVM;;
	$S_RDP|S_RDP|RDP)S=S_RDP;;
	$S_VBOX|S_VBOX|VBOX)S=S_VBOX;;
	$S_UTALM|S_UTALM|UTALM)S=S_UTALM;;
	$S_MAKE|S_MAKE|MAKE)S=S_MAKE;;
	$S_ALL|S_ALL|ALL)S=S_ALL;;
	$S_ERR|S_ERR)S=S_ERR;;
	[0-9]*);;
	*)S=S_UNKOWN_$S;;
	HELP)subsysList;exit 0;;
    esac
    echo -n $S
    return 0
}


## \endcond
#P ##
#P # List known subystem enums
#P #
#P # @ingroup utalm_bash
#P def subsysList():
#P 	pass
## \cond
function subsysList () {
    echo >>$LOG
    echo "Predefined subsystems constants:">>$LOG
    echo >>$LOG
    printf "%-30s:%d" "S_NONE|NONE|S_ON|ON" $S_NONE >>$LOG;((_S&S_NONE))&&echo "*">>$LOG||echo>>$LOG
	echo>>$LOG

	#***
	#
    # Custom values for subsytems
    #
    printf "%-30s:%d" "S_USR0|USR0" $S_USR0 >>$LOG;((_S&S_USR0))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_USR1|USR1" $S_USR1 >>$LOG;((_S&S_USR1))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_USR2|USR2" $S_USR2 >>$LOG;((_S&S_USR2))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_USR3|USR3" $S_USR3 >>$LOG;((_S&S_USR3))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_USR4|USR4" $S_USR4 >>$LOG;((_S&S_USR4))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_USR5|USR5" $S_USR5 >>$LOG;((_S&S_USR5))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_USR6|USR6" $S_USR6 >>$LOG;((_S&S_USR6))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_USR7|USR7" $S_USR7 >>$LOG;((_S&S_USR7))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_USR8|USR8" $S_USR8 >>$LOG;((_S&S_USR8))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_USR9|USR9" $S_USR9 >>$LOG;((_S&S_USR9))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_USR10|USR10" $S_USR10 >>$LOG;((_S&S_USR10))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_USR11|USR11" $S_USR11 >>$LOG;((_S&S_USR11))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_USR12|USR12" $S_USR12 >>$LOG;((_S&S_USR12))&&echo "*">>$LOG||echo>>$LOG
	#
	#***

	echo>>$LOG
    printf "%-30s:%d" "S_CONF|CONF" $S_CONF >>$LOG;((_S&S_CONF))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_BIN|BIN" $S_BIN >>$LOG;((_S&S_BIN))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_LIB|LIB" $S_LIB >>$LOG;((_S&S_LIB))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_CORE|CORE" $S_CORE >>$LOG;((_S&S_CORE))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_GEN|GEN" $S_GEN >>$LOG;((_S&S_GEN))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_CLI|CLI" $S_CLI >>$LOG;((_S&S_CLI))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_X11|X11" $S_X11 >>$LOG;((_S&S_X11))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_VNC|VNC" $S_VNC >>$LOG;((_S&S_VNC))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_QEMU|QEMU" $S_QEMU >>$LOG;((_S&S_QEMU))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_VMW|VMW" $S_VMW >>$LOG;((_S&S_VMW))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_XEN|XEN" $S_XEN >>$LOG;((_S&S_XEN))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_PM|PM" $S_PM >>$LOG;((_S&S_PM))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_KVM|KVM" $S_KVM >>$LOG;((_S&S_KVM))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_RDP|RDP" $S_RDP >>$LOG;((_S&S_RDP))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_VBOX|VBOX" $S_VBOX >>$LOG;((_S&S_VBOX))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_UTALM|UTALM" $S_UTALM >>$LOG;((_S&S_UTALM))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_MAKE|MAKE" $S_MAKE >>$LOG;((_S&S_MAKE))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "S_ALL|ALL" $S_ALL >>$LOG;((_S&S_ALL))&&echo "*">>$LOG||echo>>$LOG
    echo >>$LOG
    printf "%-30s:%d" "S_ERR" $S_ERR >>$LOG;((_S&S_ERR))&&echo "*">>$LOG||echo>>$LOG
    echo >>$LOG
    return 0
}


## \endcond
#P ##
#P # Convert \#debug-level to string
#P #
#P # @param a $1:= \#debug-level
#P # @ingroup utalm_bash
#P def levelToNum(a):
#P 	pass
## \cond
function levelToNum () {
    local l=$(echo $1|tr '[a-z]' '[A-Z]');
    local L=0;
	for lx in ${l//[%|]/ }; do
    case ${lx} in
	D_NONE|NONE|D_ON|ON)L=$D_NONE;;

	#***
	#
    # Custom values for debug levels
    #
	$DEF_USR0|D_USR0)L=$((L|D_USR0));;
	$DEF_USR1|D_USR1)L=$((L|D_USR1));;
	$DEF_USR2|D_USR2)L=$((L|D_USR2));;
	$DEF_USR3|D_USR3)L=$((L|D_USR3));;
	$DEF_USR4|D_USR4)L=$((L|D_USR4));;
	$DEF_USR5|D_USR5)L=$((L|D_USR5));;
	$DEF_USR6|D_USR6)L=$((L|D_USR6));;
	#
	#***

	D_IN|IN)L=$((L|D_IN));;
	D_OUT|OUT)L=$((L|D_OUT));;
	D_TSTU|TSTU)L=$((L|D_TSTU));;
	D_FLOW|FLOW)L=$((L|D_FLOW));;
	D_DATA|DATA)L=$((L|D_DATA));;
	D_SYS|SYS)L=$((L|D_SYS));;
	D_BULK|BULK)L=$((L|D_BULK));;
	D_ALL|ALL)L=$((L|D_ALL));;
	D_ERR)L=$((L|D_ERR));;
	[0-9]*)L=$((L|lx));;
	HELP)levelList;echo -n "-1";exit 0;;
	*)
	    if [ -n "${lx//[0-9]/}" ];then
		echo "Level requires label or numeric value:$lx">>$LOG
		exit 1;
	    fi
	    ;;
    esac
	done
    echo -n $L
}



## \endcond
#P ##
#P # Convert string to \#debug-level
#P #
#P # @param a $1:= debug-level
#P # @ingroup utalm_bash
#P def levelToStr(a):
#P 	pass
## \cond
function levelToStr () {
    local L=$(echo $1|tr '[a-z]' '[A-Z]');
    case ${L} in
	$D_NONE|D_NONE|NONE|$D_ON|D_ON|ON)L=D_NONE;;

	#***
	#
    # Custom values for debug levels
    #
	$D_USR0|D_USR1|$DEF_USR0)L=$DEF_USR0;;
	$D_USR1|D_USR2|$DEF_USR1)L=$DEF_USR1;;
	$D_USR2|D_USR3|$DEF_USR2)L=$DEF_USR2;;
	$D_USR3|D_USR4|$DEF_USR3)L=$DEF_USR3;;
	$D_USR4|D_USR5|$DEF_USR4)L=$DEF_USR4;;
	$D_USR5|D_USR6|$DEF_USR5)L=$DEF_USR5;;
	$D_USR6|D_USR7|$DEF_USR6)L=$DEF_USR6;;
	#
	#***

	$D_IN|D_IN|IN)L=D_IN;;
	$D_OUT|D_OUT|OUT)L=D_OUT;;
	$D_TSTU|D_TSTU|TSTU)L=D_TSTU;;
	$D_FLOW|D_FLOW|FLOW)L=D_FLOW;;
	$D_DATA|D_DATA|DATA)L=D_DATA;;
	$D_SYS|D_SYS|SYS)L=D_SYS;;
	$D_BULK|D_BULK|BULK)L=D_BULK;;
	$D_ALL|D_ALL|ALL)L=D_ALL;;
	$D_UNKOWN|D_UNKOWN|UNKOWN)S=D_UNKOWN;;
	HELP)levelList;echo -n "-1";exit 0;;
    esac
    echo -n $L
    return 0
}



## \endcond
#P ##
#P # List known subystem enums
#P #
#P # @ingroup utalm_bash
#P def subsysList():
#P 	pass
## \cond
function levelList () {
    echo >>$LOG
    echo "Predefined and reserved level constants:">>$LOG
    echo >>$LOG
    printf "%-30s:%d" "D_NONE|NONE|D_ON|ON" $D_NONE >>$LOG;((DBG&D_NONE))&&echo "*">>$LOG||echo>>$LOG
	echo >>$LOG

	#***
	#
    # Custom values for debug levels
    #
    printf "%-30s:%d" "D_USR0|${DEF_USR0}" $D_USR0 >>$LOG;((DBG&D_USR0))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "D_USR1|${DEF_USR1}" $D_USR1 >>$LOG;((DBG&D_USR1))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "D_USR2|${DEF_USR2}" $D_USR2 >>$LOG;((DBG&D_USR2))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "D_USR3|${DEF_USR3}" $D_USR3 >>$LOG;((DBG&D_USR3))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "D_USR4|${DEF_USR4}" $D_USR4 >>$LOG;((DBG&D_USR4))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "D_USR5|${DEF_USR5}" $D_USR5 >>$LOG;((DBG&D_USR5))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "D_USR6|${DEF_USR6}" $D_USR6 >>$LOG;((DBG&D_USR6))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "D_USR7|${DEF_USR7}" $D_USR7 >>$LOG;((DBG&D_USR7))&&echo "*">>$LOG||echo>>$LOG
	#
	#***
	#
	echo >>$LOG
    printf "%-30s:%d" "D_FLOW|FLOW" $D_FLOW >>$LOG;((DBG&D_FLOW))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "D_DATA|DATA" $D_DATA >>$LOG;((DBG&D_DATA))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "D_IN|IN" $D_IN >>$LOG;((DBG&D_IN))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "D_OUT|OUT" $D_OUT >>$LOG;((DBG&D_OUT))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "D_SYS|SYS" $D_SYS >>$LOG;((DBG&D_SYS))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "D_TSTU|TSTU" $D_TSTU >>$LOG;((DBG&D_TSTU))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "D_BULK" $D_BULK >>$LOG;((DBG&D_BULK))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "D_ERR" $D_ERR >>$LOG;((DBG&D_ERR))&&echo "*">>$LOG||echo>>$LOG
	echo >>$LOG
    printf "%-30s:%d" "D_ALL|ALL" $D_ALL >>$LOG;((DBG&D_ALL))&&echo "*">>$LOG||echo>>$LOG
    echo >>$LOG
    return 0
}


## \endcond
#P ##
#P # Convert &lt;exit_string&gt; to \#exit value 
#P #
#P # @param a $1=exit-string
#P # @ingroup utalm_bash
#P def exitToNum(a):
#P 	pass
## \cond
function exitToNum () {
    local f=$(echo $1|tr '[a-z]' '[A-Z]');
    local F=;
    case ${f} in
        E_OK|OK)F=$E_OK;;
        E_PARAM|PARAM)F=$E_PARAM;;
        E_SYS|SYS)F=$E_SYS;;
        E_CONFIG|CONFIG)F=$E_CONFIG;;
		[0-9]*)F=$((F|f));;
        HELP)exitList;exit 0;;
		*)
		    if [ -n "${f//[0-9]/}" ];then
				echo "Error code requires label or numeric value:$l">>$LOG
				exit 1;
		    fi
		    ;;
    esac
    echo -n $F
}



## \endcond
#P ##
#P # Convert \#exit-value to <exit-string> 
#P #
#P # @param a $1:= exit-value
#P # @ingroup utalm_bash
#P def exitToStr(a):
#P 	pass
## \cond
function exitToStr () {
    local F=$(echo $1|tr '[a-z]' '[A-Z]');
    case ${F} in
        $E_OK|E_OK|OK)F=E_OK;;
        $E_PARAM|E_PARAM|PARAM)F=E_PARAM;;
        $E_SYS|E_SYS|SYS)F=E_SYS;;
        $E_CONFIG|E_CONFIG|CONFIG)F=E_CONFIG;;
        HELP)E=-1;exitList;;
    esac
    echo -n $F
    return 0
}



## \endcond
#P ##
#P # List known output-formats
#P #
#P # @ingroup utalm_bash
#P def formatList():
#P 	pass
## \cond
function exitList () {
    echo "Predefined exit string constants(requires F_EXITCODE_AS_STR):">>$LOG
    echo >>$LOG    
    printf "%-30s:%d\n" "E_OK|OK" $E_OK>>$LOG;
    printf "%-30s:%d\n" "E_PARAM|PARAM" $E_PARAM>>$LOG;
    printf "%-30s:%d\n" "E_SYS|SYS" $E_SYS>>$LOG;
    printf "%-30s:%d\n" "E_CONFIG|CONFIG" $E_CONFIG>>$LOG;
    echo "(">>$LOG
    return 0
}



## \endcond
#P ##
#P # Convert \#output-format-bit to <output-format-bit-string>
#P #
#P # @param a $1:= output-format-bit
#P # @ingroup utalm_bash
#P def formatToNum(a):
#P 	pass
## \cond
function formatToNum () {
    local f=$(echo $1|tr '[a-z]' '[A-Z]');
    local F=;
	for fx in ${f//[%|]/ }; do
    case ${fx} in
        F_OK|OK)F=$F_OK;;
        F_CALLNAME|CALLNAME)F=$((F|F_CALLNAME));;
        F_PARAM|PARAM)F=$((F|F_PARAM));;
        F_USERNUM|USERNUM)F=$((F|F_USERNUM));;
        F_USERSTR|USERSTR)F=$((F|F_USERSTR));;
        F_USERSTR|USERSTR)F=$((F|F_USERSTR));;
        F_RLOGINDNS|RLOGINDNS)F=$((F|F_RLOGINDNS));;
        F_RLOGINIP|RLOGINIP)F=$((F|F_RLOGINIP));;
        F_GROUPSTR|GROUPSTR)F=$((F|F_GROUPSTR));;
        F_GROUPNUM|GROUPNUM)F=$((F|F_GROUPNUM));;
        F_RLOGINDNS|RLOGINDNS)F=$((F|F_RLOGINDNS));;
        F_RLOGINIP|RLOGINIP)F=$((F|F_RLOGINIP));;
        F_TIME|TIME)F=$((F|F_TIME));;
        F_DATE|DATE)F=$((F|F_DATE));;
        F_PID|PID)F=$((F|F_PID));;
        F_PPID|PPID)F=$((F|F_PPID));;
        F_FILENAME|FILENAME)F=$((F|F_FILENAME));;
        F_FILEPATHNAME|FILEPATHNAME)F=$((F|F_FILEPATHNAME));;
        F_LINENUMBER|LINENUMBER)F=$((F|F_LINENUMBER));;
        F_SEVERITY|SEVERITY)F=$((F|F_SEVERITY))>>$LOG;;
        F_SUBSYSRAW|SUBSYSRAW)F=$((F|F_SUBSYSRAW));;
        F_SUBSYSNUM|SUBSYSNUM)F=$((F|F_SUBSYSNUM));;
        F_SUBSYSSTR|SUBSYSSTR)F=$((F|F_SUBSYSSTR));;
        F_LEVELRAW|LEVELRAW)F=$((F|F_LEVELRAW));;
        F_LEVELNUM|LEVELNUM)F=$((F|F_LEVELNUM));;
        F_LEVELSTR|LEVELSTR)F=$((F|F_LEVELSTR));;
        F_CODE|CODE)F=$((F|F_CODE));;
        F_MESSAGE|MESSAGE)F=$((F|F_MESSAGE));;
        F_COLOR|COLOR)F=$((F|F_COLOR));;
        F_NOCOLOR|NOCOLOR)F=$((F|F_NOCOLOR));;
        F_EXITCODE_AS_STR|F_EXITCODE_AS_STR)F=$((F|F_EXITCODE_AS_STR));;

        F_CON|CON)F=$F_CON;;
        F_TAB|TAB)F=$F_TAB;;
        F_SYS|SYS)F=$F_SYS;;
        F_LOG4J|LOG4J)F=$F_LOG4J;;
        F_CSV|CSV)F=$F_CSV;;
        F_XML|XML)F=$F_XML;;
        F_HTML|HTML)F=$F_HTML;;
        F_JSON|JSON)F=$F_JSON;;

        F_ALL|ALL)F=$((F|F_ALL));;
		[0-9]*)F=$((F|fx));;
        HELP)F=-1;formatList;;
		*)
		    if [ -n "${fx//[0-9]/}" ];then
				echo "Format requires label or numeric value:$fx">>$LOG
				exit 1;
		    fi
		    ;;
    esac
	done
    echo -n $F
}



## \endcond
#P ##
#P # Convert <output-format-bit-string> to output-format-bit
#P #
#P # @param a $1:= output-format-bit
#P # @ingroup utalm_bash
#P def formatToStr(a):
#P 	pass
## \cond
function formatToStr () {
    local F=$(echo $1|tr '[a-z]' '[A-Z]');
    case ${F} in
        $F_NONE|F_NONE|NONE)F=F_NONE;;
        $F_CALLNAME|F_CALLNAME|CALLNAME)F=F_CALLNAME;;
        $F_USERNUM|F_USERNUM|USERNUM)F=F_USERNUM;;
        $F_USERSTR|F_USERSTR|USERSTR)F=F_USERSTR;;
        $F_GROUPNUM|F_GROUPNUM|GROUPNUM)F=F_GROUPNUM;;
        $F_GROUPSTR|F_GROUPSTR|GROUPSTR)F=F_GROUPSTR;;
        $F_RLOGINDNS|RLOGINDNS)F=F_RLOGINDNS;;
        $F_RLOGINIP|RLOGINIP)F=F_RLOGINIP;;
        $F_TIME|F_TIME|TIME)F=F_TIME;;
        $F_DATE|F_DATE|DATE)F=F_DATE;;
        $F_PID|F_PID|PID)F=F_PID;;
        $F_PPID|F_PPID|PPID)F=F_PPID;;
        $F_FILENAME|F_FILENAME|FILENAME)F=F_FILENAME;;
        $F_FILEPATHNAME|F_FILEPATHNAME|FILEPATHNAME)F=F_FILEPATHNAME;;
        $F_LINENUMBER|F_LINENUMBER|LINENUMBER)F=F_LINENUMBER;;
        $F_SEVERITY|F_SEVERITY|SEVERITY)F=F_SEVERITY;;
        $F_SUBSYSRAW|F_SUBSYSRAW|SUBSYSRAW)F=F_SUBSYSRAW;;
        $F_SUBSYSNUM|F_SUBSYSNUM|SUBSYSNUM)F=F_SUBSYSNUM;;
        $F_SUBSYSSTR|F_SUBSYSSTR|SUBSYSSTR)F=F_SUBSYSSTR;;
        $F_LEVELRAW|F_LEVELRAW|LEVELRAW)F=F_LEVELRAW;;
        $F_LEVELNUM|F_LEVELNUM|LEVELNUM)F=F_LEVELNUM;;
        $F_LEVELSTR|F_LEVELSTR|LEVELSTR)F=F_LEVELSTR;;
        $F_CODE|F_CODE|CODE)F=F_CODE;;
        $F_MESSAGE|F_MESSAGE|MESSAGE)F=F_MESSAGE;;
        $F_COLOR|F_COLOR|COLOR)F=F_COLOR;;
        $F_NOCOLOR|F_NOCOLOR|NOCOLOR)F=F_NOCOLOR;;
        $F_EXITCODE_AS_STR|F_EXITCODE_AS_STR|EXITCODE_STR)F=F_EXITCODE_AS_STR;;                
        $F_I|F_I|INDENT)F=F_I;;
        $F_FORM|F_FORM|FORM)F=F_FORM;;

        $F_ALL|F_ALL|ALL)F=F_ALL;;
        HELP)formatList;exit 0;;
    esac
    echo -n $F
    return 0
}



## \endcond
#P ##
#P # List known output-formats
#P #
#P # @ingroup utalm_bash
#P def formatList():
#P 	pass
## \cond
function formatList () {
    echo >>$LOG
    echo "Predefined format constants:">>$LOG
    echo >>$LOG
    printf "%-30s:%d" "F_NONE|NONE" $F_NONE>>$LOG;((_F&F_NONE))&&echo "*">>$LOG||echo "">>$LOG
    printf "%-30s:%d" "F_CALLNAME|CALLNAME" $F_CALLNAME>>$LOG;((_F&F_CALLNAME))&&echo "*">>$LOG||echo "">>$LOG
    echo "(">>$LOG
    printf "   %-27s:%d" "F_USERNUM|USERNUM" $F_USERNUM>>$LOG;((_F&F_USERNUM))&&echo "*">>$LOG||echo>>$LOG
    printf "  |%-27s:%d" "F_USERSTR|USERSTR" $F_USERSTR>>$LOG;((_F&F_USERSTR))&&echo "*">>$LOG||echo>>$LOG
    echo ")">>$LOG
    echo "(">>$LOG
    printf "   %-27s:%d" "F_GROUPNUM|GROUPNUM" $F_GROUPNUM>>$LOG;((_F&F_GROUPNUM))&&echo "*">>$LOG||echo>>$LOG
    printf "  |%-27s:%d" "F_GROUPSTR|GROUPSTR" $F_GROUPSTR>>$LOG;((_F&F_GROUPSTR))&&echo "*">>$LOG||echo>>$LOG
    echo ")">>$LOG
    echo "(">>$LOG
    printf "   %-27s:%d" "F_RLOGINDNS|RLOGINDNS" $F_RLOGINDNS>>$LOG;((_F&F_RLOGINDNS))&&echo "*">>$LOG||echo>>$LOG
    printf "  |%-27s:%d" "F_RLOGINIP|RLOGINIP" $F_RLOGINIP>>$LOG;((_F&F_RLOGINIP))&&echo "*">>$LOG||echo>>$LOG
    echo ")">>$LOG
    printf "%-30s:%d" "F_DATE|DATE" $F_DATE>>$LOG;((_F&F_DATE))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "F_PID|PID" $F_PID>>$LOG;((_F&F_PID))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "F_PPID|PPID" $F_PPID>>$LOG;((_F&F_PPID))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "F_LIBRARY|LIBRARY" $F_LIBRARY>>$LOG;((_F&F_LIBRARY))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d n.a." "F_PACKAGE|PACKAGE" $F_PACKAGE>>$LOG;((_F&F_PACKAGE))&&echo "*">>$LOG||echo>>$LOG
    echo "(">>$LOG
    printf "   %-27s:%d" "F_FILENAME|FILENAME" $F_FILENAME>>$LOG;((_F&F_FILENAME))&&echo "*">>$LOG||echo>>$LOG
    printf "  |%-27s:%d" "F_FILEPATHNAME|FILEPATHNAME" $F_FILEPATHNAME>>$LOG;((_F&F_FILEPATHNAME))&&echo "*">>$LOG||echo>>$LOG
    echo ")">>$LOG
    printf "%-30s:%d n.a." "F_CLASSNAME|CLASSNAME" $F_CLASSNAME>>$LOG;((_F&F_CLASSNAME))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "F_FUNCNAME|FUNCNAME" $F_FUNCNAME>>$LOG;((_F&F_FUNCNAME))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "F_LINENUMBER|LINENUMBER" $F_LINENUMBER>>$LOG;((_F&F_LINENUMBER))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "F_SEVERITY|SEVERITY" $F_SEVERITY>>$LOG;((_F&F_SEVERITY))&&echo "*">>$LOG||echo>>$LOG
    echo "(">>$LOG
    printf "   %-27s:%d" "F_SUBSYSRAW|SUBSYSRAW" $F_SUBSYSRAW>>$LOG;((_F&F_SUBSYSRAW))&&echo "*">>$LOG||echo>>$LOG
    printf "  |%-27s:%d" "F_SUBSYSNUM|SUBSYSNUM" $F_SUBSYSNUM>>$LOG;((_F&F_SUBSYSNUM))&&echo "*">>$LOG||echo>>$LOG
    printf "  |%-27s:%d" "F_SUBSYSSTR|SUBSYSSTR" $F_SUBSYSSTR>>$LOG;((_F&F_SUBSYSSTR))&&echo "*">>$LOG||echo>>$LOG
    echo ")">>$LOG
    echo "(">>$LOG
    printf "   %-27s:%d" "F_LEVELRAW|LEVELRAW" $F_LEVELRAW>>$LOG;((_F&F_LEVELRAW))&&echo "*">>$LOG||echo>>$LOG
    printf "  |%-27s:%d" "F_LEVELNUM|LEVELNUM" $F_LEVELNUM>>$LOG;((_F&F_LEVELNUM))&&echo "*">>$LOG||echo>>$LOG
    printf "  |%-27s:%d" "F_LEVELSTR|LEVELSTR" $F_LEVELSTR>>$LOG;((_F&F_LEVELSTR))&&echo "*">>$LOG||echo>>$LOG
    echo ")">>$LOG
    printf "%-30s:%d" "F_CODE|CODE" $F_CODE>>$LOG;((_F&F_CODE))&&echo "*">>$LOG||echo>>$LOG
    printf "%-30s:%d" "F_MESSAGE|MESSAGE" $F_MESSAGE>>$LOG;((_F&F_MESSAGE))&&echo "*">>$LOG||echo>>$LOG
    echo "(">>$LOG
    printf "   %-27s:%d" "F_COLOR|COLOR" $F_COLOR>>$LOG;((_F&F_COLOR))&&echo "*">>$LOG||echo>>$LOG
    printf "  |%-27s:%d" "F_NOCOLOR|NOCOLOR" $F_NOCOLOR>>$LOG;((_F&F_NOCOLOR))&&echo "*">>$LOG||echo>>$LOG
    echo ")">>$LOG
    printf "%-30s:%d" "F_ALL|ALL" $F_ALL>>$LOG;((_F&F_ALL))&&echo "*">>$LOG||echo>>$LOG
	echo>>$LOG
    printf "%-30s\n" "F_FORM|FORM:=(">>$LOG;    
    printf "   %-27s:%d\n" "F_CON|CON" $F_CON>>$LOG;
    printf "   %-27s:%d\n" "|F_TAB|TAB" $F_TAB>>$LOG;
    printf "   %-27s:%d\n" "|F_SYS|SYS" $F_SYS>>$LOG;
    printf "   %-27s:%d\n" "|F_LOG4J|LOG4J" $F_LOG4J>>$LOG;
    printf "   %-27s:%d\n" "|F_CSV|CSV" $F_CSV>>$LOG;
    printf "   %-27s:%d\n" "|F_XML|XML" $F_XML>>$LOG;
    printf "   %-27s:%d\n" "|F_HTML|HTML" $F_HTML>>$LOG;
    printf "   %-27s:%d\n" "|F_JSON|JSON" $F_JSON>>$LOG;
    printf ") == %d\n" $F_FORM>>$LOG;    
	echo>>$LOG
    printf "%-30s:%s\n" "F_FS|FS" "'$_FS'">>$LOG;    
    printf "%-30s:%d\n" "F_I|INDENT" $_IN>>$LOG
    echo >>$LOG
    printf "%-30s:%d\n" "F_EXITCODE_AS_STR|EXITCODE_STR" $F_EXITCODE_AS_STR>>$LOG
    echo >>$LOG
    return 0
}

_E=0
_IN=0
_FS=$F_FS
[[ -z "${F_DEFAULT}" ]]&&F_DEFAULT=$((F_CALLNAME|F_LINENUMBER|F_SEVERITY|F_CODE))
_F=${_F:-$F_DEFAULT}

## \endcond
#P ##
#P # Calculates resulting output-format
#P #
#P # from provided string with list of field bits
#P # Sets the <b>global variable _F</b>
#P # 
#P # @param a $1:= csv-string of output-bits
#P # @ingroup utalm_bash
#P def setFormat(a):
#P 	pass
## \cond
function setFormat () {
	local _f=;
	for i in ${1//%/ };do
		case $i in
        	#F_I|INDENT)F=$((F|F_I));;
        	[fF]_[iI]=*|[iI][nN][dD][eE][nN][tT]=*)_IN="${i#*=}";continue;;
        	[fF]_[fF][sS]=*|[fF][sS]=*)_FS="${i#*=}";continue;;
        	[fF]_[fF][oO][rR][mM]=*|[fF][oO][rR][mM]=*)
        		F_FORM=$(formatToNum ${i#*=});continue;;
			*)a=$(formatToNum $i);;		
		esac
		case $a in
		$F_EXITCODE_AS_STR)
			_E=1;
			;;
		-1)
			((a==-1))&&exit 0
			;;
		*)
			_f=$((_f|a));
			;;
		esac
	done
	_F=${_f:-$F_DEFAULT}
}



## \endcond
#P ##
#P # Prints curretn configuration
#P #
#P # @ingroup utalm_bash
#P def printCurrentConfig():
#P 	pass
## \cond
function printCurrentConfig () {
	echo >>$LOG
	echo "Current library: ${MYLIBPATHNAME}">>$LOG
	echo "">>$LOG
	printf "" >>$LOG
    #    printf "%-30s:%d" "F_DATE|DATE" $F_DATE>>$LOG;((_F&F_DATE))&&echo "*">>$LOG||echo>>$LOG
	printf "%-30s:%s\n" "WNG" $WNG>>$LOG
	printf "%-30s:%s\n" "DBG" $DBG>>$LOG
    printf "%-30s:%s\n" "INF" $INF>>$LOG
	printf "%-30s:%s\n" "_CH" $_CH>>$LOG
	printf "%-30s:%s\n" "_FS" $_FS>>$LOG
	printf "%-30s:%s\n" "_F" $_F>>$LOG

	printf "%-30s:%s\n" "MYLIBPATHNAME" $MYLIBPATHNAME>>$LOG
	printf "%-30s:%s\n" "MYLIBNAME" $MYLIBNAME>>$LOG
	printf "%-30s:%s\n" "\${BASH_ARGV[@]}"  "${BASH_ARGV[@]}">>$LOG
	printf "%-30s:%s\n" "M" $M>>$LOG
	printf "%-30s:%s\n" "F_FORM" $F_FORM>>$LOG
	printf "%-30s:%s\n" "_F" $_F>>$LOG




	echo "">>$LOG
	echo "Following could be pre-set by bash-environment:">>$LOG
	echo "">>$LOG
	echo "   Using libraries: MYLIBPATH    = ${MYLIBPATH}">>$LOG
	echo "   Using documents: MYDOCBASE    = ${MYDOCBASE}">>$LOG
	echo "   Using config:    MYCONFPATH   = ${MYCONFPATH}">>$LOG
	echo "   Using language:  MYLANG       = ${MYLANG}">>$LOG
	echo "">>$LOG
	echo "   Using language:  MANPATH      = ${MANPATH}">>$LOG
	echo "">>$LOG
	echo "   Using for html:  BROWSER      = ${BROWSER}">>$LOG
	echo "   Using for html:  DEFAULT_HELP = ${DEFAULT_HELP}">>$LOG
	echo "">>$LOG
	echo "   Using for pdf:   PDFVIEWER    = ${PDFVIEWER}">>$LOG
	echo "">>$LOG
}



## \endcond
#P ##
#P # Prints short help
#P #
#P # Formats: CONF, HTML, PDF, MAN
#P #
#P # @ingroup utalm_bash
#P def printHelp():
#P 	pass
## \cond
function printHelp () {
	local X=;
	if [ -n "$2" ];then
		#local X=`echo ${1}|tr '[:upper:]' '[:lower:]'`;shift;
		local X=${1};shift;
		fi
	local A=`echo ${*}|tr '[:lower:]' '[:upper:]'`;shift;
	case $A in
		CONF|CONFIG|C)printCONF=1
			;;
		HTML|H)
			if [ -n "$BROWSER" ];then
				if [ -e "$X" ];then
					$BROWSER ${X} &
					return
				fi
								
				local _MYDOC=${DEFAULT_HELP}
				echo "CALL:$BROWSER ${_MYDOC}">>$LOG
				if [ ! -e "${_MYDOC}" ];then
					echo "ERROR:Missing:${_MYDOC}">>$LOG 
					echo "INFO:Check/set MYDOCBASE=${MYDOCBASE}">>$LOG 
					exit 1
				fi
				if [ -n "$X" ];then
					_MYDOC=${_MYDOC%/*/index.html}
					_MYDOC=${_MYDOC%/*.html}
					_MYDOC=${_MYDOC%/man[0-9]}
					local _matched=0
					for m in man1 man2 man3 man4 man5 man6 man7;do
						(($_matched))&&continue
						if [ -e ${_MYDOC}/$m/$X.html ];then
							_MYDOC=${_MYDOC}/$m/$X.html
							_matched=1
						fi
						if [ -e ${_MYDOC}/$m/$X/index.html ];then
							_MYDOC=${_MYDOC}/$m/$X/index.html
							_matched=1
						fi
					done
																								
				fi
				$BROWSER ${_MYDOC} &
			fi
			exit 0
		    ;;
		PDF|P)
			if [ -n "$PDFVIEWER" ];then
				if [ -e "$X" ];then
					$PDFVIEWER ${X} &
					return
				fi
								
				local _MYDOC=${MYDOCBASE}/pdf/man3/utalm-bash.pdf
				echo "CALL:$PDFVIEWER ${_MYDOC}">>$LOG
				if [ ! -e "${_MYDOC}" ];then
					echo "ERROR:Missing:${_MYDOC}">>$LOG 
					echo "INFO:Check/set MYDOCBASE">>$LOG 
					exit 1
				fi
				if [ -n "$X" ];then
					_MYDOC=${_MYDOC%/*.pdf}
					_MYDOC=${_MYDOC}/$X.pdf
				fi
				$PDFVIEWER ${_MYDOC} &
			fi
			exit 0
			;;
		MAN|M)
			echo "INFO:Using documents from:MANPATH=${MANPATH}">>$LOG
			echo "CALL:man -M $MANPATH 3 utalm-bash">>$LOG
			local _m=utalm-bash
			if [ -n "$X" ];then
				_m=$X
			fi
			man -M $MANPATH 3 $_m
			exit 0
			;;
	esac
	((printCONF!=1))&&{
    cat <<EOF
UnifiedTraceAndLogManager-bash: libutalm.sh

CALL: 
   ...-d [DebugOptions]...
   ...--debug=[DebugOptions]...

OPTIONS:

   Output filter parameters:
     SUBSYSTEM|S (for values call "-d s:help")
     WARNING|W (for values call "-d l:help")
     INFO|I (for values call "-d l:help")
     LEVEL|L (for values call "-d l:help")
     PRINTFINAL|PFIN|PF (for values call "-d l:help")
     [0-9]* (sets LEVEL+INFO+WARNING)

     (PATTERN|P|MIN|MAX)

   Output format parameters:
     EXITVALUES|E (for values call "-d e:help", activated by F_EXITCODE_AS_STR)
     FORMAT|F (for values call "-d f:help")

   Output direction parameters: (for values call "-d logout:help")
     LOGOUT|OUT=<target-stream> (default: $OUT_DEFAULT)
     LOGRING|RING=<#target-streams> (valid only for files)
     LOGMAX=<#size-stream> (valid only for files, max size)

   Switch to test mode for Unit and Rgeression Tests:
    TESTMODE|TM|T (for values call "-d t:help")

   H|HELP:(HTML|MAN|PDF|CONF) (Most comprising is HTML)

Special cases:

  - for extended HELP:   $0 -d help:html   
  - for toubleshooting:  $0 -d help:conf
  - extended troubleshooting
    - install devel package
    - call "make test" in install-root, this
      is also done by install package for 
    verification, you can add "DBG=1" for
      (lots of) verbose output
EOF
}		
}


## \endcond
#P ##
#P # Prints the title record with fieldnames
#P #
#P # @ingroup utalm_bash
#P def _printTitle():
#P 	pass
## \cond
function _printTitle () {
    local r=$?;
    local _title=""
    #    ((F_S!=0))_CH=$(printf)||_CH=
    ((_F&F_CALLNAME))&&_title="${_title}${_FS}CALLNAME";
	if((_F&F_RLOGINDNS));then _title="${_title}${_FS}RLOGINDNS";else 
		if((_F&F_RLOGINIP));then _title="${_title}${_FS}RLOGINIP";else 
			if((_F&F_USERSTR));then _title="${_title}${_FS}USERSTR";else
				if((_F&F_USERNUM));then _title="${_title}${_FS}USERNUM";fi
			fi
			if((_F&F_GROUPSTR));then _title="${_title}${_FS}GROUPSTR";else
				if((_F&F_GROUPNUM));then _title="${_title}${_FS}GROUPNUM";fi
			fi
		fi
	fi
    if((_F&F_DATE&F_TIME));then
	_title="${_title}${_FS}DATE${_FS}TIME";
    else
	((_F&F_DATE))&&_title=${_title}${_FS}DATE;
	((_F&F_TIME))&&_title=${_title}${_FS}TIME;
    fi
    ((_F&F_PID))&&_title="${_title}${_FS}PID";
    ((_F&F_PPID))&&_title=${_title}${_FS}PPID;
    {
	((_F&F_FILENAME))&&{ _title=${_title}${_FS}FILENAME; }||{ ((_F&F_FILEPATHNAME))&&_title="${_title}${_FS}FILEPATHNAME"; }
	shift;
    }
    ((_F&F_LINENUMBER))&&_title="${_title}${_FS}LINENUMBER";
    if((_F&F_SUBSYSSTR));then _title="${_title}${_FS}SUBSYSSTR";else ((_F&F_SUBSYSNUM))&&_title="${_title}${_FS}SUBSYSNUM";fi
    if((_F&F_LEVELSTR));then _title="${_title}${_FS}LEVELSTR";else 
    	if((_F&F_LEVELNUM));then _title="${_title}${_FS}LEVELNUM";fi
	fi
    ((_F&F_CODE))&&_title="${_title}${_FS}CODE";
    ((_F&F_SEVERITY))&&_title="${_title}${_FS}SEVERITY";
    _title="${_title}${_FS}DATA";
    _title=${_title#$_FS}
    echo ${_title}>>$LOG
    return $r
}


## \endcond
#P ##
#P # Fetch argv
#P #
#P # Is implicitly called, fetches suboptions for '-d ...'
#P #
#P # For valid options refer to <a href="../../man3/utalm-bash.html" target="_blank">utalm-bash(3)</a>
#P #
#P # @ingroup utalm_bash
#P def fetchDBGArgs():
#P 	pass
## \cond
function fetchDBGArgs () {
    if [ -n "`echo ${*}| sed -n 's/([^)]*)//g;s/-d /1/p'`" ];then
	C_DARGS=`echo " ${*} "| sed -n 's/^.*-d  *\([^ \t)]*\)[ \t)].*$/\1/p'`
	local i=;
	local KEY=;
	local ARG=;
	local printCONF=0
	setFormat
		
	local _C_DARGS=${C_DARGS//[,()]/ }
	for i in ${_C_DARGS};do
	    KEY=`echo ${i%%:*}|tr '[:lower:]' '[:upper:]'`
	    ARG=`echo ${i}|awk -F':' '{print $2}'`
	    case $KEY in
		LOGOUT|OUT)
			case "$ARG" in
				[hH][eE][lL][pP]) 
cat <<EOF
LOGOUT|LOG:
=========== 
  Sets the output logstream target. The default target
  is stderr, while the full scope of bash redirection 
  is provided.

  Either files or special values:

   (1|2|stdout|stderr)
 
  The logstream could be redirected to a file based 
  ringbuffer, where the following parameters are
  provided:

LOGRING|RING:
=============
  Number of logstreams witten to in sequential stream,
  each by line<LOGMAX, before switched to the next.
  When the last is reached the cycle startsup again.
  Each new start pre-deletes the previous data.

LOGMAX:
=======
  Maximum number of lines for each stream.

Special cases:
==============
  ONE stream:
    Just uses the only and one.

  LOGOUT is not a file and RING>1:
    This is not supported, thus an error.
								
Example:
========
${0##*/} -d LOGOUT:myFile,LOGRING:3,LOGMAX:20000
    Logs into "myFile.[0-2]", where each is changed
    in ringbuffer after 20000 lines.
								
${0##*/} -d LOGOUT:1,LOGRING:3,LOGMAX:20000
    Logs into stdout "/dev/fd/1", where each is changed
    in ringbuffer after 20000 lines.
EOF
				exit 0
				;;
				stdout)
				LOG=/dev/fd/1
				#echo "INFO:Redirected output:$LOG">&2								
				;;
				stderr)
				LOG=/dev/fd/2
				#echo "INFO:Redirected output:$LOG">&2
				;;
				[0-9])
				LOG=/dev/fd/$ARG
				case $ARG in
					[12])
					#echo "INFO:Redirected output:$LOG">&2
					;;
					[03456789])
					#echo "WARNING:Use from now output:$LOG">&2
					;;
				esac
				;;
				*)
				if [ -e "$ARG" ];then
					LOG=$ARG
				else
					if [ -d "${ARG%/*}" ];then
						LOG=$ARG
					else
						echo "ERROR:Unknown output stream \"$ARG\". If not exists requires present directory-prefix">>$LOG
						echo "ERROR:E.g. \"tmp/tests/$ARG\", when tmp exists in \"PWD\".">>$LOG
						echo "ERROR:or e.g. \"/tmp/bld/tests/$ARG\", for absolute filepath.">>$LOG
						exit 1;
					fi					
				fi
				;;
			esac
   		    ;;
		LOGRING|RING)
			if [ -n "${ARG//[0-9]/}" ];then
				echo "ERROR:Only numeric values LOGRING=$ARG">>$LOG
				exit 1;
			fi
			LR=$ARG;		
   		    ;;
		LOGMAX)
			if [ -n "${ARG//[0-9]/}" ];then
				echo "ERROR:Only numeric values LOGMAX=$ARG">>$LOG
				exit 1;
			fi
			LM=$ARG;		
   		    ;;	    	
		EXITVALUES|E)
            exitToNum ${ARG}
		    ;;
		FORMAT|F)
		    setFormat ${ARG:-0}
   		    ;;
		SUBSYSTEM|SUBSYS|S)
            _S=$(subsysToNum ${ARG})
		    ((_S==-1))&&exit 0;
		    export _S
		    ;;
		PATTERN|P)MTYPE=1;M=1;;
		MIN)MTYPE=2;M=2;;
		MAX)MYTPE=4;M=4;;
		WARNING|WNG|W)
		    WNG=$(levelToNum ${ARG:-0})
		    ((WNG==-1))&&exit 0;
		    export WNG
		    ;;
		INFO|I)
		    INF=$(levelToNum ${ARG:-0})
		    ((INF==-1))&&exit 0;
		    export INF
		    ;;
		LEVEL|LVL|L)
		    DBG=$(levelToNum ${ARG:-0})
		    #levelToNum ${ARG:-0}
		    export DBG
		    ((DBG==-1))&&exit 0;
		    ;;
		[0-9]*)
		    export DBG=$(levelToNum ${KEY})
		    ((DBG==-1))&&exit 0;
		    export INF=$DBG
		    export WNG=$DBG
		    ;;
		PRINTFINAL|PFIN|PF)
		    export C_PFEXE=$(levelToNum ${ARG:-0})
		    ((C_PFEXE==-1))&&exit 0;
		    ;;
		TITLE)
			_printTitle
			;;
		TESTMODE|TM|T)
			. $(getPathToLib.sh libutalmrefpersistency.sh)
			if((__UTALMREFPERSISTOBJS__!=1));then
				echo "ERROR:TESTMODE:cannot load:libutalmfileobjects.sh">&2
				echo "utalm_exit:$E_SYS">>$LOG
				exit $E_SYS
			fi
			. $(getPathToLib.sh libutalmfileobjects.sh)
			if((__UTALMFILEOBJS__!=1));then
				echo "ERROR:TESTMODE:cannot load:libutalmrefpersistency.sh">&2
				echo "utalm_exit:$E_SYS">>$LOG
				exit $E_SYS
			fi
		    export TESTMODE=$(testmodeToNum ${ARG:-0})
		    ((TESTMODE==-1))&&exit 0;
		    ;;
		H|HELP)
			printHelp $ARG
			((printCONF==1))||exit 0;
		    ;;
		*)
		    local _l=$(levelToNum ${KEY})
			if((_l==-1));then
			    echo "DBG:unknown value:$KEY">>$LOG
			    exit 1;
			fi
		    export DBG=$_l
		    export INF=$_l
		    export WNG=$_l
		    ;;
	    esac
	done
	C_DARGS=" -d ${C_DARGS} "
	DARGS=" ${C_DARGS} "
    fi
	r=$?
	((printCONF==1))&&printCurrentConfig&&exit 0
	return $r        
}
fetchDBGArgs $*
if [ -n "`echo $*| sed -n 's/-y/1/p'`" ];then
    export UTALM_XTERM=0;
fi



_CH=""

## \endcond
#P ##
#P # Creates the current header in global variable _CH
#P #
#P #	printDBG <subsys> <dbg-level> <line> <file> <code>
#P # 
#P # @param a $1:= subsys
#P # @param b $2:= dbg-level
#P # @param c $3:= line
#P # @param d $4:= file
#P # @param e $5:= code
#P # @ingroup utalm_bash
#P def _getHead(a,b,c,d,e):
#P 	pass
## \cond
function _getHead () {
    local r=$?;
    local s=$1;
    local l=$2;
    local li=$3;
    local f0=$4;
    local c=$5;
    #    ((F_S!=0))_CH=$(printf)||_CH=
    ((_F&F_CALLNAME))&&_CH="${_CH}${_FS}${MYCALLNAME}";
	if((_F&F_RLOGINDNS));then _CH="${_CH}${_FS}${MYUID}@${MYHOST}";else 
		if((_F&F_RLOGINIP));then _CH="${_CH}${_FS}${MYUID}@${MYHOSTIP}";else 
			if((_F&F_USERSTR));then _CH="${_CH}${_FS}${MYNAME}";else
				if((_F&F_USERNUM));then _CH="${_CH}${_FS}${MYUID}";fi
			fi
			if((_F&F_GROUPSTR));then _CH="${_CH}${_FS}${MYGNAME}";else
				if((_F&F_GROUPNUM));then _CH="${_CH}${_FS}${MYGID}";fi
			fi
		fi
	fi
    if((_F&F_DATE&F_TIME));then
	_CH="${_CH}${_FS}$(date +%Y%m%d${_FS}%H%M%S)";
    else
	((_F&F_DATE))&&_CH="${_CH}${_FS}$(date +%Y%m%d)";
	((_F&F_TIME))&&_CH="${_CH}${_FS}$(date +%H%M%S)";
    fi
    ((_F&F_PID))&&_CH="${_CH}${_FS}$$";
    ((_F&F_PPID))&&_CH="${_CH}${_FS}${PPID}";
    {
	((_F&F_FILENAME))&&{ f=${f0%/*/*};f=${f0#$f\/};_CH="${_CH}${_FS}${f}"; }||{ ((_F&F_FILEPATHNAME))&&_CH="${_CH}${_FS}${f0}"; }
	shift;
    }
    ((_F&F_LINENUMBER))&&_CH="${_CH}${_FS}${li}";
    if((_F&F_SUBSYSSTR));then _CH="${_CH}${_FS}$(subsysToStr ${s})";else ((_F&F_SUBSYSNUM))&&_CH="${_CH}${_FS}${s}";fi
    if((_F&F_LEVELSTR));then _CH="${_CH}${_FS}$(levelToStr ${l})";else 
    	if((_F&F_LEVELNUM));then _CH="${_CH}${_FS}$(levelToNum ${l})";fi
	fi
    ((_F&F_CODE))&&_CH="${_CH}${_FS}${c}";
    _CH=${_CH}${_FS}
    _CH=${_CH#$_FS}
    return $r
}
## \endcond
#P ##
#P # Creates the current header in global variable _CH
#P #
#P #	printDBG <subsys> <dbg-level> <line> <file> <code>
#P # 
#P # @param a $1:= severity
#P # @param b $2:= #severity-color
#P # @param c $3:= subsys
#P # @param d $4:= dbg-level
#P # @param e $5:= line
#P # @param f $6:= file
#P # @param g $7:= code
#P # @param h $8:= message
#P # @ingroup utalm_bash
#P def _printGen(a,b,c,d,e,f,g,h):
#P 	pass
## \cond
function _printGen () {
    local r=$?;
    ((_F&F_SEVERITY))&&local se=${1};shift
    local cc=${1};shift
    local _e=;
    local s=$1;shift;
    local l=$1;
	[[ -n "${1//[0-9]/}" ]]&&l=$D_ERR&&_e="LVL($1)";
    shift;
    local L=$1;
    [[ -n "${1//[0-9]/}" ]]&&L=$S_ERR&&_e=$_e"+LINE($1)";
    shift;
	local f0=${1};
    local f=${1%/*/*};f=${1#$f\/};shift;
    local e=$1;
	[[ -n "${1//[0-9]/}" ]]&&_e=$_e"+CODE($1)";
	shift;
    local o=;
    o="${f}:";
    os=$LOG
    _CH=;
    ((LR>0))&&{
    let _Mx++;
    if((_Mx>LM));then
		_Mx=1
		_Rx=$((_Rx+1))
		_Rx=$((_Rx % LR))
		
		os=${os}.${_Rx}
		#echo -n >$os
    else
		os=${os}.${_Rx}
    fi
	}

    { 
    ((UTALM_XTERM==1))&&{
   		_getHead $s $l $L $f0 $e;echo -e "${_CH}$se${_FS}$*";
    }||{
		_getHead $s $l $L $f0 $e;
       	if((_F&F_SEVERITY));then ((_F&F_COLOR))&&echo -e "${_CH}\033[${cc}m${se:-$_FS$se}\033[m${_FS}$*"||echo -e "${_CH}${se:-$_FS$se}${_FS}$*";
		else  echo -e "${_CH}$*";fi
    }
	}>>${os}
    [[ -n "$_e" ]]&&printERR $LINENO $BASH_SOURCE 1 "UTALM-ERROR:PARAMETER:IN($f0):@($L):$_e"
    return $r;
}

## \endcond
#P ##
#P # Check debug state
#P #
#P #  Returns whether debug level matches. If some specific
#P #  actions to be done. E.g. evaluating time-intensive
#P #  debug actions for tests.
#P #
#P #	doDebug <subsys> <dbg-level> <line> <file>
#P #
#P # @param a $1:= subsys
#P # @param b $2:= dbg-level
#P # @param c $3:= line
#P # @param d $4:= file
#P # @ingroup utalm_bash
#P def doDebug(a,b,c,d):
#P 	pass
## \cond
function doDebug  () {
    ((DBG>0))||return 1;
    if((M&4&&DBG>=$2));then _printGen DBG 30 $* 0 "DBG>on";return 0;fi
    if((M$LOG&&DBG<=$2));then _printGen DBG 30 $* 0 "DBG<on";return 0;fi
    if((M&1&&DBG&$2));then _printGen DBG 30 $* 0 "DBG&on";return 0;fi
    return 1;
}


## \endcond
#P # @anchor bash_printDBGBLOB
#P ##
#P # Print BLOB with a START and END marker instead of record header
#P # 
#P # Prints a trace/log-string as configured by \ref cliSyntaxBash 
#P # 
#P # @param a $1:= subsys
#P # @param b $2:= dbg-level
#P # @param c $3:= line
#P # @param d $4:= fname
#P # @param e $5:= message
#P # @ingroup utalm_bash
#P def printDBGBLOB(a,b,c,d,e):
#P 	pass
## \cond
function printDBGBLOB () {
	local r=$?
	local l=$2
	(((M&4&&DBG>=l)||(M&2&DBG<=l)||(M&1&&DBG&l)))&&{
		_printGen DBG 30 $1 $2 $3 $4 0 BLOB_START
		local _Fold=$_F
		_F=0
		_printGen DBG 30 $1 $2 $3 $4 0 $5
		_F=$_Fold
		_printGen DBG 30 $1 $2 $3 $4 0 BLOB_END
	}
	return $r
}


## \endcond
#P # @anchor bash_printDBG
#P ##
#P # Print trace/log-string
#P # 
#P # Prints a trace/log-string as configured by \ref cliSyntaxBash 
#P # 
#P # @param a $1:= subsys
#P # @param b $2:= dbg-level
#P # @param c $3:= line
#P # @param d $4:= fname
#P # @param e $5:= message
#P # @ingroup utalm_bash
#P def printDBG(a,b,c,d,e):
#P 	pass
## \cond
function printDBG () {
	local r=$?
	local l=$2
	(((M&4&&DBG>=l)||(M&2&DBG<=l)||(M&1&&DBG&l)))&&_printGen DBG 30 $1 $2 $3 $4 0 $5
	return $r
}


## \endcond
#P ##
#P # Print trace/log-string for errors
#P # 
#P # @param a $1:= line
#P # @param b $2:= fname
#P # @param c $3:= code
#P # @param d $4:= message
#P # @ingroup utalm_bash
#P def printERR(a,b,c,d):
#P 	pass
## \cond
function printERR () {
	local r=$?
	_printGen ERR 31 $S_ALL $D_ALL $*
	return $r
}


## \endcond
#P ##
#P # Print trace/log-string for warnings
#P # 
#P # Prints a trace/log-string when called with more than one option 
#P # and matches current level. 
#P # 
#P # @param a $1:= warning-level
#P # @param b $2:= line
#P # @param c $3:= fname
#P # @param d $4:= code
#P # @param e $5:= message
#P # @ingroup utalm_bash
#P def printWNG(a,b,c,d,e):
#P 	pass
## \cond
function printWNG () {
	local r=$?
	local l=$1
	(((M&4&&WNG>=l)||(M&2&WNG<=l)||(M&1&&WNG&l)))&&_printGen WNG 35 $S_ALL $*
	return $r
}


## \endcond
#P ##
#P # Print trace/log-string for info
#P # 
#P # Prints a trace/log-string when called with more than one option 
#P # and matches current level. 
#P # 
#P # @param a $1:= info-level
#P # @param b $2:= line
#P # @param c $3:= fname
#P # @param d $4:= code
#P # @param e $5:= message
#P # @ingroup utalm_bash
#P def printINFO(a,b,c,d,e):
#P 	pass
## \cond
function printINFO () {
	local r=$?
	local l=$1
	(((M&4&&INF>=l)||(M&2&INF<=l)||(M&1&&INF&l)))&&_printGen INFO 32 $S_ALL $*
	return $r
}


## \endcond
#P ##
#P # Prints final call strings
#P # 
#P # Prints a trace/log-string of a string prepared to be executed when called with more
#P # than one option and matches current level. 
#P # 
#P # @param a $1:= level
#P # @param b $2:= line
#P # @param c $3:= fname
#P # @param d $4:= title
#P # @param e $5:= exec-or-call-string
#P # @ingroup utalm_bash
#P def printFINALCALL(a,b,c,d,e):
#P 	pass
## \cond
function printFINALCALL () {
    local r=$?;
    local l=$1;shift;
    [ -n "$C_PFEXE" ]&&((C_PFEXE>=l))||return $r;
    local L=$1;shift;
    local f=${1%/*/*};f=${1#$f\/};shift;
    local t=${1};shift;
    local a=${*//  / };
    if((DBG<0));then 
		if [ "$UTALM_XTERM" == 1  ];then local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:PRINT:\n$t\n>\n${a//  / }\n<";
		else local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:$f:$L:\033[32mPRINT\033[m:\n\033[1m\033[4m$t\033[m\n\033[1m===>\033[m\n${a//  / }\n\033[1m<===\033[m";fi
    else
		if [ "$UTALM_XTERM" == 1  ];then local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:PRINT:\n$t\n>\n${a//  / }\n<";
		else local b="${MYCALLNAME}:${MYUID}@${MYHOST}:$$:\033[32mPRINT\033[m:\n\033[1m\033[4m$t\033[m\n\033[1m===>\033[m\n${a//  / }\n\033[1m<===\033[m";fi
    fi
    shift; echo -e "$b" >>$LOG;
    return $r;
}


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
#P # @param a $1:= line LINENO of caller
#P # @param b $2:= file BASH_SOURCE of caller
#P # @param c $3:= exec-or-call-string The call to be wrapped
#P # @ingroup utalm_bash
#P def callErrOutWrapper(a,b,c):
#P 	pass
## \cond
function callErrOutWrapper () {
    printDBG $S_LIB ${D_IN} $LINENO $BASH_SOURCE "$FUNCNAME:<${@}>"
    local _originLine=$1;shift
    local _originFile=$1;shift
    local _cli=$*
    local _res=0
    printDBG $S_LIB $D_BULK $_originLine "$_originFile" "$FUNCNAME:<${@}>"

    if [ -n "${UTALM_NOCALLWRAPPER}" ];then
	${_cli}
	return $?
    fi
    exec 3>&1
    exec 4>&2
    local _buf=`{ (eval "${_cli}";) } 2>&1 1>&3;echo -n "_-_-_$?";`
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
    printDBG $S_LIB ${D_OUT} $_originLine "$_originFile" "$FUNCNAME:_res=<${_rd}>"
    printDBG $S_LIB ${D_SYS} $_originLine "$_originFile" "$FUNCNAME:`setSeverityColor TRY \"call(${_cli})\"` => [ ${_rd} ]"
    return $_res
}


## \endcond
#P ##
#P # Checks condition by "eval" of condition
#P # 
#P # The assert in bash call is syntactical identical to compiled  
#P # languages, but slightly different in execution. The reason 
#P # is the execution order of parameters and the result-passing
#P # of subcalls. In bash scripts a logical operations evaluates  
#P # to a global state variable represented by "$?". Thus an inline
#P # condition is passed literally or the stdout stream. 
#P # 
#P # For the prefered syntactical similarity the parameter value is 
#P # catched and if not representing a 'shell type boolean' processed 
#P # by 'eval' before the check of expected logical value. 
#P # 
#P # @param a $1:= LINENO of caller
#P # @param b $2:= BASH_SOURCE of caller
#P # @param c $3:= condition
#P #   * 0 : boolean True
#P #   * [0-9]* : boolean False
#P #   * anything else : logical expression to be evaluated, '$?' applied  
#P # 
#P # 
#P # @return with 1 for False
#P # @ingroup libutalm_tdd
#P def assert(a,b,c):
#P 	pass
## \cond
function assert () {
	local a=$1;shift
	local b=$1;shift
	local e=$*
	local o=$*
	printINFO 3 $a $b 1  "$*"
		
	[[ -n "${e//[0-9]/}" ]]&&{
		x=${*// /_}
		x=${x//'
'/_}
		x=${x//[_/[ }
		x=${x//_]/ ]}
		x=${x//_[/ [}
		x=${x//]_/] }
		x=${x//_==_/ == }
		x=${x//_=_/ = }
		x=${x//_!=_/ != }
		x=${x//_=~_/ =~ }
		x=${x//_<_/ < }
		x=${x//_>_/ > }
								
		x=${x//_-eq_/ -eq }
		x=${x//_-ge_/ -ge }
		x=${x//_-gt_/ -gt }
		x=${x//_-le_/ -le }
		x=${x//_-lt_/ -lt }
		x=${x//_-ne_/ -ne }
																
		x=${x//_<_/ < }
		x=${x//_>_/ > }
		x=${x//_<=_/ <= }
		x=${x//_>=_/ >= }
		
		x=${x//_&_/ & }
		x=${x//_|_/ | }
		x=${x//_&&_/ && }
		x=${x//_||_/ || }

		eval $x 2>&1 >/dev/null
		e=$?
	}
	((e==0))&&return 0
				
	if((_E==1));then
		o=$(exitToStr $e)
	fi
	if((_E==1));then
		o=$(exitToStr $e)
	else
		o=$e
	fi
	printINFO 1 $a $b 1  "Assertion failed:$o"
	echo "utalm_exit:$o">>$LOG
	exit $e
}


## \endcond
#P ##
#P # Counts errors for SUnit and regression tests. 
#P # 
#P # A filter for counting results represented by  
#P # gotoHell call. Calculates values by evaluating  
#P # the output stream for strings: 
#P # 
#P #    "utalm_exit:#value"
#P #    "utalm_sum_of_errors:#value"
#P # 
#P # The output is directed by <b>default</b> to <b>stderr</b>.
#P #
#P # Counts the number of exit!=0, the exit-value itself is ignored.
#P # This the displayed exit value could be a symbolic name too.
#P #
#P # \attention The parameters could be forced to be ignored by
#P #    setting environment variable **COUNTERRORS_OPTS**
#P #    and **COUNTERRORS_OPTS_FORCE**,
#P #    which are evaluated in addition as final set of settings.
#P #
#P # The settings by **COUNTERRORS_OPTS** will overwrite previous.
#P # The settings by **COUNTERRORS_OPTS_FORCE** will replace all previous.
#P # This is a special handling of priorities, but quite handy 
#P # for this application. This has for now some gaps, but 
#P # provides in most cases some flexibility.
#P #
#P # @param a $*:=options-list Controls the filter characteristics:\n
#P #   
#P #	asone        = 0|1     :change value-name on: utalm_exit / off:utalm_sum_of_errors
#P #	expect       = #errors :expected number of provoked errors, mapped to 0
#P #	flat         = 0|1     :indent on/off
#P #	intermediate = 0|1     :display subcounts on/off
#P #	filter       = 0|1     :display all or calc only
#P #	origin       = 0|1     :display origin 
#P #	sums         = 0|1     :display sums of sub-counts on/off
#P #	help                   :this
#P #
#P # @return error count displayed as configured e.g. sum with sub-sums
#P # @ingroup libutalm_tdd
#P def countErrors(a):
#P 	pass
## \cond
function countErrors () {
	local expect=0;
	local flat=1;
	local filter=1;
	local intermediate=1;
	local sums=1;
	local origin=1;
	local silent=0;

	function _setOpts ()	{
		for i in $*;do
			case $i in
				expect=*)expect=${1#*=};;
				origin=*)origin=${1#*=};;
				flat=*)flat=${1#*=};;
				filter=*)filter=${1#*=};;
				intermediate=*)intermediate=${1#*=};;
				sums=*)sums=${1#*=};;
				silent=*)silent=${1#*=};;
				-h|--help|help)cat <<EOF

CALL:    ${0##*/} [options]

DESCRIPTION:
  A filter for counting results represented by gotoHell call. Calculates values
  by evaluating the output stream for strings:

    "utalm_exit:#value" 
    "utalm_sum_of_errors:#value" 

OPTIONS:
  asone         = 0|1     :change value-name on: utalm_exit / off:utalm_sum_of_errors
  expect        = #errors :expected number of provoked errors, mapped to 0
  flat          = 0|1     :indent on/off
  filter        = 0|1     :display all or calc only
  intermediate  = 0|1     :display subcounts on/off
  sums          = 0|1     :display sums of sub-counts on/off
  silent        = 0|1     :display supresses prints, just exit value - on/off
  origin        = 0|1     :display origin 
  help                    :this
	
ENVIRONMENT:
  COUNTERRORS_OPTS        : appends content to call, options are reassigned
  COUNTERRORS_OPTS_FORCE  : replaces call options by content
		
EOF
				exit 0
				;;
			esac
			shift
		done
	}
	#COUNTERRORS_OPTS=${COUNTERRORS_OPTS:$*}
	if [ -n "${COUNTERRORS_OPTS_FORCE}" ];then
		_setOpts ${COUNTERRORS_OPTS_FORCE}
	else				
		_setOpts ${*}
		_setOpts ${COUNTERRORS_OPTS}
	fi
	awk -v asone="$asone" -v expect="$expect" -v flat="$flat" -v filter="$filter" -v intermediate="$intermediate" -v sums="$sums" -v origin="$origin" -v silent="$silent" '
		BEGIN{
			ecnt=0;
			m=0;
			current="";
		}

		origin==1&&$0~/Change to:/{
			current=$0;
			gsub("^.*Change to:","",current);
			current=substr(current,length(current)-35);
			gsub("^[^/]*/",".../",current)
		}

		origin==1&&$0~/return from:/{
			gsub("/[^/]*[/]*$","",current);
		}

		origin==1&&$0~/Call test:/{
			current=$0;
			gsub("^.*Call test:","",current);
			gsub("[ \t][^ ].*$","",current);
			gsub("'"$PWD/"'","",current);
			gsub("/.*$","",current);
			#gsub("[^/]*$","",current);
			current=substr(current,length(current)-40);
			gsub("^[^/]*/",".../",current)
		}

		filter==0&&$NF!~/utalm_exit:.*$/&&$NF!~/utalm_sum_of_errors:.*$/{
			print $0;
		}
		
		sums==0&&$0~/utalm_exit/&&$0~/ecnt=/{
			print $0;
		}

		$NF~/utalm_exit:.*$/&&$0!~/ecnt=/{
			x=$NF;
			gsub("^.*:","",x);
			if(x!=0&&x!~/^E_OK$/){ecnt+=1;m+=1}
			if(x!~/^[0-9]+$/&&x!~/^E_[^0-9][0-9A-Za-z_]*$/){
				print "#WARNING:Missing valid-exit-value>:\"" $0 "\"";
				m-=1;
			}
			if(intermediate==1){
			if(flat==1){
				x=$NF;
				gsub("^.*utalm_exit","utalm_exit",x);
				if(silent==0)printf("ecnt=%04d  %25-s%s\n", ecnt, x,current);
			}else{
				a=$NF;
				N=$0;
				gsub("utalm_exit:.*$","",N);
				N=N" ecnt=" ecnt " " a;
				if(silent==0)print N;
			}
			}
			next;
		}
		
		$NF~/utalm_sum_of_errors:.*$/&&$0!~/ecnt=/{
			x=$NF;
			gsub("^.*:","",x);
			if(x!=0&&x!~/^E_OK$/){ecnt+=x;m+=x}
			if(x!~/^[0-9]+$/&&x!~/^E_[^0-9][0-9A-Za-z_]*$/){
				print "#WARNING:Missing <valid-exit-value>:\"" $0 "\"";
				m-=1;
			}
			if(intermediate==1){
			if(flat==1){
				x=$NF;
				gsub("^.*utalm_sum","utalm_sum",x);
				if(silent==0)printf("ecnt=%04d  %25-s%s\n", ecnt, x,current);
				
			}else{
				a=$NF;
				N=$0;
				gsub("utalm_sum_of_errors:.*$","",N);
				N=N" ecnt=" ecnt " " a;
				if(silent==0)print N;
			}
			}
			next;
		}
		END{
			if(m==0&&ecnt!=0){
				print "#WARNING:No strings \"utalm_exit:<valid-exit-value>$\" found";
			}
			if(m!=ecnt){
				print "#WARNING:Strings without valid <valid-exit-value> found";
			}
			if(expect!=0){		
				if(expect==ecnt){
					if(silent==0)print "utalm_sum_of_errors:0";
					exit 0;
				}
				if(silent==0)print "utalm_sum_of_errors:1";
				exit 1;
			}
			if(silent==0)printf("utalm_sum_of_errors:%d\n",ecnt);
			exit ecnt;
		}'>>$LOG
}


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
#P # @param a $1:= LINENO of caller
#P # @param b $2:= BASH_SOURCE of caller
#P # @param c $3:= ERROR|WARNING|WARNINGEXT
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
#P # @param d $4:= exec callee
#P # @param e $5:= default path
#P # @return 
#P # <ul>
#P #   <li>SUCCESS:= 0 + echo absolute-pathname</li>
#P #   <li>FAILURE:= 1</li>
#P # </ul>
#P # 
#P # @ingroup utalm_bash
#P def getPathName(a,b,c,d,e):
#P 	pass
## \cond
function getPathName () {
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
#P # @param a $1:= LINENO of caller
#P # @param b $2:= BASH_SOURCE of caller
#P # @param c $3:= EXIT values.
#P # @return with given code
#P # @ingroup utalm_bash
#P def gotoHell(a,b,c):
#P 	pass
## \cond
function gotoHell () {
	local e=$3
	printINFO 1 $1 $2 1  "Requested exit:$3"
	if((_E==1));then
		e=$(exitToStr $e)
	fi
	echo "utalm_exit:$e">>$LOG
	exit $e
}


fi #*** prevent multiple inclusion
## \endcond #KEEP# PERSISTENT
