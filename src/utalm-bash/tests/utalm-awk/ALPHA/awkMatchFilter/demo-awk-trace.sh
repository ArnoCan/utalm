## \cond
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-make
#LICENSE:      Apache-2.0 + CCL-BY-SA-3.0
#VERSION:      03_03_001
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
#***MODUL_DOXYGEN_START***
## \endcond
## @file
## @brief Helper utility for check of cond-endcond-pairs in file trees
##
## Helper-Utility to check the resulting cond-endcond-levels of "doxygen".
## The additional benefit is demonstration of the application of a included 
## match filter with usage of the libutalm.awk module. 
## 
## For demonstartion call:
##
##	./demo-awk-trace.sh -d L:0,W:0,I:0
##	./demo-awk-trace.sh -d L:1,W:0,I:0
##	./demo-awk-trace.sh -d L:2,W:0,I:0
##	./demo-awk-trace.sh -d L:3,W:0,I:0
##	./demo-awk-trace.sh -d L:0,W:1,I:0
##	./demo-awk-trace.sh -d L:0,W:2,I:0
##	./demo-awk-trace.sh -d L:0,W:0,I:1
##	./demo-awk-trace.sh -d L:0,W:0,I:2
##
## Environment variables.
##
##	STARTLEVEL=${STARTLEVEL:-1}
##	  -> STARTLEVEL=1-99999
##	CONTENT=${CONTENT:-0}
##	FILEONLY=${FILEONLY}
##	STARTNODE=${STARTNODE:-.}
##	DISPERRSUM=${DISPERRSUM:-0}
##
## \cond
#***MODUL_DOXYGEN_END***

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


AWKPATH=${MYCALLPATH}:${LIBDIR}
export AWKPATH

. ${BOOTSTRAPLIB}/bootstrap-03_03_001.sh
. ${CORELIB}/libcore-03_01_009.sh
. ${LIBDIR}/libutalm.sh

STARTLEVEL=${STARTLEVEL:-1}
CONTENT=${CONTENT:-0}
#FILEONLY=${FILEONLY}
STARTNODE=${STARTNODE:-.}
DISPERRSUM=${DISPERRSUM:-0}

function scantarget () {
local fname=$1
awk -v sl="${STARTLEVEL}" -v c="${CONTENT}" -v e="${DISPERRSUM}" \
-v DBG=$DBG -v MTYPE=$MTYPE -v SUB=$SUB -v WNG=$WNG -v RNUM=1 '

#
# requires AWKPATH
@include "libutalm.awk"

BEGIN{
	tabs=0;
	lastfile="";
	errors=0;
	#	fetchDBGArgs();
}

FILENAME==lastfile{
	lineno+=1;
}

FILENAME!=lastfile{
   lastfile=FILENAME;
}

/[\\@]cond/{
   tabs+=1;
   if(tabs>=sl){
      if(c==0){
         printf("%04d %"4*tabs"s %-6s - %d - %s\n",NR,">","[\\]cond",tabs,FILENAME);
      }else{
         printf("%04d %"4*tabs"s %-6s - %d - %s - %s\n",NR,">","[\\]cond",tabs,FILENAME,$0);
      }
   }
}

/[\\@]endcond/{
   if(tabs>=sl){
      if(c==0){
         printf("%04d %"4*tabs"s %-6s - %d - %s\n",NR,"<","[\\]endcond",tabs,FILENAME);
      }else{
         printf("%04d %"4*tabs"s %-6s - %d - %s - %s\n",NR,"<","[\\]endcond",tabs,FILENAME,$0);
      }
   }
   tabs-=1;
   if(tabs<0){
   	  errors+=1;
      print "***************************************************";
      print "**";
      print "**";
      print "ERROR:cond-endcond-mismatch("NR"):"FILENAME;
      print "**";
      print "**";
      print "***************************************************";
   }
}
END{ 
	printDBG(1,0,"'$LINENO'","'$BASH_SOURCE'","MyMessage0");
	printDBG(1,1,"'$LINENO'","'$BASH_SOURCE'","MyMessage1");
	printDBG(1,2,"'$LINENO'","'$BASH_SOURCE'","MyMessage2");
	printDBG(1,3,"'$LINENO'","'$BASH_SOURCE'","MyMessage3");

	printINFO(0,"'$LINENO'",11,"'$BASH_SOURCE'","MyMessageInfo0");
	printINFO(1,"'$LINENO'",22,"'$BASH_SOURCE'","MyMessageInfo0");
	printINFO(2,"'$LINENO'",33,"'$BASH_SOURCE'","MyMessageInfo0");

	printWNG(0,"'$LINENO'",11,"'$BASH_SOURCE'","MyMessageWng0");
	printWNG(1,"'$LINENO'",22,"'$BASH_SOURCE'","MyMessageWng0");
	printWNG(2,"'$LINENO'",33,"'$BASH_SOURCE'","MyMessageWng0");
			
	printERR(333,"'$LINENO'",77,"'$BASH_SOURCE'","MyMessageErr0");
								
	
	if(tabs>0){
   		errors+=1;
    	print "***************************************************";
    	print "**";
    	print "**";
    	print "ERROR:con-endcond-mismatch("NR") - MISSING: \"endcond\" :"FILENAME;
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

printDBG D_ALL 0 $LINENO $BASH_SOURCE "MyMessage10"
printDBG D_ALL 1 $LINENO $BASH_SOURCE "MyMessage10"
printDBG D_ALL 2 $LINENO $BASH_SOURCE "MyMessage10"

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
