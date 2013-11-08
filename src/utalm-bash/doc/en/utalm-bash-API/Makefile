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
ifndef OUTLANG
  $(error "Missing environment variable OUTLANG")
endif
ifdef DOC_BLD_ROOT
  include $(DOC_BLD_ROOT)$(OUTLANG)/include/Makefile-pre.mk
else
  $(error "Missing environment variable DOC_BLD_ROOT")
endif

######################################################

#export PYTHON_STYLE_WORKAROUND = 1
#C_STYPE_WORKAROUND = 1
 
SRC_POOL =


OUTSTEM		= $(CALLDIRNAME)
OUTFNAMES	= 

include Makefile-src-en.mk

DOXYGEN_HTML_DIR = $(OUTHTML3)/$(OUTSTEM)

DOXYGEN_HTML_FILES = $(DOXYGEN_HTML_DIR)/index.html
OUTFILES	+= $(DOXYGEN_HTML_FILES) 

# DOXYGEN_HTML_CALLBASE = $(RTBASE)
STRIP_FROM_PATH = $(RTBASE)

PROJECT_LOGO = $(DOCBASE_ML)images/utalm-green-96x60.png
#PROJECT_LOGO = $(DOCBASE_ML)images/utalm-92x60.png
HTML_HEADER = header.html
HTML_STYLESHEET = utalm.css 

DOXYGEN_HTML_INPUT =
DOXYGEN_HTML_INPUT_FILES_SRC =
DOXYGEN_HTML_INPUT_DIRS_SRC =
DOXYGEN_HTML_INPUT_FILES =
DOXYGEN_HTML_INPUT_DIRS =

DOXYGEN_HTML_INPUT_FILES += $(RTBASE)INSTALL.txt
DOXYGEN_HTML_INPUT_FILES += $(RTBASE)RELEASENOTES.txt
DOXYGEN_HTML_INPUT_FILES += $(RTBASE)sourceEnvironment.sh
DOXYGEN_HTML_INPUT_FILES += $(RTBASE)install-devel.sh
DOXYGEN_HTML_INPUT_FILES += $(RTBASE)install.sh

DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)lib/libutalm-eclipse.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)lib/libutalm.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)lib/libutalmfileobjects.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)lib/libutalmrefpersistency.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)collect-filelist.sh

DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)conf/versinfo.conf.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)conf/versinfo.gen.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)conf/utalm.conf
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)conf/utalm-bash.conf

DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/check-if-fi-pairs.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/getCPUinfo.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/getCurArch.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/getCurDistribution.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/getCurGID.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/getCurOSRel.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/getCurOS.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/getCurRelease.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/getCurUTALMRel.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/getCurUTALMVariant.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/getPathToBin.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/getPathToBootstrapDir.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/getPathToLib.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/getVMinfo.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/setversion.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/utalm-bash-cli.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/utalmhelp.sh

DOXYGEN_HTML_INPUT_FILES_SRC_GEN += $(RTBASE)lib/libutalm-min.sh
DOXYGEN_HTML_INPUT_FILES_SRC_GEN += $(RTBASE)lib/libutalmfileobjects-min.sh
DOXYGEN_HTML_INPUT_FILES_SRC_GEN += $(RTBASE)lib/libutalmrefpersistency-min.sh

DOXYGEN_HTML_INPUT_FILES += mainpage.dox
DOXYGEN_HTML_INPUT_FILES += historyandorigin.dox
DOXYGEN_HTML_INPUT_FILES += aboututalm.dox
DOXYGEN_HTML_INPUT_FILES += license.dox
DOXYGEN_HTML_INPUT_FILES += install.dox
DOXYGEN_HTML_INPUT_FILES += introbash.dox
DOXYGEN_HTML_INPUT_FILES += syntax-bash.dox
DOXYGEN_HTML_INPUT_FILES += howto-bash.dox

DOXYGEN_HTML_INPUT_DIRS += $(RTBASE)examples/utalm-bash
DOXYGEN_HTML_INPUT_DIRS += $(RTBASE)tests/utalm-bash

DOXYGEN_HTML_INPUT_DIRS_SRC += $(RTBASE)bin/bootstrap
DOXYGEN_HTML_INPUT_DIRS_SRC += $(RTBASE)lib/core
#DOXYGEN_HTML_INPUT_DIRS_SRC += $(RTBASE)bin

