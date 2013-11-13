## \cond #KEEP# PERSISTENT
## <!--#***HEADSTART***-->
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
## <!-- $Header$ -->
#
## \endcond
## @file
## @brief Removes comments form bash sources
##
##  * Source:   @ref strip-bash.sh
##  * Stripped: @ref strip-bash-min.sh
##
## @ingroup libutalm_make
##
## <!--#***HEADEND***-->
##
## Strips script sources for runtime performance optimization, thus the 
## reference lines from documentation eventually may no longer be valid.
## Current version supports:
##	bash, awk, sed
##
## <b>Syntax:</b>
##
##	strip-bash.sh <out-style> (-o <outdir-pathname>|--) <inputfile-pathname>
## 
## @param $1 <out-style>:=(KEEPLINES|DROPLINES)
## <ul>
##   <li>KEEPLINES<br />
##      Replaces comments only, keeps lines - empty lines too.
##      The line numbers are matching the referenced linen numbers 
##      from the generated inline documentation.
##   </li>
##   <li>DROPLINES<br />
##      Performs in addition to KEEPLINES, deletes comment only lines, and empty lines.
##   </li>
## </ul>
## @param $2 (-o <outdir-pathname>|--)
## <br />
## Absolute or relative pathname for output directory. Alternatively '--' (double-hyphen) for
## stdout.
## @param $3 <inputfile-pathname-list>
## <br />
## Absolute or relative pathname of input files.
## <br />
## Each output filename is:
## <pre>
##  <outdir-pathname> := <inputfile-pathname-prefix>-min.<inputfile-pathname-postfix>
## </pre>
##
## <b>Remarks:</b><br />
## Some minor limits are present for syntax support, this is due to
## pure implementation of the scanner as a bash/awk/sed script itself.
## 
## @ingroup utalm_bash
## \cond #KEEP# PERSISTENT
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
MYOS=$(${MYCALLPATH}/getCurOS.sh)
case ${MYOS} in
    SunOS)
    	gotoHell 1 $BASH_SOURCE 1
    	exit 1;
		;;
    *)
		;;
esac


