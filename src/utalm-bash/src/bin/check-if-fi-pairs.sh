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
## @brief Helper utility for check of if-fi in script files
##
##	STARTLEVEL=${STARTLEVEL:-1}
##	  -> STARTLEVEL=1-99999
##	CONTENT=${CONTENT:-0}
##	FILEONLY=${FILEONLY}
##	STARTNODE=${STARTNODE:-.}
##	DISPERRSUM=${DISPERRSUM:-0}
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


function scantarget () {
local fname=$1
awk -v sl="${STARTLEVEL}" -v c="${CONTENT}" -v e="${DISPERRSUM}" '
BEGIN{
   tabs=0;
   lastfile="";
   errors=0;
}
FILENAME==lastfile{lineno+=1;
   #print "A "FILENAME" - "lastfile
}

FILENAME!=lastfile{
   lastfile=FILENAME;
}

/[\\@]cond/{
   tabs+=1;
   if(tabs>=sl){
      if(c==0){
         printf("%04d %"4*tabs"s %-6s - %d - %s\n",NR,">","[ \t;]if[ \t(]",tabs,FILENAME);
      }else{
         printf("%04d %"4*tabs"s %-6s - %d - %s - %s\n",NR,">","[ \t;]if[ \t(]",tabs,FILENAME,$0);
      }
   }
}

/[\\@]endcond/{
   if(tabs>=sl){
      if(c==0){
         printf("%04d %"4*tabs"s %-6s - %d - %s\n",NR,"<","[ \t;]fi[ \t;]",tabs,FILENAME);
      }else{
         printf("%04d %"4*tabs"s %-6s - %d - %s - %s\n",NR,"<","[ \t;]fi[ \t;]",tabs,FILENAME,$0);
      }
   }
   tabs-=1;
   if(tabs<0){
   	  errors+=1;
      print "***************************************************";
      print "**";
      print "**";
      print "ERROR:if-fi-mismatch("NR"):"FILENAME;
      print "**";
      print "**";
      print "***************************************************";
   }
}
END{ 
   if(tabs>0){
   	  errors+=1;
      print "***************************************************";
      print "**";
      print "**";
      print "ERROR:if-fi-mismatch("NR") - MISSING: \"fi\" :"FILENAME;
      print "**";
      print "**";
      print "***************************************************";
   }
   if(e!=0){
	   print "**************";
	   print "Errors:"errors"  "FILENAME
	   print "**************";
	}
} 
' $fname
}

if [ -n "${FILEONLY}" ];then
	scantarget ${FILEONLY}
else
	_baseabs=$PWD
	{
		_curbase=;
		for _curbase in ${_baseabs};do
	    	find ${_curbase} -type f -name '*' \
			-exec awk -F'=' -v matchMin=4 \
			-f ${MYCALLPATH}/doxygenfilter.awk {} \; \
			#			-print 2>/dev/null
			ret=$?;
			if [  $ret -ne 0  ];then
		    	echo "SCAN-DOXYGEN-FILES:Partial access error/check permissions:$MYUID@$MYHOST with \"find ${_curbase} ...(ret=$ret)\"">&2
			fi
		done
    }|\
    while read X;do
        f=${X%%:*};
        l=${X%:*};l=${l#*:};
        s=${X##*:};
    	printDBG $S_UTALM ${D_DATA} $LINENO $BASH_SOURCE "$FUNCNAME:MATCH=${X}"
		scantarget $f
	done
fi

echo ""
echo "For Info use:"
echo ""
echo "-> CONTENT=1"
echo "-> STARTLEVEL=#level with level={1...}"
echo "-> FILEONLY=<filename>"
echo "-> STARTNODE=<dirname>"
echo "-> DISPERRSUM=1"
echo ""
echo ""
echo "-> CONTENT=${CONTENT}"
echo "-> STARTLEVEL=${STARTLEVEL}"
echo "-> FILEONLY=${FILEONLY}"
echo "-> STARTNODE=${STARTNODE}"
echo "-> DISPERRSUM=${DISPERRSUM}"

## \endcond
