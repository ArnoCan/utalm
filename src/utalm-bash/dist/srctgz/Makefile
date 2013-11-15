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
pkg-src srctgz:all
ifdef BLD_ROOT
  include $(BLD_ROOT)include/Makefile-pre.mk
else
  $(error "Missing environment variable BLD_ROOT - see utalm-bash-API(3)")
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

.PHONY: SRC_BLD EXAMPLES_BLD TESTS_BLD DOC_BLD 

all: outdirs SRC_BLD EXAMPLES_BLD TESTS_BLD DOC_BLD  $(SRCTGZ_PNAME)

pkgcopy $(SRCTGZ_PNAME):$(SRCTGZ_PNAME_BLD)   
ifdef DBG
	@$(ECHO) "Copy SRCTGZ-archive:$(SRCTGZ_PNAME_BLD)"
endif
	cp $(SRCTGZ_PNAME_BLD) $(SRCTGZ_PNAME)
 
.PHONY:prep
pkgbuild $(SRCTGZ_PNAME_BLD):prep 
	@$(ECHO) "Create SRCTGZ-archive:$@"
ifdef DBG
	@$(ECHO) "PKG=$(SRCTGZ_PNAME)"
	@$(ECHO) "SRCTGZ_ROOT=$(SRCTGZ_ROOT)"
	@$(ECHO) 
	@$(ECHO) "Input:UNIQUE_IMPORT_DIRS="$(UNIQUE_IMPORT_DIRS) 
	@$(ECHO) 
	@$(ECHO) "Input:UNIQUE_IMPORT_FILES="$(UNIQUE_IMPORT_FILES) 
	@$(ECHO) 
endif
	$(FIND) $(SRCTGZ_ROOT) \
             \( -type d  -exec $(CHMOD) 755 {} \; \) \
	     -o \( -type f -name '*.sh'    -exec $(CHMOD) 755 {} \; \) \
	     -o \( -type f -exec $(CHMOD) 644 {} \; \)
ifdef DBG
	setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" -d 99999 
	setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" --target=$(SRCTGZ_ROOT)/VERSION -d 99999
	@$(ECHO) "cd $(SRCTGZ_ROOT)&&$(BLD_ROOT)collect-filelist.sh"
	@$(ECHO) "cd $(dir $(SRCTGZ_ROOT))&&$(TARGZIP) $(SRCTGZ_PNAME_BLD) $(notdir $(SRCTGZ_ROOT))"
else
	setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" 
	setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" --target=$(SRCTGZ_ROOT)/VERSION
endif
	cd $(SRCTGZ_ROOT)&&$(BLD_ROOT)collect-filelist.sh
	cd $(dir $(SRCTGZ_ROOT))&&$(TARGZIP) $(SRCTGZ_PNAME_BLD) $(notdir $(SRCTGZ_ROOT))


prep $(UNIQUE_IMPORT_DIRS) $(UNIQUE_IMPORT_FILES):
ifdef DBG
	@$(ECHO)
	@$(ECHO) "IMPORT-DIRS:$(UNIQUE_IMPORT_DIRS)"
	@$(ECHO)
	@$(ECHO) "IMPORT-FILES:$(UNIQUE_IMPORT_FILES)"
	@$(ECHO)
	@$(ECHO) $(MKDIR) $(UNIQUE_IMPORT_DIRS)
endif
	$(MKDIR) $(UNIQUE_IMPORT_DIRS)
ifdef DBG
	@$(ECHO) $(CHMOD) 755 $(UNIQUE_IMPORT_DIRS)
endif
	$(CHMOD) 755 $(UNIQUE_IMPORT_DIRS)
ifdef DBG
	@$(ECHO) $(CPA) $(UNIQUE_IMPORT_DIRS) $(SRCTGZ_ROOT)
endif
	$(CPA) $(UNIQUE_IMPORT_DIRS) $(SRCTGZ_ROOT)
ifdef DBG
	@$(ECHO) $(CPA) $(UNIQUE_IMPORT_FILES) $(SRCTGZ_ROOT)
endif
	$(CPA) $(UNIQUE_IMPORT_FILES) $(SRCTGZ_ROOT)

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

LOCALHELP=1
help:
	@echo "***************************************"
	@echo
	@echo "  VERSION        = $(VERSION)"
	@echo "  PACKAGE        = $(PACKAGE)"
	@echo
	@echo "***************************************"
	@echo
	@echo " Help on :'make' in $(shell basename $$PWD)"
	@echo
	@echo "  make"
	@echo "  - builds and copies into export directory"
	@echo "    EXPORT_DIR = $(EXPORT_DIR)"
	@echo
	@echo "  make pkgbuild"
	@echo "  - builds only"
	@echo
	@echo "  make pkgcopy"
	@echo "  - copies only"
	@echo
	@echo "  make helpglobal"
	@echo "  - displays global help"
	@echo

include $(BLD_ROOT)include/Makefile-post.mk
