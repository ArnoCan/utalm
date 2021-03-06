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

#
IMPORT_FILES	+= $(BLD_ROOT)README.md
IMPORT_FILES	+= $(BLD_ROOT)RELEASENOTES.txt
IMPORT_FILES	+= $(BLD_ROOT)INSTALL.txt
IMPORT_FILES	+= $(BLD_ROOT)TODO.txt
IMPORT_FILES	+= $(BLD_ROOT)Apache-2.0.txt

IMPORT_FILES	+= $(BLD_ROOT)install.sh
IMPORT_FILES	+= $(BLD_ROOT)collect-filelist.sh

IMPORT_FILES	+= $(BLD_ROOT)Makefile
IMPORT_FILES	+= $(BLD_ROOT)include/Makefile-root.mk
IMPORT_FILES	+= $(BLD_ROOT)include/Makefile-version.mk
IMPORT_FILES	+= $(BLD_ROOT)Makefile-src-en.mk
IMPORT_FILES	+= $(BLD_ROOT)sourceEnvironment.sh

IMPORT_DIRS		+= $(BLD_ROOT)bin
IMPORT_DIRS		+= $(BLD_ROOT)conf
IMPORT_DIRS		+= $(BLD_ROOT)dist
IMPORT_DIRS		+= $(BLD_ROOT)doc
IMPORT_DIRS		+= $(BLD_ROOT)faq
IMPORT_DIRS		+= $(BLD_ROOT)help
IMPORT_DIRS		+= $(BLD_ROOT)howto
IMPORT_DIRS		+= $(BLD_ROOT)images
IMPORT_DIRS		+= $(BLD_ROOT)include

#
#sources
IMPORT_DIRS		+= $(BLD_ROOT)examples
IMPORT_DIRS		+= $(BLD_ROOT)src

#
#unittests
IMPORT_DIRS		+= $(BLD_ROOT)tests
