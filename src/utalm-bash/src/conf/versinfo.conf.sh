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
#$Header: /home2/reps/cvs/proj/utalm/utalm-rt/src/conf/utalm/versinfo.conf.sh,v 1.3 2011/12/05 15:57:41 acue Exp $
#

################################################################
# Main supported runtime environments                          #
################################################################

#######
#OS
TARGET_OS="Linux, Cygwin, OpenBSD, Posix(bash)"

#######
#VM
TARGET_VM=""

#######
#WM
TARGET_WM=""


#LOC -Lines-Of-Code
#Generated during install:
# => find utalm.01_02_007a15 -type f -name '*[!~]'  -name '[!0-9][!0-9]*' -exec cat {} \;|wc -l
#LOC=36986

#LOD -Lines-Of-Documentation
#Generated during install:
# => find utalm.01_02_007a15 -type f -name '*[!~]'  -name '[0-9][0-9]*' -exec cat {} \;|wc -l
#LOD=8795

. ${MYCONFPATH}/versinfo.gen.sh
