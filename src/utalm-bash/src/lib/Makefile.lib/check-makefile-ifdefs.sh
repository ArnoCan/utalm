#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-python
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
##
## @package libutalm_bash_devel
## @author Arno-Can Uestuensoez
## @date 2013.10.10
## @version 03_02_001
## @file
## @brief Helper Utility for check of if-endif-pairs in Makefile-trees
##
## Helper-Utility to check the resulting ifdef-endif-levels of "Makefile"s.
## As a real-dev-hacker-tool, it's a Spartanian, contolled by following
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

/ifeq|ifneq|ifdef|ifndef/{
   tabs+=1;
   if(tabs>=sl){
      if(c==0){
         printf("%04d %"4*tabs"s %-6s - %d - %s\n",NR,">","ifeq",tabs,FILENAME);
      }else{
         printf("%04d %"4*tabs"s %-6s - %d - %s - %s\n",NR,">","ifeq",tabs,FILENAME,$0);
      }
   }
}

/endif/{
   if(tabs>=sl){
      if(c==0){
         printf("%04d %"4*tabs"s %-6s - %d - %s\n",NR,"<","endif",tabs,FILENAME);
      }else{
         printf("%04d %"4*tabs"s %-6s - %d - %s - %s\n",NR,"<","endif",tabs,FILENAME,$0);
      }
   }
   tabs-=1;
   if(tabs<0){
   	  errors+=1;
      print "***************************************************";
      print "**";
      print "**";
      print "ERROR:ifdef-endif-mismatch("NR"):"FILENAME;
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
      print "ERROR:ifdef-endif-mismatch("NR") - MISSING: \"endif\" :"FILENAME;
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
	for i in $(find ${STARTNODE} -type f -name 'Makefile*');do
		scantarget $i
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
