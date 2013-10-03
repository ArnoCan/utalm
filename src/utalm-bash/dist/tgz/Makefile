#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
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
PKG_ENV_FILES =
PKG_ENV_DIRS =
PKG_SRC_FILES =
PKG_SRC_DIRS =
PKG_SRC_FILES =
PKG_SRC_DIRS =
PKG_HLP_DIRS = 
PKG_HLP_FILESS = 
PKG_DOC_FILES = 
PKG_DOC_DIRS = 
IMGS = 

###
include Makefile-src-en.mk
include Makefile-doctree-en.mk
include Makefile-doctree-de.mk

IMPORTS_DIRS =
IMPORTS_FILES =

IMPORTS_DIRS +=
IMPORTS_DIRS += $(PKG_ENV_DIRS)
IMPORTS_DIRS += $(PKG_SRC_DIRS)
IMPORTS_DIRS += $(PKG_DOC_DIRS)
IMPORTS_DIRS += $(PKG_ENV_DIRS)
IMPORTS_DIRS += $(PKG_SRC_DIRS)
IMPORTS_DIRS += $(PKG_HLP_DIRS)

IMPORTS_FILES +=
IMPORTS_FILES += $(PKG_ENV_FILES)
IMPORTS_FILES += $(PKG_SRC_FILES)
IMPORTS_FILES += $(PKG_ENV_FILES)
IMPORTS_FILES += $(PKG_SRC_FILES)
IMPORTS_FILES += $(PKG_DOC_FILES)
IMPORTS_FILES += $(PKG_HLP_FILES)

UNIQUE_IMPORTS_DIRS:=$(shell for i in ${IMPORTS_DIRS};do echo $$i;done|sort -u)
UNIQUE_IMPORTS_FILES:=$(shell for i in ${IMPORTS_FILES};do echo $$i;done|sort -u)

OUTDIRS += $(subst $(TGZ_ROOT)/doc,$(DOCBASE_ML),$(UNIQUE_IMPORTS_DIRS))

PKG_COMMON_PREREQ =  $(VARIANT_ROOT) $(TGZ_ROOT) $(OUTDIRS) 
PKG_COMMON_PREREQ += $(UNIQUE_IMPORTS_DIRS) $(UNIQUE_IMPORTS_FILES)

.PHONY: SRC_BLD DOC_BLD PREPTGZ

all: outdirs SRC_BLD DOC_BLD PREPTGZ $(TGZ_PNAME)

$(TGZ_PNAME):$(TGZ_PNAME_BLD)   
ifdef VERBOSE
	$(ECHO) "Copy TGZ-archive:$(TGZ_PNAME_BLD)"
endif
	cp $(TGZ_PNAME_BLD) $(TGZ_PNAME)
 
$(TGZ_PNAME_BLD):   
	$(ECHO) "Create TGZ-archive:$@"
ifdef VERBOSE
	$(ECHO) "PKG=$(TGZ_PNAME)"
	$(ECHO) "TGZ_ROOT=$(TGZ_ROOT)"
	$(ECHO) 
	$(ECHO) "Input:UNIQUE_IMPORTS_DIRS="$(UNIQUE_IMPORTS_DIRS) 
	$(ECHO) 
	$(ECHO) "Input:UNIQUE_IMPORTS_FILES="$(UNIQUE_IMPORTS_FILES) 
	$(ECHO) 
	$(ECHO) "Blacklist:PKG_BLACK="$(PKG_BLACK)
	$(ECHO) 
endif
	$(FIND) $(TGZ_ROOT) \
             \( -type d  -exec $(CHMOD) 755 {} \; \) \
	     -o \( -type f -name '*.sh'    -exec $(CHMOD) 755 {} \; \) \
	     -o \( -type f -exec $(CHMOD) 644 {} \; \)
ifdef VERBOSE
	$(BLD_ROOT)/src/bin/setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" -d 99999 
	$(BLD_ROOT)/src/bin/setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" --target=$(TGZ_ROOT)/VERSION -d 99999
else
	$(BLD_ROOT)/src/bin/setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" 
	$(BLD_ROOT)/src/bin/setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" --target=$(TGZ_ROOT)/VERSION
endif
	cd $(TGZ_ROOT)&&$(BLD_ROOT)collect-filelist.sh
	cd $(dir $(TGZ_ROOT))&&$(TGZ) $(TGZ_PNAME_BLD) $(notdir $(TGZ_ROOT))


PREPTGZ:
ifdef VERBOSE
	$(ECHO)
	$(ECHO) "IMPORT-DIRS:$(UNIQUE_IMPORTS_DIRS)"
	$(ECHO)
	$(ECHO) "IMPORT-FILES:$(UNIQUE_IMPORTS_FILES)"
	$(ECHO)
endif
	$(MKDIR) $(UNIQUE_IMPORTS_DIRS)
	$(CHMOD) 755 $(UNIQUE_IMPORTS_DIRS)
	#
#	for i in $(subst $(TGZ_ROOT)/doc,$(DOCBASE_ML),$(UNIQUE_IMPORTS_DIRS));do $(CPA) $$i $(TGZ_ROOT);done
	$(CPA) $(DOCBASE_ML) $(TGZ_ROOT)
	for i in $(subst $(TGZ_ROOT),$(RTBASE),$(UNIQUE_IMPORTS_DIRS));do $(CPA) $$i $(TGZ_ROOT);done
	#
#	for i in $(subst $(TGZ_ROOT)/doc,$(DOCBASE_ML),$(UNIQUE_IMPORTS_FILES));do $(CPA) $$i $(TGZ_ROOT);done
	for i in $(subst $(TGZ_ROOT),$(RTBASE),$(UNIQUE_IMPORTS_FILES));do $(CPA) $$i $(TGZ_ROOT);done


SRC_BLD:
	$(ECHO) "##Change to:src"
	$(MAKE) -C $(BLD_ROOT)src $(MFLAGS)
	$(ECHO) "##..return from $@"

DOC_BLD:
	@echo "###Change to:$@"
	$(MAKE) -C $(BLD_ROOT)doc $(MFLAGS)
	@echo "###..return from $@"


include $(BLD_ROOT)include/Makefile-post.mk
