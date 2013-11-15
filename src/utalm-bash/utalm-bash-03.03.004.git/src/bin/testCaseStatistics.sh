#!/bin/bash
## \cond
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-make
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
##
## \endcond
##
## @file
## @brief Calculates statistics for test cases in a container - directory tree 
##
## Scans subtrees for existing test cases, and calculates
## statistics of contained test cases and inherent library 
## calls for Unit tests. 
##
## The following conventions apply:
##
## * Test Case:
##	CASE[0-9][0-9][0-9][0-9]*/CallCase.sh
##
## * Test Group of Cases:
##	<group-name>/CASE[0-9][0-9][0-9][0-9]*/CallCase.sh
##
## The unit tests of SUnit rely on the following calls:
##   * assertWithExit
##   * assertRefDataWithExit
##   * gotoHell
##   * countErrors
##
## Applied by the command line utilities:
##   * countErrors.sh / libutalm.sh->countErrors
##
## Test framework:
##   * CallCase.sh
##   * Makefile-nodewalk.mk
##   * Makefile-test.mk
##
## This tool counts the static calls contained in each CallCase.sh
## within a directory tree. Where the following is displayed:
##
##   * sum of files
##   * sum of assertWithExit 
##   * sum of assertRefDataWithExit 
##
##
##	CALL: ${0##*/} [OPTIONS] [<directory-pathlist>]
##	
##	OPTIONS:
##	
##		FORMAT:
##			--display 
##				console display
##			--raw 
##				raw display
##			--csr
##				character seperated display uses for now fixed FS=';'
##			
##		SCAN:
##			--deep
##				Scans the whole subtrees and calculates statistics for each.
##			--sumtotal | --sum | subsums
##				Scans the whole subtrees and calculates cumulation.	
##			--sumgroups | --groups | --subsums
##				Scans the whole subtrees and calculates cumulation for group of cases.	
##			
##		MISCELLANEOUS:
##			--help|-h
##			
##
## @ingroup libutalm_make
## \cond
##
#
#Execution anchor
MYCALLPATHNAME=$0
MYCALLARGS=$*
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
#. $(getPathToLib.sh libutalmfileobjects.sh)
#. $(getPathToLib.sh libutalmrefpersistency.sh)
#
###
#

_CONTAINERS=""

function _getNameDirs () {
	local start=${*:-.}
	local i=""
	local x=""
	for i in $(find $start -name CallCase.sh);do
		x=${i%CallCase.sh}
		x=${x%/CASE[0-9][0-9]*/}
		x=${x%/CASE[0-9][0-9]*/}
		result="$result $x"
		echo "$x"
	done|sort -u
	return
}


