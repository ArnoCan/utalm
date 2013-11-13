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
## @ingroup libutalm_make
## @file
## @brief Library of utalm-make based regression tests
##
##  * Source and documentation: @ref libutalmrefpersistency.sh
##  * Stripped runtime version: @ref libutalmrefpersistency-min.sh
##
## For detailed information on <b>libutalmrefpersistency.sh</b> refer to:
## <ul>
##   <li> 
##     <b><a href="../../man7/utalm-bash-tests.html">utalm-bash-tests(7)</a></b>
##   </li> 
##   <li> 
##     <b><a href="../../man3/utalm-bash-API/index.html">utalm-bash-API(3)</a></b>
##   </li> 
## </ul>
##
##
## This library contains the main features for handliung of regression data.
##
## \cond #KEEP# PERSISTENT
## <!--#***HEADEND***-->
#
if [ -z "$MYCALLNAME" ];then
	MYCALLNAME=${0##*/}
	MYCALLNAME=${MYCALLNAME%.*}
fi
export MYCALLNAME

if [ -z "$__UTALMREFPERSISTOBJS__" ];then #*** prevent multiple inclusion
## \endcond
## __UTALMREFPERSISTOBJS__
# Set to "1" when sourced.
# Prevents multiple inclusion
__UTALMREFPERSISTOBJS__=1 #*** prevent multiple inclusion
## \cond

if [ ! -d "${TSTBASE}" ];then
	printERR $LINENO $BASH_SOURCE 0 "Missing test base:TSTBASE"
	gotoHell $LINENO $BASH_SOURCE $E_SYS
fi

if [ ! -d "${TSTREF}" ];then
	printERR $LINENO $BASH_SOURCE 0 "Missing test base:TSTREF"
	gotoHell $LINENO $BASH_SOURCE $E_SYS
fi

#if [ ! -d "${TSTCALLROOT}" ];then
	#printERR $LINENO $BASH_SOURCE 0 "Missing test base:TSTCALLROOT"
	#gotoHell $LINENO $BASH_SOURCE $E_SYS
#fi

#
#test mode constants
#
## @ingroup utalm_bash
T_OFF=0
## \cond
export T_OFF
## \endcond

#
## @ingroup utalm_bash
T_CREATEREF=1
## \cond
export T_CREATEREF
## \endcond

## @ingroup utalm_bash
T_COMPAREREF=2
## \cond
export T_COMPAREREF
## \endcond

## @ingroup utalm_bash
T_PRINTREF=4
## \cond
export T_PRINTREF
## \endcond

## @ingroup utalm_bash
T_PRINTVAL=8
## \cond
export T_PRINTVAL
## \endcond

## @ingroup utalm_bash
T_PRINTASSERT=16
## \cond
export T_PRINTASSERT
## \endcond

## @ingroup utalm_bash
T_FORCEOK=32
## \cond
export T_FORCEOK
## \endcond

## @ingroup utalm_bash
T_LISTREF=64
## \cond
export T_LISTREF
## \endcond

## \endcond
#P ## TESTMODE
#P # Mode of operations for regression and unit tests.
#P #
#P # Controls mode of operations for assertion operations
#P # of \ref libutalmrefpersistency.sh.
#P # Default = 2 = T_COMPARE
#P #
#P TESTMODE=2
## \cond
TESTMODE="${TESTMODE:-$T_COMPAREREF}"
export TESTMODE

## \endcond
#P ##
#P # Convert &lt;testmode_string&gt; to \#testmode value 
#P #
#P # @param a $1:=testmode-string
#P # @ingroup utalm_bash
#P def testmodeToNum(a):
#P 	pass
## \cond
function testmodeToNum () {
    local f=$(echo $1|tr '[a-z]' '[A-Z]');
    local F=;
    case ${f} in
        T_OFF|OFF)F=$T_OFF;;
        T_CREATEREF|CREATEREF|CREATE|CREA)F=$T_CREATEREF;;
        T_COMPAREREF|COMPAREREF|COMPARE|COMP)F=$T_COMPAREREF;;
        T_PRINTREF|PRINTREF|PREF)F=$T_PRINTREF;;
        T_PRINTVAL|PRINTVAL|PVAL)F=$T_PRINTVAL;;
        T_PRINTASSERT|PRINTASSERT|PASS)F=$T_PRINTASSERT;;
        T_FORCEOK|FORCEOK|FOK)F=$T_FORCEOK;;
        T_LISTREF|LISTREF|LIST)F=$T_LISTREF;;
		[0-9]*)F=$((F|f));;
        HELP|H)F="-1";testmodeList;;
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
#P # Convert \#testmode-value to &lt;testmode-string&gt; 
#P #
#P # @param a $1=testmode value
#P # @ingroup utalm_bash
#P def testmodeToStr(a):
#P 	pass
## \cond
function testmodeToStr () {
    local F=$(echo $1|tr '[a-z]' '[A-Z]');
    case ${F} in
        $T_OFF|T_OFF|OFF)F=T_OFF;;
        $T_CREATEREF|T_CREATEREF|CREATEREF|CREATE|CREA)F=T_CREATEREF;;
        $T_COMPAREREF|T_COMPAREREF|COMPAREREF|COMPARE|COMP)F=T_COMPAREREF;;
        $T_PRINTREF|T_PRINTREF|PRINTREF|PREF)F=T_PRINTREF;;
        $T_PRINTVAL|T_PRINTVAL|PRINTVAL|PVAL)F=T_PRINTVAL;;
        $T_PRINTASSERT|T_PRINTASSERT|PRINTASSERT|PASS)F=T_PRINTASSERT;;
        $T_FORCEOK|T_FORCEOK|FORCEOK|FOK)F=T_FORCEOK;;
        $T_LISTREF|T_LISTREF|LISTREF|LIST)F=T_LISTREF;;
        HELP|H)E=-1;exitList;;
    esac
    echo -n $F
    return 0
}



