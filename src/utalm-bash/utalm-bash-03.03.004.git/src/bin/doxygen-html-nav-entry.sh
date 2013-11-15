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
#$Header$
#
##
## \endcond
## @ingroup utalm_bash
## @file
## @brief Adds and removes component entry into/from navtree.
##
## Relies on teh version with navtree.js and the variable NAVTREE. 
##
## \cond
##
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
STARTLEVEL=${STARTLEVEL:-1}
CONTENT=${CONTENT:-0}
#FILEONLY=${FILEONLY}
STARTNODE=${STARTNODE:-.}
DISPERRSUM=${DISPERRSUM:-0}


function displayNAVTREE () {
	local nt=$1
	cat $nt |sed -n '/var *NAVTREE *=/,/^];$/p'
}


function insertEntryToNAVTREE () {
	local key=$1;shift
	local nt=$1;shift
	local en=$1
		
	local nt_bak=$nt-${_STARTDATE}-${_STARTTIME}
	mv  $nt $nt_bak
	cat $nt_bak |sed -n '/var *NAVTREE *=/,/^];$/p' |awk -v n="$_new" '
	/\[ *"awk"/{
		print;
		print "/*ADDED-NEXT:python*/";
		print n;
		next;
	}
	{print;}
	'>$nt
	cat $nt_bak |sed -n '/var *NAVTREE *=/,/^];$/!p'>>$nt
	return
}




_new='[ "Python", "../utalm-python-API/index.html", null ],'
MYNAVTREEJS=/tmp/bld/utalm-bash-03.03.004/doc-tmp/BETA/doc/en/html/man3/utalm-API/navtree.js

insertEntryToNAVTREE awk $MYNAVTREEJS $_new



## \endcond