function _subSum () {
	local oid="";
	[[ "$1" == "OID" ]]&&{ oid=$1; shift; }
	local _name=$*
	local _calls=0
	local _gotoHell=0
	local _assert=0
	local _assertData=0
	local _assertRef=0
	local fx=""
	local _a0=""
	local _a1=""
	local _a2=""
	
	for fx in $(find $_name -name CallCase.sh);do
		_a0=$(egrep '(gotoHell[ \t])' $fx |wc -l)
		_a1=$(egrep '(assert[ \t])' $fx |wc -l)
		_a2=$(egrep '(assertRefDataWithExit)' $fx |wc -l)
		_a3=$(egrep '(assertWithExit)' $fx |wc -l)
		#
		let _calls+=1;
		let _gotoHell+=$_a0;
		let _assert+=$_a1;
		let _assertData+=$_a2;
		let _assertRef+=$_a3;
	done
	local _n=$_name
	[[ -n "$oid" ]]&&{ 
		_n=${_name//.\//}
		_n=${_n//\//.}
	}
	printf "%s;%d;%d;%d;%d;%d\n" $_n $_calls $_gotoHell $_assert $_assertData $_assertRef
	return
}


function displayRecord () {
	local _name=$1;shift
	_n=${_name//.\//}
	_n=${_n//\//.}
				
	local _calls=$1;shift
	local _gotoHell=$1;shift
	local _assert=$1;shift
	local _assertData=$1;shift
	local _assertRef=$1;shift

	echo "#"
	echo "###"
	echo "#"
	printf "Test Group                                   : %s\n" $_n
	printf "Test Cases                                   : %5d\n" $_calls
	echo
	printf " -> Bypassed exits 'gotoHell' calls          : %5d\n" $_gotoHell
	printf " -> Simple 'assert' calls                    : %5d\n" $_assert
	printf " -> Validate dynamic and static runtime data : %5d\n" $_assertData
	printf " -> Validate reference data                  : %5d\n" $_assertRef
	printf "                                             --------\n"
	echo
	printf "Test group contains                     (+=) :%6d\n" $((_assert+_assertData+_assertRef))
	printf "Correct test calls                      (+=) :%6d\n" $((_assertData+_assertRef))
	echo
}

function _displaySimpleSums () {
	local _calls=$(find . -name CallCase.sh |wc -l)
	local _gotoHell=$(find . -name CallCase.sh -exec egrep '(gotoHell)' {} \; |wc -l)
	local _assert=$(find . -name CallCase.sh -exec egrep '(assert[ \t])' {} \; |wc -l)
	local _assertData=$(find . -name CallCase.sh -exec egrep '(assertRefDataWithExit)' {} \; |wc -l)
	local _assertRef=$(find . -name CallCase.sh -exec egrep '(assertWithExit)' {} \; |wc -l)
	echo
	echo "*"
	echo "************************"
	echo "* Test case statistics *"
	echo "************************"
	echo "*"
	echo
	printf "Test Set                                     : %s\n" ${PWD##*/}
	echo
	printf "Test Cases                                   : %5d\n" $_calls
	echo
	printf " -> Bypassed 'gotoHell' calls                : %5d\n" $_gotoHell
	printf " -> Simple 'assert' calls                    : %5d\n" $_assert
	printf " -> Validate dynamic and static runtime data : %5d\n" $_assertData
	printf "    calls: assertWithExit\n"
	printf " -> Validate persistent reference data       : %5d\n" $_assertRef
	printf "    calls: assertReadDataWithExit\n"
	printf "                                             --------\n"
	echo
	printf "Overall total checks                    (+=) :%6d\n" $((_gotoHell+_assert+_assertData+_assertRef))
	echo
	printf "Correct test calls                      (+=) :%6d\n" $((_assertData+_assertRef))
	echo
}


function _getContainers () {
	case $_WALKTHROUGH in
		DEEP)
			if [ -z "$_CONTAINERS" ];then
				_CONTAINERS=$(_getNameDirs)
			else
				_CONTAINERS=$(_getNameDirs $_CONTAINERS)
			fi	
			;;
		SUMTOTAL|TOTAL|SUM)
			if [ -z "$_CONTAINERS" ];then
				_CONTAINERS=${PWD##*/}
			else
				_CONTAINERS=$(_getNameDirs $_CONTAINERS)
			fi	
			;;
		SUMGROUPS|GROUPS)
			if [ -z "$_CONTAINERS" ];then
				#_CONTAINERS=$(_getNameDirs .)
				_list=$(ls -ld $PWD/*|awk '{print $NF;}')
				_CONTAINERS=""
				for _cx in $_list;do
					if [ ! -d "$_cx" ];then
						continue
					fi
					_cxx=${_cx#$PWD/}
					_cxx=${_cxx%/*}
					_CONTAINERS="${_CONTAINERS} $_cxx"
				done
			else
				_CONTAINERS=$(_getNameDirs $_CONTAINERS)
			fi	
			;;
	esac
}

function _walkThrough () {
	local rec=""
	_getContainers
	case $_DATA in
		DISPLAY)
			for nd in $_CONTAINERS;do
				rec=$(_subSum $nd)
				displayRecord ${rec//;/ }
			done
			;; 
		RAW)
			printf "name;calls;gotoHell;assert;assertWithRef;assertDataWithRef\n"
			for nd in $_CONTAINERS;do
				_subSum $nd
			done
			;; 
		CSR)
			printf "name;calls;gotoHell;assert;assertWithRef;assertDataWithRef\n"
			for nd in $_CONTAINERS;do
				_subSum OID $nd
			done
			;; 
	esac
	
	return
}

function _printHelp () {
	cat <<EOF
CALL: ${0##*/} [OPTIONS] [<directory-pathlist>]

DESCRIPTION:
	Scans subtrees for existing test cases, and calculates
	statistics of contained test cases and inherent library 
	calls for Unit tests. 
	
    Definitions:
    
	    - Test Case:
	    	CASE[0-9][0-9][0-9][0-9]*/CallCase.sh

	    - Test Group of Cases:
	    	<group-name>/CASE[0-9][0-9][0-9][0-9]*/CallCase.sh

	For additional information refer to online help
	
	 "utalmhelp.sh  utalm-bash-tests"
	 "utalmhelp.sh  utalm-bash-tests/files"
		

OPTIONS:

	FORMAT:
	--display 
		console display
	--raw 
		raw display
	--csr
	character seperated display uses for now fixed FS=';'
	
	SCAN:
	--deep
		Scans the whole subtrees and calculates statistics for each.
	--sumtotal | --sum | subsums
		Scans the whole subtrees and calculates cumulation.	
	--sumgroups | --groups | --subsums
		Scans the whole subtrees and calculates cumulation for group of cases.	
	
	MISCELLANEOUS:
	--help|-h
		
EOF
}


#
###
#
_DATA="RAW"
_WALKTHROUGH="SUMTOTAL"
for ca in $MYCALLARGS;do
	_ca=$(echo $ca|tr '[a-z]' '[A-Z]')
	
	case $_ca in
		--DISPLAY)_DATA=DISPLAY;; 
		--RAW)_DATA=RAW;; 
		--CSR)_DATA=CSR;;
		
		--DEEP)_WALKTHROUGH="DEEP";; 
		--SUMTOTAL|--SUM|--TOTAL)_WALKTHROUGH="SUMTOTAL";; 
		--SUMGROUPS|--GROUPS|--SUBSUMS)_WALKTHROUGH="SUMGROUPS";;
		
		--HELP|-H)_printHelp;exit 0;;
 
		*)
			#TODO: make it stronger
			if [[ "${_ca//./}" != "$_ca" && "${_ca//\//}" == "$_ca" ]];then
				_CONTAINERS="$_CONTAINERS ${ca//./\/}"
				shift
				continue
			fi
			if [[ "${_ca//./}" == "$_ca" && "${_ca//\//}" != "$_ca" ]];then
				_CONTAINERS="$_CONTAINERS $ca"
				shift
				continue
			fi
			if [[ "${_ca//./}" == "$_ca" && "${_ca//\//}" == "$_ca" ]];then
				_CONTAINERS="$_CONTAINERS $ca"
				shift
				continue
			fi
			echo "ERROR:Unknown arg:$_ca"
			exit 1
			;; 
	esac
	shift
done



#
###
#
case $_WALKTHROUGH in
	DEEP)
		_walkThrough
		;; 
	SUMTOTAL)
		_displaySimpleSums
		;; 
	SUMGROUPS)
		_walkThrough
		;; 
esac



exit 0	

#_displaySimpleSums
#_getNameDirs

## \endcond

