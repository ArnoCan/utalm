#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-python
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

CPOPTS 		+= --parents 

CURSUBPATH  :=
#
SRC_FILES	+= 

#
SRC_DIRS	+= conf


#
SRC_DIRS	+= bin/bootstrap
#
SRC_FILES	+= bin/check-doxygen-cond-completion.sh
SRC_FILES	+= bin/check-doxygen-cond-pairs.sh
SRC_FILES	+= bin/check-if-fi-pairs.sh
SRC_FILES	+= bin/countErrors.sh
SRC_FILES	+= bin/doxygenfilter.awk
SRC_FILES	+= bin/doxygen-html-nav-entry.sh
SRC_FILES	+= bin/getCPUinfo.sh
SRC_FILES	+= bin/getCurArch.sh
SRC_FILES	+= bin/getCurDistribution.sh
SRC_FILES	+= bin/getCurGID.sh
SRC_FILES	+= bin/getCurOSRel.sh
SRC_FILES	+= bin/getCurOS.sh
SRC_FILES	+= bin/getCurRelease.sh
SRC_FILES	+= bin/getCurUTALMRel.sh
SRC_FILES	+= bin/getCurUTALMVariant.sh
SRC_FILES	+= bin/getPathToBin.sh
SRC_FILES	+= bin/getPathToBootstrapDir.sh
SRC_FILES	+= bin/getPathToLib.sh
SRC_FILES	+= bin/getVMinfo.sh
SRC_FILES	+= bin/setversion.sh
SRC_FILES	+= bin/strip-bash.sh
SRC_FILES	+= bin/testCaseStatistics.sh
SRC_FILES	+= bin/utalm-bash-cli.sh
SRC_FILES	+= bin/utalmhelp.sh

#
SRC_DIRS	+= lib/core
#
SRC_FILES	+= lib/libutalm.awk
SRC_FILES	+= lib/libutalm.sh
SRC_FILES	+= lib/libutalmfileobjects.sh
SRC_FILES	+= lib/libutalmrefpersistency.sh

