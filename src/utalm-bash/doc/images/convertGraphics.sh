#!/bin/bash
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
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
   NONE 8673.png
   NONE 60px-Official-gnu.png
   NONE gplv3-88x31.png
   NONE feather-88x26.png
   NONE feather-small.png

   NONE sourceforge-21x21.png
   NONE python-logo-21x21.png
   NONE github-21x21.png

    NONE bslogo.png
    NONE flag_usa_s.png
    NONE flag_d_s.png

    NONE sflogo.png
    NONE sflogo_004.png
    NONE sflogo_005.png
    NONE sflogo_006.png
    NONE sflogo_007.png

    NONE utalm-usm.png


    NONE twitter-2.png
    NONE twitter.png
    NONE t_logo-a.png
    NONE t_logo-b.png
    NONE t_logo-c.png

    NONE usm-21x21.png
    NONE usm-80x80.png
    NONE usm-50x50.png
    NONE usm-green-50x50.png

    NONE OSI-Approved-License-100x137.png
    NONE OSI-Approved-License-88x121.png

    NONE xing.png
    NONE linkedin.png
    NONE facebook.png
    NONE project-support.png

    NONE rss.png
    NONE Feed_48x48.png

    NONE google-buzz.png
    NONE mister-wong.png
    NONE blogger.png
    NONE picasa.png
    NONE wordpress.png
    NONE wordpress-2.png
    NONE w3.png
    NONE wikepedia.png
    NONE digg.png
    NONE delicious.png

    NONE sharethis.png
    NONE email.png
    NONE slideshare.png
    NONE stumbleupon.png
    NONE posterous.png
    NONE technorati.png
    NONE netvibes.png
    NONE reddit.png
    NONE linkagogo.png
    NONE yiggit.png
    NONE newsvine.png
    NONE vz.png
    NONE google.png

    NONE php-devenv-01.png
    NONE php-devenv-01a.png
    NONE php-devenv-02.png

    NONE xdg-menue-utalm-01.png
    NONE xdg-menue-utalm-02.png
    NONE wxp-01.png
    NONE wxp-02.png
    NONE wxp-vbox-01.png

    NONE wxp-xen-01.png
    NONE wxp-xen-02.png

    NONE wxp-guest-01.png
    NONE wxp-guest-02.png
    NONE wxp-guest-03.png

#    NONE .png
#    NONE .png
#    NONE .png


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



