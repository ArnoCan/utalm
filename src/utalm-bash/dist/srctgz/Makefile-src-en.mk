#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-python
#LICENCE:      Apache-2.0
#VERSION:      03_01_002
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

#
PKG_SRC_IMP_FILES	+= $(BLD_ROOT)README.md
PKG_SRC_IMP_FILES	+= $(BLD_ROOT)RELEASENOTES.txt
PKG_SRC_IMP_FILES	+= $(BLD_ROOT)INSTALL.txt
PKG_SRC_IMP_FILES	+= $(BLD_ROOT)TODO.txt
PKG_SRC_IMP_FILES	+= $(BLD_ROOT)Apache-2.0.txt

PKG_SRC_IMP_FILES	+= $(BLD_ROOT)install.sh
PKG_SRC_IMP_FILES	+= $(BLD_ROOT)installToSystem.sh
PKG_SRC_IMP_FILES	+= $(BLD_ROOT)install.conf
PKG_SRC_IMP_FILES	+= $(BLD_ROOT)collect-filelist.sh
PKG_SRC_IMP_FILES	+= $(BLD_ROOT)test.sh
PKG_SRC_IMP_FILES   += $(BLD_ROOT)utalm-bash-show-help.sh

PKG_SRC_IMP_FILES	+= $(BLD_ROOT)Makefile
PKG_SRC_IMP_FILES	+= $(BLD_ROOT)Makefile-root.mk
PKG_SRC_IMP_FILES	+= $(BLD_ROOT)Makefile-version.mk
PKG_SRC_IMP_FILES	+= $(BLD_ROOT)sourceEnvironment.sh

PKG_SRC_IMP_DIRS	+= $(BLD_ROOT)bin
PKG_SRC_IMP_DIRS	+= $(BLD_ROOT)conf
PKG_SRC_IMP_DIRS	+= $(BLD_ROOT)dist
PKG_SRC_IMP_DIRS	+= $(BLD_ROOT)doc
PKG_SRC_IMP_DIRS	+= $(BLD_ROOT)faq
PKG_SRC_IMP_DIRS	+= $(BLD_ROOT)help
PKG_SRC_IMP_DIRS	+= $(BLD_ROOT)howto
PKG_SRC_IMP_DIRS	+= $(BLD_ROOT)images
PKG_SRC_IMP_DIRS	+= $(BLD_ROOT)include

#
#sources
PKG_SRC_IMP_DIRS	+= $(BLD_ROOT)examples
PKG_SRC_IMP_DIRS	+= $(BLD_ROOT)src

#
#unittests
PKG_SRC_IMP_DIRS	+= $(BLD_ROOT)testlib
PKG_SRC_IMP_DIRS	+= $(BLD_ROOT)tests
