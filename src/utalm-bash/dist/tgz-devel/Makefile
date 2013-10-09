#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENCE:      Apache-2.0
#VERSION:      03_02_002
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
tgz-devel:all
ifdef BLD_ROOT
  include $(BLD_ROOT)include/Makefile-pre.mk
else
  $(error "Missing environment variable BLD_ROOT")
endif

SRC_POOL        = 
#

#
# filled from includes
#
IMGS = 
IMPORT_DIRS =
IMPORT_FILES =

###
include Makefile-src-en.mk
###

UNIQUE_IMPORT_DIRS:=$(shell for i in ${IMPORT_DIRS};do echo $$i;done|sort -u)
UNIQUE_IMPORT_FILES:=$(shell for i in ${IMPORT_FILES};do echo $$i;done|sort -u)

.PHONY: SRC_BLD EXAMPLES_BLD TESTS_BLD DOC_BLD PREPTGZ

all: outdirs SRC_BLD EXAMPLES_BLD TESTS_BLD DOC_BLD PREPTGZ $(TGZ_DEVEL_PNAME)

.PHONY: src doc prep

$(TGZ_DEVEL_PNAME):$(TGZ_DEVEL_PNAME_BLD)   
ifdef DBG
	$(ECHO) "Copy TGZ-archive:$(TGZ_DEVEL_PNAME_BLD)"
endif
	cp $(TGZ_DEVEL_PNAME_BLD) $(TGZ_DEVEL_PNAME)
 
$(TGZ_DEVEL_PNAME_BLD):   
	$(ECHO) "Create TGZ-archive:$@"
ifdef DBG
	$(ECHO) "PKG=$(TGZ_DEVEL_PNAME)"
	$(ECHO) "TGZ_DEVEL_ROOT=$(TGZ_DEVEL_ROOT)"
	$(ECHO) 
	$(ECHO) "Input:UNIQUE_IMPORT_DIRS="$(UNIQUE_IMPORT_DIRS) 
	$(ECHO) 
	$(ECHO) "Input:UNIQUE_IMPORT_FILES="$(UNIQUE_IMPORT_FILES) 
	$(ECHO) 
	$(ECHO) "Blacklist:PKG_BLACK="$(PKG_BLACK)
	$(ECHO) 
endif
	$(FIND) $(TGZ_DEVEL_ROOT) \
             \( -type d  -exec $(CHMOD) 755 {} \; \) \
	     -o \( -type f -name '*.sh'    -exec $(CHMOD) 755 {} \; \) \
	     -o \( -type f -exec $(CHMOD) 644 {} \; \)
ifdef DBG
	setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" -d 99999 
	setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" --target=$(TGZ_DEVEL_ROOT)/VERSION -d 99999
else
	setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" 
	setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" --target=$(TGZ_DEVEL_ROOT)/VERSION
endif
	cd $(TGZ_DEVEL_ROOT)&&$(BLD_ROOT)collect-filelist.sh
	cd $(dir $(TGZ_DEVEL_ROOT))&&$(TARGZIP) $(TGZ_DEVEL_PNAME_BLD) $(notdir $(TGZ_DEVEL_ROOT))


prep:PREPTGZ
PREPTGZ:
ifdef DBG
	$(ECHO)
	$(ECHO) "IMPORT-DIRS:$(UNIQUE_IMPORT_DIRS)"
	$(ECHO)
	$(ECHO) "IMPORT-FILES:$(UNIQUE_IMPORT_FILES)"
	$(ECHO)
endif
	$(MKDIR) $(UNIQUE_IMPORT_DIRS)
	$(CHMOD) 755 $(UNIQUE_IMPORT_DIRS)
	$(CPA) $(IMPORT_DIRS) $(TGZ_DEVEL_ROOT)
	$(CPA) $(IMPORT_FILES) $(TGZ_DEVEL_ROOT)

src:SRC_BLD
SRC_BLD:
	$(ECHO) "##Change to:src"
	$(MAKE) -C $(BLD_ROOT)src $(MFLAGS)
	$(ECHO) "##..return from $@"

doc:DOC_BLD
DOC_BLD:
	@echo "###Change to:$@"
	$(MAKE) -C $(BLD_ROOT)doc $(MFLAGS)
	@echo "###..return from $@"

tests:TESTS_BLD
TESTS_BLD:
	@echo "###Change to:$@"
	$(MAKE) -C $(BLD_ROOT)tests $(MFLAGS)
	@echo "###..return from $@"

examples:EXAMPLES_BLD
EXAMPLES_BLD:
	@echo "###Change to:$@"
	$(MAKE) -C $(BLD_ROOT)examples $(MFLAGS)
	@echo "###..return from $@"

include $(BLD_ROOT)include/Makefile-post.mk
