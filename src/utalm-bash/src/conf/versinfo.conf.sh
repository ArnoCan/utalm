#!/bin/bash
## \cond
#HEADSTART##############################################################
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
# refer to source-package for unstripped sources
#
#HEADEND################################################################
#
#$Header$
#
##
## \endcond
##
## @file
## @brief Version specific statistics
##
## \cond
##
#

################################################################
# Main supported runtime environments                          #
################################################################

## \endcond
## TARGET_OS
#
TARGET_OS="Linux, Cygwin, OpenBSD, Posix(bash)"

## VirtualMachine
#
# Targeted VirtualMachine
TARGET_VM=""

## WindowManager
#
# Targeted WindowManager
TARGET_WM=""

## LineOfCode
#
# Lines-Of-Code, this info is generated during install:
# <pre>
#	find utalm.01_02_007a15 -type f -name '*[!~]'  -name '[!0-9][!0-9]*' -exec cat {} \;|wc -l
# </pre>
LOC=36986

## LinesOfDocumentation
#
# LOD -Lines-Of-Documentation, this info is generated during install:
# <pre>
#	find utalm.01_02_007a15 -type f -name '*[!~]'  -name '[0-9][0-9]*' -exec cat {} \;|wc -l
# </pre>
LOD=8795

## \cond
. ${MYCONFPATH}/versinfo.gen.sh
## \endcond
