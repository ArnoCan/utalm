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
## @ingroup libutalm_tdd
## @ingroup utalm_bash
## @file
## @brief Filesystem helper
##
##  * Source and documentation: @ref libutalmfileobjects.sh
##  * Stripped runtime version: @ref libutalmfileobjects-min.sh
##
## For detailed information on <b>libutalm.sh</b> refer to:
## <ul>
##   <li> 
##     <b><a href="../../man3/utalm-bash-API/index.html">utalm-bash-API(3)</a></b>
##   </li> 
## </ul>
##
##
## This library contains the main library for file system support.
##
## This comprise facilities for following main areas:
##
##   1. Handling of tree based inheritance off modules.
##   2. Creation of reference data for regression tests.  
## \cond #KEEP# PERSISTENT
## <!--#***HEADEND***-->
#
if [ -z "$MYCALLNAME" ];then
	MYCALLNAME=${0##*/}
	MYCALLNAME=${MYCALLNAME%.*}
fi
export MYCALLNAME

if [ -z "$__UTALMFILEOBJS__" ];then #*** prevent multiple inclusion
## \endcond
## __UTALMFILEOBJS__
# Set to "1" when sourced.
# Prevents multiple inclusion
__UTALMFILEOBJS__=1 #*** prevent multiple inclusion
## \cond

## \endcond
## _myLIBNAME_libutalmfileobjects
# Pathname of current libutalm.sh
_myLIBNAME_libutalmfileobjects="${BASH_SOURCE}"
## \cond

## \endcond
## MYLIBPATHNAME
# Pathname of current libutalm.sh
MYLIBPATHNAME="${_myLIBNAME_libutalmfileobjects}"
## \cond

## \endcond
## _MYLIBNAME
# Name of current libutalm.sh
MYLIBNAME="${BASH_SOURCE##*/}"
## \cond

## \endcond
## _myLIBVERS_utalm
# Version of current libutalm.sh, fixed.
_myLIBVERS_libutalmfileobjects="03_01_009"
## \cond

## \endcond
## MYLIBVERS
# Version of current libutalm.sh, current active lib.
MYLIBVERS="${_myLIBVERS_utalmlibutalmfileobjects}"
## \cond



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


## \endcond
#P ##
#P ## @brief Simulates base for file system based inheritance
#P ##
#P ## Prepends a set of search paths into provided PATH, where in 
#P ## redundancy is cleared. The set of search paths contains of 
#P ## each directory beginning with provided start position. This
#P ## enables a "holomorphic inheritance view" onto the
#P ## filesystem structure.
#P ##
#P ## The typical application is the hierarchical handling of  
#P ## file system based regression test libraries, where attributes 
#P ## and methods of upper nodes are inherited from the nodes of 
#P ## superior filesystem position. This provides the hierachical 
#P ## configuration and specialization of test cases with pre-defined 
#P ## default components by multiple levels of configuration files. 
#P #
#P # @param a $1:= start=None 
#P # @param b $2:= top='tests' 
#P # @param c $3:= (PREFIX|POSTFIX) 
#P #
#P # @return with extended path
#P # @ingroup utalm_bash
#P def setUpperTreeSearchPath(a,b,c):
#P 	pass
## \cond
function setUpperTreeSearchPath () {
	local STARTX=${1:-$PWD}
	STARTX=$(bootstrapGetRealPathname $STARTX)
	local TOPx=${2:-/}
	local inpos=${3:-PREFIX}
	local TOPx=$(getUpperTreePathMatch $STARTX $2 0)
	local _c=${PWD#$(bootstrapGetRealPathname $TOPx)}
	local TOPxi=$TOPx
	local _PATHx=$TOPx;	
	for i in ${_c//\// };do
		TOPxi=${TOPxi}/$i
		_PATHx="${TOPxi}:$_PATHx"
	done
	echo -n $_PATHx
	return
}



## \endcond
#P ##
#P # @brief Finds absolute upper directory path for pattern  
#P #
#P # Finds absolute upper directory path where the provided
#P # pattern is the prefix of remaining superior directory
#P # pathname.
#P #
#P # @param a $1:= start=. 
#P # @param b $2:= top='tests' 
#P # @param c $3:= \#swap-occurences-from-bottom 
#P #
#P # @return with resulting top
#P # @ingroup utalm_bash
#P def getUpperTreePathMatch(a,b,c):
#P 	pass
## \cond
function getUpperTreePathMatch () {
	local PATHx=${1:-$PWD}
	local MATCH=${2:-tests}
	local inpos=${3:-0}
	PATHx=$(bootstrapGetRealPathname $PATHx)
	local A=;
	local M=;
	set -a A
	local A=(${PATHx//\// })
	local max=${#A[@]}
	local i=$max
	set -a M
	local M=(${MATCH//\// })
	until((i<0))
	do
		if [ "${A[$i]}" == ${MATCH[0]} ];then
			if((inpos>0));then
				let inpos--;
			else
				N=""
				for j in ${MATCH[@]};do
					[[ "${A[$i]}" == $j ]]&&continue;
					N=$N/$j
				done
			fi
		fi
		N=/${A[$i]}$N
		let i--;
	done 
	echo -n $N
	return
}



## \endcond
#P ##
#P # @brief Creates a directory branch from current subtree  
#P #
#P # Duplicates subbranch of curtop in newtop.
#P #
#P # @param a $1:= curtop='tests' 
#P # @param b $2:= newtop=/tmp
#P #
#P # @ingroup utalm_bash
#P def mirrorBranchNode(a,b):
#P 	pass
## \cond
function mirrorBranchNode () {
	local curtop=${1:-$PWD}
	local newtop=${2:-/tmp}

	if [ "$PWD" != "$curtop" ];then
		curtop=${PWD#$curtop}
	fi
	mkdir -p ${newtop}/${curtop}
	return
}

## \endcond
#P ##
#P # @brief Evaluates the subbranch for PWD  
#P #
#P # @param a $1:= curtop
#P # @param b $1:= curpos
#P #
#P # @ingroup utalm_bash
#P def getSubBranch(a,b):
#P 	pass
## \cond
function getSubBranch () {
	local curtop=${1:-$PWD}
	local curpos=${2:-$PWD}
	if [ "$curpos" != "$curtop" ];then
		local x=${curpos#$curtop}
		echo -n ${x#/}
		return
	fi
	echo -n ${curtop}
	return
}

fi #*** prevent multiple inclusion
## \endcond #KEEP# PERSISTENT