## \endcond
#P ##
#P # List known testmodes
#P #
#P # @ingroup utalm_bash
#P def testmodeList():
#P 	pass
## \cond
function testmodeList () {
    echo "Predefined testmode string constants:">>$LOG
    echo >>$LOG    
    printf "%-45s:%d\n" "T_OFF|OFF" $T_OFF>>$LOG;
    printf "%-45s:%d\n" "T_CREATEREF|CREATEREF|CREATEREF|CREATE|CREA" $T_CREATEREF>>$LOG;
    printf "%-45s:%d\n" "T_COMPAREREF|COMPAREREF|COMPARE|COMP" $T_COMPAREREF>>$LOG;
    printf "%-45s:%d\n" "T_PRINTREF|PRINTREF|PREF" $T_PRINTREF>>$LOG;
    printf "%-45s:%d\n" "T_PRINTVAL|PRINTVAL|PVAL" $T_PRINTVAL>>$LOG;
    printf "%-45s:%d\n" "T_PRINTASSERT|PRINTASSERT|PASS" $T_PRINTASSERT>>$LOG;
    printf "%-45s:%d\n" "T_FORCEOK|FORCEOK|FOK" $T_FORCEOK>>$LOG;
    printf "%-45s:%d\n" "T_LISTREF|LISTREF|LIST" $T_LISTREF>>$LOG;
    echo >>$LOG    
    return 0
}


## \endcond
#P ##
#P # @brief Initializes test file system  
#P #
#P # @param a $1:=curtop=${TSTCALLROOT}
#P # @param b $2:=newtop=${TSTREF}
#P #
#P # @ingroup libutalm_tdd
#P def refDataInit(a,b):
#P 	pass
## \cond
function refDataInit () {
	TSTCALLROOT=${1:-$TSTCALLROOT}
	if [ ! -d "$TSTCALLROOT" ];then
		printERR $LINENO $BASH_SOURCE 0 "Missing TSTCALLROOT=$1"
		gotoHell $LINENO $BASH_SOURCE $E_SYS
	fi
	TSTREF=${2:-$TSTREF}	
	if [ ! -d "$TSTREF" ];then
		printERR $LINENO $BASH_SOURCE 0 "Missing TSTREF=$2"
		gotoHell $LINENO $BASH_SOURCE $E_SYS
	fi
}


## \endcond
#P ##
#P # @brief Gets the storage path for ID  
#P #
#P #
#P # @param a $1=id 
#P #
#P # @ingroup libutalm_tdd
#P def refDataStorePath(a):
#P 	pass
## \cond
function refDataStorePath () {
	local id=${1:-ID000}
	local refData=${2}
	local out=$(getSubBranch  $TSTCALLROOT)
	out=${TSTREF}/$out/$id
				
	if [ ! -e "${out}" ];then
		printERR $LINENO $BASH_SOURCE 0 "Missing reference data:${out}"
		gotoHell $LINENO $BASH_SOURCE $E_SYS
	fi
	echo -n -e  "${out}"
}


## \endcond
#P ##
#P # @brief Read data for ID  
#P #
#P # Duplicates subbranch of curtop in newtop.
#P #
#P # @param a $1=id 
#P #
#P # @ingroup libutalm_tdd
#P def refDataStore(a):
#P 	pass
## \cond
function refDataRead () {
	local id=${1:-ID000}
	local refData=${2}
	local out=$(getSubBranch  $TSTCALLROOT)
	out=${TSTREF}/$out/$id
				
	if [ ! -e "${out}" ];then
		printERR $LINENO $BASH_SOURCE 0 "Missing reference data:${out}"
		gotoHell $LINENO $BASH_SOURCE $E_SYS
	fi
	cat ${out}
}