function printHelp () {
	cat <<EOF

CALL: strip-bash.sh <out-style> (-o <outdir-pathname>|--) <inputfile-pathname>

PARAM:
	<out-style>:=(KEEPLINES|DROPLINES|MAXPERFORM[=#length])

OUTPUT:
	<outdir-pathname> := <inputfile-pathname-prefix>-min.<inputfile-pathname-postfix>
	or
	stdout for '--'
						
EOF
}
if [ -z "$*" ];then
	printHelp
	exit 0
fi

function filter1 () {
	awk -v b="${ACTION}" '
		#KEEP# MODE-ON-AWK
		BEGIN{
			buf="";
			ignore=0;
			hereend="_-_-_-_";
			modeawk=0;
			headstart=0;
		}
		$0~/KEEP/ && $0~/PERSISTENT/ && $0!~/IGNORE_THIS/{ #KEEP# IGNORE_THIS
			buf=sprintf("%s\n%s\n",buf,$0)
			next;
		}
				
		$0~/#***HEADSTART***/&&$0!~/IGNORE_THIS/{ #KEEP# IGNORE_THIS
			headstart=1;
			gsub("^[ \t]*","");
			gsub("^[ \t]*","",$0);
			if(buf~/^$/){
				printf("%s\n",$0);
			}else{
				printf("%s\n%s\n",buf,$0);
			}
			buf="";
			next;
		}
		$0~/#***HEADEND***/&&$0!~/IGNORE_THIS/{ #KEEP# IGNORE_THIS
			headstart=0;
			gsub("^[ \t]*","");
			gsub("^[ \t]*","",$0);
			if(buf~/^$/){
				printf("%s\n",$0);
			}else{
				printf("%s\n%s\n",buf,$0);
			}
			buf="";
			next;
		}
		headstart==1{
			printf("%s\n",$0);
			next;
		}
		/^[ \t]*#.*$/{
			if(b=="KEEPLINES")buf=sprintf("%s\n",buf);
			next;
		}

		# for bash is "...)" different than for sed/awk
		$0~/KEEP/ && $0~/MODE-ON-AWK/{ #KEEP# IGNORE_THIS
			if($0!~/IGNORE_THIS/){ #KEEP# IGNORE_THIS
				modeawk=1;
			}
		}
		$0~/KEEP/ && $0~/MODE-OFF-AWK/{ #KEEP# IGNORE_THIS
			if($0!~/IGNORE_THIS/){ #KEEP# IGNORE_THIS
				modeawk=0;
			}
		}
		ignore==0&&/^[ \t]*$/{
			if(b=="KEEPLINES")buf=buf"\n";
			next;
		}
		/<</{	#KEEP# IGNORE_THIS
			#buf=sprintf("%s\n%s\n",buf,hereend);
			#buf=sprintf("%strip-bash.shs-X-0-(%s)-",buf,$0);
								
			if($0~/IGNORE_THIS/&&$0~/KEEP/){
				gsub("[ \t]*#KEEP#"," #KEEP#",$0);	
				gsub("^[ \t]*","",$0);	
				if(buf==""){
					buf=$0;
				}else{
					buf=sprintf("%s%s\n",buf,$0);
				}
				next;
			}else{
				hereend_=$0;
				gsub("^.*cat.*<<[-]*[ \t]*","",hereend_);	#KEEP# IGNORE_THIS
				gsub("[ \t]*$","",hereend_);
				gsub("[ \t]*$","",buf);
				gsub("[ \t]*$","",$0);
				gsub("^[ \t]*","",$0);
				#printf("\nhereend_=%s\n",hereend_);
				if(buf~/[({][ \n\t]*$/){
					gsub("[ \t\n]*$","",buf);
					buf=sprintf("%s %s",buf,$0);
				}else{
					if(buf!~/[\n][ \t\n]*$/){
						buf=sprintf("%s;%s",buf,$0);
					}else{
						buf=sprintf("%s%s",buf,$0);
					}
				}
				print buf
				buf="";
				ignore=1;
				hereend=hereend_;
				next;
			}
		}
		$0!~/^$/{
			if(hereend==$1){
				printf("%s\n",$0);
				ignore=0;
				hereend="_-_-_-_";
				next;
			}
		}
		{
			if(ignore==1){
				#printf("\nIGNx\n");
				printf("%s\n",$0);
				next;
			}
			gsub("[ \t]$","");
			gsub("[ \t]*$","");
			gsub("^[ \t]*","");
			#gsub("^[ \t]*","",buf);
			buf=sprintf("%s%s\n",buf,$0);
			#buf=""
		}
		END{printf("%s",buf);}
		#KEEP# MODE-OFF-AWK
	'#|sed 's/;[ \t]*;[ \t]*;/;;/g;s/;[ \t]*;[ \t]*;/;;/g;'|sed 's/|\\;/|/g;s/|;/|/g;'
}


ARGV=$*
ACTION=;
MAXPERFORMARG=0;

case $1 in
	KEEPLINES)ACTION=KEEPLINES;;
	DROPLINES)ACTION=DROPLINES;;
	*)
		echo "ERROR:Missing <strip-type>">&2
		exit 1
	;;
esac
shift

if [ -z "$1" -o \( $1 != '-o' -a $1 != '--' \) -o \( $1 == '-o' -a \( -z "$2" -o ! -d "$2" \) \) ];then
	echo
	echo "ERROR:Missing output directory/stream:$*">&2
	exit 1
fi
OUTDIR=$1
[ $1 != '--' ]&&shift&&OUTDIR=$1
shift 

if [ -z "$1" -o ! -e "$1" ];then
	echo
	echo "ERROR:Missing input file:$1">&2
	exit 1
fi
for i in $*;do 
	if [ ! -e "$i" ];then
		echo
		echo "">&2
		echo "ERROR:Missing file:$i">&2
		echo "">&2
		exit 1	
	fi
	if [ "$OUTDIR" != "--" ];then
		OUTFILE=${i%/*}
		OUTFILE=${i%.*}-min.${i##*\.}
		OUTFILE=${OUTFILE##*/}
	fi
	cat $i|\
	case $ACTION in
		KEEPLINES)
			filter1
			;; 
		DROPLINES)
			filter1
			;; 
	esac|\
	if [ "$OUTDIR" != "--" ];then \
		cat > $OUTDIR/$OUTFILE; \
	else \
		cat; \
	fi
done

## \endcond #KEEP# PERSISTENT
