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

CPOPTS += --parents 

#
IMPORT_FILES_BLD	+= $(BLD_ROOT)README.md
IMPORT_FILES_BLD	+= $(BLD_ROOT)RELEASENOTES.txt
IMPORT_FILES_BLD	+= $(BLD_ROOT)INSTALL.txt
IMPORT_FILES_BLD	+= $(BLD_ROOT)Apache-2.0.txt
IMPORT_FILES_BLD	+= $(BLD_ROOT)install-devel.sh
IMPORT_FILES_BLD	+= $(BLD_ROOT)sourceEnvironment.sh

#
IMPORT_FILES_BLD += $(BLD_ROOT)TODO.txt
IMPORT_FILES_BLD += $(BLD_ROOT)collect-filelist.sh

#
IMPORT_FILES_BLD += $(BLD_ROOT)Makefile
IMPORT_FILES_BLD += $(BLD_ROOT)Makefile-nodeaction.mk
IMPORT_FILES_BLD += $(BLD_ROOT)Makefile-src-en.mk
IMPORT_FILES_BLD += $(BLD_ROOT)include/Makefile-root.mk
IMPORT_FILES_BLD += $(BLD_ROOT)include/Makefile-version.mk
IMPORT_FILES_BLD += $(BLD_ROOT)include/Makefile-post.mk
IMPORT_FILES_BLD += $(BLD_ROOT)include/Makefile-pre.mk
IMPORT_FILES_BLD += $(BLD_ROOT)include/Makefile-rules.mk

#
#IMPORT_DIRS_BLD	+= $(BLD_ROOT)bin

#
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/check-doxygen-cond-completion.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/check-doxygen-cond-pairs.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/doxygenfilter.awk
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/doxygen-html-nav-entry.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/strip-bash.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/testCaseStatistics.sh

#
#Requires make: 
IMPORT_DIRS_SRC   	+= $(BLD_ROOT)src/lib/Makefile.lib

#
IMPORT_DIRS_RTBASE	+= $(RTBASE)tests
