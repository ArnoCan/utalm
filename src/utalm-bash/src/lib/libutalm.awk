## <!--#***HEADSTART***-->
##  \cond
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
## @ingroup libutalm_awk
## @file
## @brief 'awk' support module for utalm-bash component
## 
## The following call parameters are expected as input variables.
## 
## 	awk \
## 		-v DBG="#debug-level" \
## 		[-v MTYPE="#match-type"] \
## 		[-v SUB="#subsystem"] \
## 		[-v INFO=#info-level] \
## 		[-v WNG=#warning-level] \
## 		[-v PF=#print-final-call-level]...
## 
## The awk component supports a subset of parameters of the UTALM standard. This is because
## awk scrpts are commonly used as small embedded sub-scripting for shell scripts, thus most 
## of the advanced trace and log features is in 99% of applications simply not required.
## 
##  * Source and documentation: @ref libutalm.awk
##  * Stripped runtime version: @ref libutalm-min.awk
## 
## For detailed information on <b>libutalm.awk</b> refer to:
## <ul>
##   <li> 
##     <b><a href="../../man3/utalm-awk.html">utalm-awk(3)</a></b>
##   </li> 
##   <li> 
##     <b><a href="../../man3/utalm-bash-API/index.html">utalm-bash-API(3)</a></b>
##   </li> 
## </ul>
## 
## 
##
## refer to source-package for unstripped sources
##
## \cond #KEEP# PERSISTENT
## <!--#***HEADEND***-->


## \endcond
#P ##
#P # Gets PID, requires GNUawk.
#P #
#P # @ingroup libutalm_awk
#P def getPID():
#P     pass
## \cond
function getPID(){
	return PROCINFO["pid"];
}


## \endcond
#P ##
#P # Gets hostname.
#P # 
#P # @ingroup libutalm_awk
#P def getHostname():
#P     pass
## \cond
function getHostname(){
	call="uname -n";
	call|getline res;
	return res;
}

	

## \endcond
#P ##
#P #
#P # Gets call name.
#P # 
#P # @ingroup libutalm_awk
#P def getCallName():
#P     pass
## \cond
function getCallName(){
	call="echo $*";
	call|getline res;
	res=ENVIRON["MYCALLNAME"]
	return res;
}



## \endcond
#P ##
#P #
#P # Gets UID.
#P # 
#P # @ingroup libutalm_awk
#P def getUID():
#P     pass
## \cond
function getUID(){
	getuidcall|getline res;
	return res;
	#return PROCINFO["uid"];
}



## \endcond
#P ##
#P # Gets GID.
#P # 
#P # @ingroup libutalm_awk
#P def getGID():
#P     pass
## \cond
function getGID(){
	getgidcall|getline res;
	return res;
	#return PROCINFO["gid"];
}



## \endcond
#P ##
#P # Internal trace/log-string function
#P # 
#P # @param le caller level
#P # @param li caller line number
#P # @param li caller file name
#P # @param c caller code
#P # 
#P # @ingroup libutalm_awk
#P #
#P def prepHead():
#P     pass
#P # \cond
function prepHead(le,li,f,c){
	a=f;
	gsub("[^/]*/[^/]*$","",a);
	gsub(a,"",f);
	if(RNUM==1){
		return cname":"uid"@"hname":"pid":"f":"li":"le":"c":"NR;
	}else{
		return cname":"uid"@"hname":"pid":"f":"li":"le":"c;
	}
}


## \endcond
#P ##
#P #
#P # Internal trace/log-string function
#P # 
#P # @param m message to be displayed
#P # 
#P # @ingroup libutalm_awk
#P #
#P def printOUT():
#P     pass
## \cond
function printOUT(m){
	print m | "cat 1>&2"
}


