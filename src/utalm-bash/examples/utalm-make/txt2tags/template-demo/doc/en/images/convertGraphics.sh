#!/bin/bash
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
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


CALLDIR=$(dirname $0)
IMGSRC=${CALLDIR}

CALLARGS=$*

if [ -z "${CALLARGS}" ];then
    echo "ERROR: Missing arguments">&2
    exit 1
fi



if [ -z "${IMGTMP}" ];then
    export IMGTMP=${OUTIMG}
    if [ -z "${IMGTMP}" ];then
		echo "missing:OUTIMG=${OUTIMG}"
    fi
    if [ ! -d "${IMGTMP}" ];then
		mkdir -p ${IMGTMP}
    fi
fi



if [ -z "${IMGTMP}" ];then
    echo "missing:IMGTMP=${IMGTMP}"
    exit 1
fi

if [ ! -d "${IMGTMP}" ];then
    mkdir -p ${IMGTMP}
fi


declare -a IMGSOURCES


# multi-hyper-final-screen-01a.jpg
# multi-hyper-final-screen-01.jpg
# multi-hyper-final-screen-02.jpg

#eps input

IMGSOURCES=(
    NONE flag_usa_s.png
    NONE flag_d_s.png
);

imgarrsiz=${#IMGSOURCES[@]};

# echo "IMGTMP=${IMGTMP}"
# echo "<${CALLARGS}>"

# echo "-------------------------------------------"
# echo "epstopdf images - convert images"
# echo "-------------------------------------------"
for((i=0;i<imgarrsiz;i+=2)){
    SIZE=${IMGSOURCES[$i]}
    NAME=${IMGSOURCES[$((i+1))]}
    PNAME=${NAME}
    NAME=${NAME%.*}
    NAME=${NAME##*/}


    if [ "${CALLARGS}" != "ALL" ]; then
		if [ "${CALLARGS}" == "${CALLARGS//$PNAME}" ]; then
		    continue
		fi
    fi


    TRACE=;
    TRACE="  IMGSOURCES[$i]=${IMGSOURCES[$i]} - ${IMGSOURCES[$((i+1))]}"
#FFS:    OUTf=${IMGTMP}/${NAME}.pdf
#FFS:    TRACE=${TRACE}"\n    -> ${OUTf}"
#FFS:    epstopdf ${PNAME} --outfile=${OUTf} >/dev/null

    OUTf=${IMGTMP}/${NAME%.*}.png
    TRACE=${TRACE}"\n    -> ${OUTf}"

#echo "	SIZE=${SIZE}"

    if [ "${SIZE}" != "NONE" ];then
		convert  ${PNAME} -antialias -geometry ${SIZE} ${OUTf} >/dev/null
    else
#echo "	cp ${PNAME} ${OUTf}"
		cp ${PNAME} ${OUTf}
    fi
    if [ -n "$DBG" ];then
    	echo -e "${TRACE}\n"
    fi
}


#############
exit