DOXYGEN_HTML_INPUT += $(DOXYGEN_HTML_INPUT_FILES)
DOXYGEN_HTML_INPUT += $(DOXYGEN_HTML_INPUT_DIRS)
DOXYGEN_HTML_INPUT += $(DOXYGEN_HTML_INPUT_FILES_SRC_GEN)
DOXYGEN_HTML_INPUT += $(DOXYGEN_HTML_INPUT_FILES_SRC)
DOXYGEN_HTML_INPUT += $(DOXYGEN_HTML_INPUT_DIRS_SRC)


DOXYGEN_HTML_CONF = Doxyfile.conf
DOXYGEN_HTML_LAYOUT = DoxygenLayout.xml
DOXYGEN_HTML_INPUT_CONF =  Doxyfile_Inputfiles.conf
DOXYGEN_HTML_OUTPUT_CONF =  Doxyfile_Outputfiles.conf

OUTDIRS += $(RTBASE)lib
OUTDIRS += $(RTBASE)bin
OUTDIRS += $(RTBASE)conf
OUTDIRS += $(RTBASE)conf/macros
OUTDIRS += $(RTBASE)conf/utalm.d
 
OUTFILES	= 

#for safety now
INCLUDES=$(wildcards $(BLD_ROOT)include/*)
INCLUDES=$(wildcards $(DOC_BLD_ROOT)include/*)
INCLUDES=$(wildcards ../include/*)

all:outdirs $(ENVFILES) topmain $(INCLUDES) $(DOXYGEN_HTML_FILES)
$(DOXYGEN_HTML_FILES):$(DOXYGEN_HTML_INPUT)


$(RTBASE)conf/versinfo.conf.sh:$(BLD_ROOT)src/conf/versinfo.conf.sh
	$(CP) $? $(@D)
$(RTBASE)conf/versinfo.gen.sh:$(BLD_ROOT)src/conf/versinfo.gen.sh
	$(CP) $? $(@D)
$(RTBASE)conf/utalm-bash.conf:$(BLD_ROOT)src/conf/utalm-bash.conf
	$(CP) $? $(@D)

$(RTBASE)INSTALL.txt:$(BLD_ROOT)INSTALL.txt
	$(CP) $? $(@D)
$(RTBASE)RELEASENOTES.txt:$(BLD_ROOT)RELEASENOTES.txt
	$(CP) $? $(@D)
$(RTBASE)sourceEnvironment.sh:$(BLD_ROOT)sourceEnvironment.sh
	$(CP) $? $(@D)
$(RTBASE)install-devel.sh:$(BLD_ROOT)install-devel.sh
	$(CP) $? $(@D)
$(RTBASE)install.sh:$(BLD_ROOT)install.sh
	$(CP) $? $(@D)

$(RTBASE)lib/libutalm-eclipse.sh:$(BLD_ROOT)src/lib/libutalm-eclipse.sh
	$(CP) $? $(@D)
$(RTBASE)lib/libutalm.sh:$(BLD_ROOT)src/lib/libutalm.sh
	$(CP) $? $(@D)
$(RTBASE)lib/libutalmfileobjects.sh:$(BLD_ROOT)src/lib/libutalmfileobjects.sh
	$(CP) $? $(@D)
$(RTBASE)lib/libutalmrefpersistency.sh:$(BLD_ROOT)src/lib/libutalmrefpersistency.sh
	$(CP) $? $(@D)

$(RTBASE)bin/check-if-fi-pairs.sh:$(BLD_ROOT)src/bin/check-if-fi-pairs.sh
	$(CP) $? $(@D)
$(RTBASE)bin/getCPUinfo.sh:$(BLD_ROOT)src/bin/getCPUinfo.sh
	$(CP) $? $(@D)
$(RTBASE)bin/getCurArch.sh:$(BLD_ROOT)src/bin/getCurArch.sh
	$(CP) $? $(@D)
$(RTBASE)bin/getCurDistribution.sh:$(BLD_ROOT)src/bin/getCurDistribution.sh
	$(CP) $? $(@D)
$(RTBASE)bin/getCurGID.sh:$(BLD_ROOT)src/bin/getCurGID.sh
	$(CP) $? $(@D)
$(RTBASE)bin/getCurOSRel.sh:$(BLD_ROOT)src/bin/getCurOSRel.sh
	$(CP) $? $(@D)
$(RTBASE)bin/getCurOS.sh:$(BLD_ROOT)src/bin/getCurOS.sh
	$(CP) $? $(@D)
$(RTBASE)bin/getCurRelease.sh:$(BLD_ROOT)src/bin/getCurRelease.sh
	$(CP) $? $(@D)
$(RTBASE)bin/getCurUTALMRel.sh:$(BLD_ROOT)src/bin/getCurUTALMRel.sh
	$(CP) $? $(@D)
$(RTBASE)bin/getCurUTALMVariant.sh:$(BLD_ROOT)src/bin/getCurUTALMVariant.sh
	$(CP) $? $(@D)
$(RTBASE)bin/getPathToBin.sh:$(BLD_ROOT)src/bin/getPathToBin.sh
	$(CP) $? $(@D)
$(RTBASE)bin/getPathToBootstrapDir.sh:$(BLD_ROOT)src/bin/getPathToBootstrapDir.sh
	$(CP) $? $(@D)
$(RTBASE)bin/getPathToLib.sh:$(BLD_ROOT)src/bin/getPathToLib.sh
	$(CP) $? $(@D)
$(RTBASE)bin/getVMinfo.sh:$(BLD_ROOT)src/bin/getVMinfo.sh
	$(CP) $? $(@D)
$(RTBASE)bin/setversion.sh:$(BLD_ROOT)src/bin/setversion.sh
	$(CP) $? $(@D)
$(RTBASE)bin/utalm-bash-cli.sh:$(BLD_ROOT)src/bin/utalm-bash-cli.sh
	$(CP) $? $(@D)
$(RTBASE)bin/utalmhelp.sh:$(BLD_ROOT)src/bin/utalmhelp.sh
	$(CP) $? $(@D)


$(RTBASE)collect-filelist.sh:
$(RTBASE)lib/libutalm-min.sh:$(RTBASE)lib/libutalm.sh
$(RTBASE)lib/libutalmfileobjects-min.sh:$(RTBASE)lib/libutalm.sh
$(RTBASE)lib/libutalmrefpersistency-min.sh:$(RTBASE)lib/libutalm.sh

# mainpage.dox
# historyandorigin.dox
# aboututalm.dox
# license.dox
# install.dox
# introbash.dox
# syntax-bash.dox
# howto-bash.dox

$(RTBASE)examples/utalm-bash:$(BLD_ROOT)examples/utalm-bash
	@echo
	@echo "###"
	@echo "#Change to:$@"
	cd $<&&$(MAKE) $(MFLAGS)
	@echo "#...finished:$@"
$(RTBASE)tests/utalm-bash:$(BLD_ROOT)tests/utalm-bash
	@echo
	@echo "###"
	@echo "#Change to:$@"
	cd $<&&$(MAKE) $(MFLAGS)
	@echo "#...finished:$@"

$(RTBASE)bin/bootstrap:$(BLD_ROOT)src/bin/bootstrap
	@echo
	@echo "###"
	@echo "#Change to:$@"
	mkdir -p ${@D}
	-$(CPA) $< ${@D}
	@echo "#...finished:$@"
$(RTBASE)lib/core:$(BLD_ROOT)src/lib/core
	@echo
	@echo "###"
	@echo "#Change to:$@"
	mkdir -p ${@D}
	-$(CPA) $< ${@D}
	@echo "#...finished:$@"
$(RTBASE)bin:$(BLD_ROOT)src/bin
	@echo
	@echo "###"
	@echo "#Change to:$@"
	cd $(BLD_ROOT)src&&$(MAKE) $(MFLAGS)
	@echo "#...finished:$@"
$(RTBASE)conf:$(BLD_ROOT)src/conf
	@echo
	@echo "###"
	@echo "#Change to:$@"
	mkdir -p ${@D}
	-$(CPA) $< ${@D}
	@echo "#...finished:$@"


.PHONY:topmain
topmain:
	INDENT0="$(INDENT0)" INDENT1="$(INDENT1)" BLD_ROOT=$(BLD_ROOT) OUTLANG=$(OUTLANG) SUBROOTTOP= CURSUBPATH= $(MAKE) -C $(BLD_ROOT) $(MFLAGS) files dirs


#
include $(BLD_ROOT)lib/Makefile.lib/Makefile-doxygen-rules.mk
#
#######################################################
#
include $(BLD_ROOT)include/Makefile-post.mk
#