## \endcond
#P ##
#P #
#P # Fetch argv
#P # 
#P # Is implicitly called, fetches suboptions for '-d ...' 
#P # For valid options refer to <a href="../../man3/utalm-bash.html" target="_blank">utalm-bash(3)</a> 
#P # 
#P # The following call parameters are expected as input variables.
#P # 
#P # 	... awk -v DBG="#debug-level" [-v INFO=#info-level] [-v WNG=#warning-level] [-v PF=#print-final-call-level]...
#P # 
#P # <ul>
#P #  <li><b>DBG</b><br />
#P #  The current level of DEBUG.
#P #  </li>
#P #  <li><b>I</b><br />
#P #  The current level of INFO.
#P #  </li>
#P #  <li><b>W</b><br />
#P #  The current level of WARNING.
#P #  </li>
#P #  <li><b>P</b><br />
#P #  The current level of printFINALCALL.
#P #  </li>
#P # </ul>
#P # 
#P # 
#P # @ingroup libutalm_awk
#P #
#P def fetchDBGArgs():
#P     pass
## \cond
function fetchDBGArgs(){
	pid=getPID();
	uid=getUID();
	gid=getGID();
	hname=getHostname();
	cname=getCallName();
	
	if(MTYPE=="")MTYPE=ENVIRON["MTYPE"];
	if(SUB=="")SUB=ENVIRON["SUB"];
	if(DBG=="")DBG=ENVIRON["DBG"];
	if(WNG=="")WNG=ENVIRON["WNG"];
	if(INF=="")INF=ENVIRON["INF"];
	if(PF=="")PF=ENVIRON["PF"];
	if(RNUM=="")RNUM=ENVIRON["RNUM"];

	if(MTYPE=="")MTYPE=4;
	if(SUB=="")SUB=0xffffffff;
	if(DBG=="")DBG=0;
	if(WNG=="")WNG=1;
	if(INF=="")INF=1;
	if(PF=="")PF=0;
	if(RNUM=="")RNUM=0;
	if(MYTPE=="MIN")MTYPE=4;
	if(MYTPE=="MAX")MTYPE=2;
	if(MYTPE=="PATTERN")MTYPE=1;
	if(MYTPE=="P")MTYPE=1;
	
}



## \endcond
#P ##
#P #
#P # Check debug state
#P # 
#P # Returns whether debug level matches. If some specific 
#P # actions to be done. E.g. evaluating time-intensive
#P # debug actions for tests.
#P # 
#P # 	doDebug <subsys> <dbg-level> <line> <file> 
#P # 
#P # 
#P # Logs only when called with more than one option and matches current log-set.
#P # Therefore the provided parameters are evaluated by comparison with
#P # match criteria as follows:
#P # 
#P #        |Order |Criteria             |Terminates|
#P #        |------|---------------------|----------|
#P #        |1     |subsys               |No        | 
#P #        |2     |level                |No        |
#P # 
#P # 
#P # @param subsys subsystem
#P # @param level debug level
#P # @param line caller line number
#P # @param filename
#P # 
#P # @ingroup libutalm_awk
#P #
#P def doDebug():
#P     pass
#P # \cond
function doDebug(s,le,li,f){
	if(MTYPE&&4){
		#smaller
		if(s&&SUB>0){
			return(le<DBG);
		}
	}else{
		if(MTYPE&&2){
			#greater
			return(le>=DBG);
		}else{
			if(MTYPE&&1){
				#bits
				return(le&&DBG);
			}
		}
	}
}


## \endcond
#P ##
#P #
#P # Print trace/log-string
#P # 
#P # Prints a trace/log-string when matches defined number.
#P # 
#P # @param s subsystem
#P # @param le debug level
#P # @param li caller line number
#P # @param f caller filename
#P # @param msg message to be displayed
#P # 
#P # @ingroup libutalm_awk
#P #
#P def printDBG():
#P     pass
#P # \cond
function printDBG(s,le,li,f,msg){
	if(doDebug(s,le,li,f)){
		h=prepHead(le,li,f,0);
		printOUT(h":DEBUG:"msg);
	}
}


## \endcond
#P ##
#P #
#P # Print trace/log-string for errors
#P # 
#P # The output format is:
#P # 
#P # 	<MYCALLNAME>:<MYUID>@<MYHOST>:<pid>:<filename>:#linenumber:INFO:<code>:<message>
#P # 
#P # @param e caller error number
#P # @param li caller line number
#P # @param f filename of caller
#P # @param c caller code
#P # @param msg message to be displayed
#P # 
#P # @ingroup libutalm_awk
#P #
#P def printERR():
#P     pass
## \cond
function printERR(e,li,f,c,msg){
	h=prepHead(0,li,f,c);
	printOUT(h":ERR:"e":"msg);
}