## \endcond
#P ##
#P # @brief Creates a directory branch from current subtree  
#P #
#P # Duplicates subbranch of curtop in newtop.
#P #
#P # @param a $1=id 
#P # @param b $2=refData
#P #
#P # @ingroup libutalm_tdd
#P def refDataRead(a,b):
#P 	pass
## \cond
function refDataStore () {
	if [ -z "$TSTCALLROOT" ];then
		printERR  $LINENO $BASH_SOURCE $SYS "Missing variable:TSTCALLROOT" 
		gotoHell $LINENO $BASH_SOURCE $E_SYS
	fi
	if [ ! -d "$TSTCALLROOT" ];then
		printERR  $LINENO $BASH_SOURCE $SYS "No directory:TSTCALLROOT" 
		gotoHell $LINENO $BASH_SOURCE $SYS
	fi
	local id=${1:-ID000}
	local refData=${2}
	mirrorBranchNode $TROOT ${TSTREF}
	local out=$(getSubBranch  $TSTCALLROOT)
	out=${TSTREF}/$out/$id
	if [ ! -d "${out%/*}" ];then
		mkdir -p "${out%/*}"
	fi
	echo -e -n "$refData">${out}
	return
}


## \endcond
#P ##
#P # Checks condition end exits with result
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
#P # @param a $1:=LINENO of caller
#P # @param b $2:=BASH_SOURCE of caller
#P # @param c $3:=condition
#P #   * 0 : boolean True
#P #   * [0-9]* : boolean False
#P #   * anything else : logical expression to be evaluated, '$?' applied  
#P # 
#P # 
#P # @return with 0 for Ok, 1 for False
#P # @ingroup libutalm_tdd
#P def assertWithExit(a,b,c):
#P 	pass
## \cond
function assertWithExit () {
	local a=$1;shift
	local b=$1;shift
	local e=$*
	local o=$*
	printINFO 3 $a $b 1  "$*"
	(((T_CREATEREF|T_COMPAREREF|T_FORCEOK|T_PRINTREF|T_PRINTVAL|T_PRINTASSERT|T_LISTREF)&TESTMODE))||{
		assert $LINENO $BASH_SOURCE 1
	}
	[[ -n "${e//[0-9]/}" ]]&&{
		#eval $* 2>&1 >/dev/null
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

		eval $x >&2
		e=$?
	}
	((TESTMODE&T_PRINTASSERT))&&echo -e "$*">>$LOG;
	((TESTMODE&T_FORCEOK))&&assert  $l $s 0;
	((e==0))&&{
		echo "utalm_exit:0">>$LOG
		exit 0
	}
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
#P # @brief Store and assert a data-string vs. a content of a file storrage  
#P #
#P # Handles unit and regression test cases related to dynamic data vs. stored
#P # copy. 
#P #
#P #	TESTMODE
#P #
#P # @param a $1:= linennumber 
#P # @param b $2:= filename
#P # @param c $3:= id 
#P # @param d $4:= data
#P #
#P # @ingroup libutalm_tdd
#P def assertRefDataWithExit(a,b,c,d):
#P 	pass
## \cond
function assertRefDataWithExit () {
	local l=$1;shift
	local s=$1;shift
	local id=${1:-ID000};shift
	local data=$*
	((TESTMODE&T_CREATEREF))&&{ refDataStore ${id} "${data}"; }
	((TESTMODE&T_PRINTREF))&&{ echo $(refDataRead $id); return 0; }
	((TESTMODE&T_PRINTVAL))&&{ echo -n -e $data; return 0; }
	((TESTMODE&T_LISTREF))&&{ refDataStorePath $id ;echo;return 0; }
	(((TESTMODE&(T_COMPAREREF|T_CREATEREF|T_PRINTASSERT))>0))&&{
		OFS=$FS
		export FS='%'
		local refdat=$(refDataRead $id);
		assertWithExit $l $s "[[ '$data' == '$refdat' ]]";
	}
	((TESTMODE&T_FORCEOK))&&assertWithExit  $l $s 0;
	#
	assertWithExit  $l $s 1
}


## \endcond
#P ##
#P # @brief prints reference data for ID  
#P #
#P # @param a $1:= id 
#P #
#P # @ingroup libutalm_tdd
#P def printRefData(a):
#P 	pass
## \cond
function printRefData () {
	local id=${5:-ID000}
	#	local refData=${2}
	local out=$(getSubBranch  $TSTCALLROOT)
	out=${TSTREF}/$out/$id
	if [ ! -e "${out}" ];then
		printERR $LINENO $BASH_SOURCE 0 "Missing reference data:${out}"
		gotoHell $LINENO $BASH_SOURCE $E_SYS
	fi
	printDBG $1 $2 $3 $4 "${out}"
	printDBGBLOB $1 $2 $3 $4 $(cat "${out}")
}



fi #*** prevent multiple inclusion
## \endcond #KEEP# PERSISTENT
