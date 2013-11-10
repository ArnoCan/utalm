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
## @file
## @brief print help
##
## The following examples demonstrate the call interface.
##
## - Syntax
##
##	utalmhelp.sh [<component>] [<format>]
##	  <component> := (bash|make|awk)
##	  <format> := (html|pdf|make)
##
## - Online help examples by usability wrapper shortcuts.
##
##	- utalmhelp.sh
##	- utalmhelp.sh bash 
##	- utalmhelp.sh make
##	- utalmhelp.sh awk
##	- utalmhelp.sh html
##	- utalmhelp.sh pdf
##	- utalmhelp.sh man
##	- utalmhelp.sh bash html
##	- utalmhelp.sh make html
##	- utalmhelp.sh awk html
## 
##
## - Online help examples by CLI option.
##
##	- utalmhelp.sh -d help
##	- utalmhelp.sh -d help:html
##	- utalmhelp.sh -d help:pdf
##	- utalmhelp.sh -d help:man
##
## @ingroup utalm_bash
## \cond
##
#
shopt -s nullglob
#
#Execution anchor
MYCALLPATHNAME=$0
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
printINFO 2 $LINENO $BASH_SOURCE 0 "UTALM-Help"
function localHelp () {
if [ -z "$*" ];then
echo
echo "HELP-SYNTAX : ${0##*/} [help | intro | <component> [<format>]] | [-d <utalm-suboptions>]"
echo "                <component> := (utalm|api|bash|make|awk)"
echo "                <format> := (html|pdf|make)"
echo "                <intro> := Introduction, table of contained components"
echo
echo "CALL FIRST  : '${0##*/} help' or '${0##*/} api'"
echo
exit 0
fi
}
localHelp $*

#if [ "${*//-d/}" == "${*}" -a "${*//--debug/}" == "${*}"  ];then
#	printHelp $*
#fi

_isfile=0
if [ -e "${_c}" ];then
	_isfile=1
	_file=${_c}
	case ${_file##*.} in
	html)h=HTML;;
	pdf)h=PDF;;
	esac	
	shift
fi
if [ -e "${_c}.html" ];then
	_isfile=1
	_file=${_c}.html
	case ${_file##*.} in
	html)h=HTML;;
	pdf)h=PDF;;
	esac
	shift
fi
if [ -e "${_c}/index.html" ];then
	_isfile=1
	_file=${_c}index.html
	case ${_file##*.} in
	html)h=HTML;;
	pdf)h=PDF;;
	esac
	shift
fi

_c=`echo ${1}|tr '[:upper:]' '[:lower:]'`;
case $_c in
	intro|help|make|awk|bash|bash-api|awk|awk-api|make|make-api|api|utalm)
		shift
		h=`echo ${1}|tr '[:lower:]' '[:upper:]'`;
		;;	
esac
h=${h:-HTML}
case $_c in
	help)printHelp ;;
	intro)printHelp utalm-API/usergroup0 ${h};;
	utalm|api)printHelp utalm-API/index ${h};;
	awk|awk-api)printHelp utalm-awk-API/index ${h};;
	bash|bash-api)printHelp utalm-bash-API/index ${h};;
	make|make-api)printHelp utalm-make-API/index ${h};;
    -d*)printHelp ${_c:-utalm-bash-API/index} ${h};;
    *)
    if((_isfile));then
    	printHelp $_file  ${h}
	else
		printHelp $_c ${h}
    	localHelp
    fi
    ;;
esac
exit 0
## \endcond