## \endcond
#P ##
#P #
#P # Print trace/log-string for warnings
#P # 
#P # Prints a trace/log-string when matches current level.
#P # The output format is:
#P # 
#P # 	<MYCALLNAME>:<MYUID>@<MYHOST>:<pid>:<filename>:#linenumber:INFO:<code>:<message>
#P # 
#P # Implementation priority: PERFORMANCE
#P # 
#P # @param w warning-level
#P # @param li caller line number
#P # @param f filename of caller
#P # @param c code
#P # @param msg message to be displayed
#P # 
#P # @ingroup libutalm_awk
#P #
#P def printWNG():
#P     pass
## \cond
function printWNG(w,li,c,f,msg){
	if(w<WNG){
		h=prepHead(w,li,f,c);
		printOUT(h":WNG:"msg);
	}
}


## \endcond
#P ##
#P #
#P # Print trace/log-string for info
#P # 
#P # Prints a trace/log-string when matches current level.
#P # The output format is:
#P # 
#P # 	<MYCALLNAME>:<MYUID>@<MYHOST>:<pid>:<filename>:#linenumber:INFO:<code>:<message>
#P # 
#P # Implementation priority: PERFORMANCE
#P # 
#P # @param i info-level
#P # @param li caller line number
#P # @param f filename of caller
#P # @param c caller code
#P # @param msg message to be displayed
#P # 
#P # @ingroup libutalm_awk
#P #
#P def printINFO():
#P     pass
#P # \cond
function printINFO(i,li,c,f,msg){
	if(i<INF){
		h=prepHead(i,li,f,c);
		printOUT(h":INFO:"msg);
	}
}


## \endcond
#P ##
#P #
#P # Prints final call strings
#P # 
#P # Prints a trace/log-string of a string prepared to be executed when called with more
#P # than one option and matches current level.
#P # 
#P # 	printFINALCALL <level> <line> <fname> <title> <exec-or-call-string>
#P # 
#P # Implementation priority: PERFORMANCE
#P # 
#P # @param le debug level
#P # @param li caller line number
#P # @param f filename
#P # @param t title
#P # @param x exec-or-call-string
#P # 
#P # @ingroup libutalm_awk
#P #
#P def printFINALCALL():
#P     pass
#P # \cond
function printFINALCALL(le,li,f,t,x){
	if(le<=PF){
		h=prepHead(le,li,f,0);
		printOUT(h":PF:"t":\n("x")");
	}
}


## \endcond
#P ##
#P #
#P # Prints final call strings
#P # 
#P # Prints a trace/log-string of a string prepared to be executed when called with more
#P # than one option and matches current level.
#P # 
#P # 	callErrOutWrapper <line> <fname> <exec-or-call-string>
#P # 
#P # Implementation priority: PERFORMANCE
#P # 
#P # @param li caller line number
#P # @param x exec-or-call-string The call to be wrapped
#P # 
#P # @ingroup libutalm_awk
#P #
#P def callErrOutWrapper():
#P     pass
#P # \cond
function callErrOutWrapper(li, x){
	if(le<=DBG){print "UTALM("thisAWKFile"):"FILENAME":"msg>"/dev/stderr"}
}



## \endcond
#P ##
#P #
#P # Exits with stardard string output
#P #  
#P # Exits with "grep" string for unit evaluation.
#P # 	"utalm_exit:#value"
#P # 
#P # Examples:
#P # 	"utalm_exit:0"
#P # 	"utalm_exit:2"
#P # 
#P # The name gotoHell is honouring my very first colleagues -
#P # actually skilled - not wanna-be-super-gurus.
#P # 
#P # @param l caller line number
#P # @param f caller file
#P # @param e exit value
#P # 
#P # @exit with given code
#P # @ingroup libutalm_awk
#P #
#P def gotoHell():
#P     pass
#P # \cond
function gotoHell(l,f,e){
	printINFO(0,l,e,f,"Requested exit:"e)
	printOUT("utalm_exit:"e)
	exit(e);
}

BEGIN{
	pid=0;
	uid=0;
	gid=0;
	hname="";

	getgidcall=ENVIRON["GETGIDCALL"]
	if(getgidcall~/^$/){
		getgidcall="id -n -g";
	}
	getuidcall=ENVIRON["GETUIDCALL"]
	if(getuidcall~/^$/){
		getuidcall="id -n -u";
	}
				
	fetchDBGArgs();
}

#P # \endcond #KEEP# PERSISTENT
