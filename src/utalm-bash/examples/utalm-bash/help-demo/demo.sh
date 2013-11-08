#!/bin/bash
## \cond
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
#***MODUL_DOXYGEN_START***
## \endcond
## @ingroup helpDemo
## @file
## @brief Demonstration of debug help formats
##
## Example demonstrating the various help formats of UTALM for bash.
## For additional description refer to \ref helpDemo. 
## \cond
#***MODUL_DOXYGEN_END***
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


cat << EOF
Demostrates the early-fetch of cli options by utalm, type 

    demo.sh -d help
    demo.sh -d help:HTML
    demo.sh -d help:PDF
    demo.sh -d help:MAN

For special parameters with assigned pre-defined constants context specific
help is available.

* Provides a list of header format constants.

    demo.sh -d f:help

* Provides a subsystem constants.

    demo.sh -d s:help

* Provides a list of log-level constants.

    demo.sh -d l:help

You can set the following environment variables, refer to utalm-bash.conf:

	LANG
	
	BROWSER
	PDFVIEWER
	MANPATH

EOF

## \endcond
