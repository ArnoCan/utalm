#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENCE:      Apache-2.0
#VERSION:      03_01_002
#
########################################################################
#
#   Copyright [2011,2012,2013] Arno-Can Uestuensoez
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
ifndef BLD_ROOT
	TGZ_BLD_ROOT := $(shell pwd)
	BLD_ROOT := $(dir $(TGZ_BLD_ROOT))/
	TGZ_BLD_ROOT := $(TGZ_BLD_ROOT)/
endif

ifdef BLD_ROOT
  include $(BLD_ROOT)include/Makefile-pre.mk
else
  $(error "Missing environment variable BLD_ROOT")
endif

SRC_POOL        = 
PKG_BASE_COMP	= 
#

#
# filled from includes
#
PKG_SRC_IMP_FILES	= 
PKG_SRC_IMP_DIRS	= 
include $(BLD_ROOT)dist/srctgz/Makefile-src-en.mk
#
UNIQUE_PKG_SRC_IMP_FILES:=$(shell for i in ${PKG_SRC_IMP_FILES};do echo $$i;done|sort -u)
UNIQUE_PKG_SRC_IMP_DIRS:=$(shell for i in ${PKG_SRC_IMP_DIRS};do echo $$i;done|sort -u)
OUTDIRS += $(UNIQUE_PKG_SRC_IMP_DIRS)

OUTFILES += $(SRCTGZ_PNAME)

PKG_COMMON_PREREQ =  $(VARIANT_ROOT) $(SRCTGZ_ROOT) $(OUTDIRS) 
PKG_COMMON_PREREQ += $(UNIQUE_PKG_SRC_IMP_DIRS_DIRS) 

.PHONY: srctgz delsrctgz dirsrctgz packonly

all:   outdirs $(SRCTGZ_PNAME) 


$(SRCTGZ_ROOT)/VERSION : 
ifdef VERBOSE
	$(BLD_ROOT)/src/bin/setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" -d 99999 
	$(BLD_ROOT)/src/bin/setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" --target=$(SRCTGZ_ROOT)/VERSION -d 99999
endif
	$(BLD_ROOT)/src/bin/setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" 
	$(BLD_ROOT)/src/bin/setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" --target=$(SRCTGZ_ROOT)/VERSION

srctgz $(SRCTGZ_PNAME): $(SRCTGZ_PNAME_BLD)
ifdef VERBOSE
	@echo "Copy TGZ to $(SRCTGZ_PNAME)"
endif
	@$(CPA) $(SRCTGZ_PNAME_BLD) $(SRCTGZ_PNAME)

$(SRCTGZ_PNAME_BLD) packonly: $(SRCTGZ_ROOT)/VERSION 
	$(ECHO) "Create TGZ-archive:$@"
ifdef VERBOSE
	$(ECHO) "PKG=$(SRCTGZ_PNAME)"
	$(ECHO) "TGZ_ROOT=$(SRCTGZ_ROOT)"
	$(ECHO) 
	$(ECHO) "Input:UNIQUE_PKG_SRC_IMP_DIRS"
	$(ECHO) $(UNIQUE_PKG_SRC_IMP_DIRS)
	$(ECHO) 
endif
	@$(CPA) $(UNIQUE_PKG_SRC_IMP_DIRS)  $(SRCTGZ_ROOT)
	@$(CPA) $(UNIQUE_PKG_SRC_IMP_FILES) $(SRCTGZ_ROOT)
	$(FIND) $(SRCTGZ_ROOT) \
             \( -type d  -exec $(CHMOD) 755 {} \; \) \
	     -o \( -type f -name '*.sh'    -exec $(CHMOD) 755 {} \; \) \
	     -o \( -type f -exec $(CHMOD) 644 {} \; \)
	cd $(dir $(SRCTGZ_ROOT))&&$(TGZ) $(SRCTGZ_PNAME_BLD) $(notdir $(SRCTGZ_ROOT))

delsrctgz : 
ifdef VERBOSE
	@echo "RM:$(SRCTGZ_PNAME)"
endif
	@$(RM) $(SRCTGZ_PNAME)

dirsrctgz : 
	@ls -l $(SRCTGZ_PNAME)

$(UNIQUE_UNIQUE_PKG_SRC_IMP_DIRS):
	$(MKDIR) $@
	$(CHMOD) 755 $@

include $(BLD_ROOT)include/Makefile-post.mk
