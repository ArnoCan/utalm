#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENCE:      Apache-2.0
#VERSION:      03_01_001
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
#

#
# filled from includes
#
PKG_SRC_IMP_FILES =
PKG_SRC_IMP_DIRS =
PKG_SRC_FILES =
PKG_SRC_DIRS =
PKG_HLP_IMP	= 
PKG_DOC_IMP	= 
IMGS = 

#
#common

PKG_DOC_IMP	+= $(addprefix $(TGZ_ROOT)/doc/images/,$(notdir $(wildcard $(DOCBASE_ML)/images/*)))
PKG_DOC_IMP	+= $(addprefix $(TGZ_ROOT)/doc/css/,$(notdir $(wildcard $(DOCBASE_ML)/css/*)))
PKG_DOC_IMP	+= $(addprefix $(TGZ_ROOT)/doc/js/,$(notdir $(wildcard $(DOCBASE_ML)/js/*.js)))
PKG_DOC_IMP	+= $(addprefix $(TGZ_ROOT)/doc/,$(notdir $(wildcard $(DOCBASE_ML)/*.ico)))
PKG_DOC_IMP	+= $(addprefix $(TGZ_ROOT)/doc/,$(notdir $(wildcard $(DOCBASE_ML)/*.html)))

###
include Makefile-src-en.mk
include Makefile-doctree-en.mk
include Makefile-doctree-de.mk
###

PKG_DOC_IMP 	+= $(IMGS)


#
UNIQUE_PKG_SRC_FILES:=$(shell for i in ${PKG_SRC_IMP_FILES};do echo $$i;done|sort -u)
UNIQUE_PKG_SRC_DIRS:=$(shell for i in ${PKG_SRC_IMP_DIRS};do echo $$i;done|sort -u)

UNIQUE_PKG_SRC_IMP_FILES:=$(addprefix $(TGZ_ROOT)/,$(notdir $(UNIQUE_PKG_SRC_FILES)))
UNIQUE_PKG_SRC_IMP_DIRS:=$(addprefix $(TGZ_ROOT)/,$(notdir $(UNIQUE_PKG_SRC_DIRS)))

UNIQUE_PKG_DOC_IMP_DIRS=$(dir ${PKG_DOC_IMP})
UNIQUE_PKG_DOC_IMP_DIRS:=$(shell for i in ${UNIQUE_PKG_DOC_IMP_DIRS};do echo $$i;done|sort -u)
OUTDIRS += $(UNIQUE_PKG_DOC_IMP_DIRS)

UNIQUE_PKG_HLP_IMP_DIRS=$(dir ${PKG_HLP_IMP})
UNIQUE_PKG_HLP_IMP_DIRS:=$(shell for i in ${UNIQUE_PKG_HLP_IMP_DIRS};do echo $$i;done|sort -u)
OUTDIRS += $(UNIQUE_PKG_HLP_IMP_DIRS)

PKG_COMMON_PREREQ =  $(VARIANT_ROOT) $(TGZ_ROOT) $(OUTDIRS) 
PKG_COMMON_PREREQ += $(UNIQUE_PKG_DOC_IMP_DIRS) $(UNIQUE_PKG_HLP_IMP_DIRS)

.PHONY: PREPMETA RTBASE DOCBASE WWWBASE DOC_BLD

all: PREPMETA $(TGZ_PNAME)
PREPMETA: outdirs  SRC_BLD DOC_BLD

$(TGZ_PNAME): $(TGZ_PNAME_BLD)
	@echo "Copy TGZ to $@"
	@$(CPA) $(TGZ_PNAME_BLD) $@

#
$(TGZ_PNAME_BLD): $(PKG_DOC_IMP) $(PKG_HLP_IMP) $(UNIQUE_PKG_SRC_IMP_FILES) $(UNIQUE_PKG_SRC_IMP_DIRS)
	$(ECHO) "Create TGZ-archive:$@"
ifdef VERBOSE
	$(ECHO) "PKG=$(TGZ_PNAME)"
	$(ECHO) "TGZ_ROOT=$(TGZ_ROOT)"
	$(ECHO) 
	$(ECHO) "Input:PKG_DOC_IMP="$(PKG_DOC_IMP)
	$(ECHO) 
	$(ECHO) "Input:PKG_HLP_IMP="$(PKG_HLP_IMP)
	$(ECHO) 
	$(ECHO) "Input:UNIQUE_PKG_SRC_IMP_FILES="$(UNIQUE_PKG_SRC_IMP_FILES) 
	$(ECHO) 
	$(ECHO) "Input:UNIQUE_PKG_SRC_IMP_DIRS="$(UNIQUE_PKG_SRC_IMP_DIRS) 
	$(ECHO) 
	$(ECHO) "Blacklist:PKG_BLACK="$(PKG_BLACK)
	$(ECHO) 
endif
	$(FIND) $(TGZ_ROOT) \
             \( -type d  -exec $(CHMOD) 755 {} \; \) \
	     -o \( -type f -name '*.sh'    -exec $(CHMOD) 755 {} \; \) \
	     -o \( -type f -exec $(CHMOD) 644 {} \; \)
	echo "cd $(dir $(TGZ_ROOT))&&$(TGZ) $@ $(notdir $(TGZ_ROOT))"
	cd $(dir $(TGZ_ROOT))&&$(TGZ) $@ $(notdir $(TGZ_ROOT))
	$(BLD_ROOT)/src/bin/setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" 
	$(BLD_ROOT)/src/bin/setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" --target=$(TGZ_ROOT)/VERSION


UNIQUE_PKG_DOC_IMP:=$(shell for i in ${PKG_DOC_IMP};do echo $$i;done|sort -u)
$(UNIQUE_PKG_DOC_IMP): DOC_BLD $(PKG_COMMON_PREREQ) $(dir $(PKG_DOC_IMP)) $(DOCBASE)
ifdef VERBOSE
	$(ECHO) "IMPORT-DOC:$(notdir $@)"
endif
	$(MKDIR) $(dir $@)
	$(CHMOD) 755 $(dir $@)
	#
	#TODO: FixIt - shifted due to priority for now
	$(if $(findstring /en/,$@),\
		$(CPA) "$(subst $(TGZ_ROOT)/doc/en,$(DOCBASE_ML)/en,$@)" "$(dir $@ )" \
		,\
		$(CPA) "$(subst $(TGZ_ROOT)/doc,$(DOCBASE_ML),$@)" "$(dir $@ )" \
	)

$(PKG_HLP_IMP): DOC_BLD $(PKG_COMMON_PREREQ) $(dir $(PKG_HLP_IMP)) $(DOCBASE)
ifdef VERBOSE
	$(ECHO) "IMPORT-HLP:$(notdir $@)"
endif
	$(CPA) $(subst $(TGZ_ROOT),$(DOCBASE_ML),$@) $(dir $(subst $(DOCBASE_ML)/doc,$(TGZ_ROOT),$@))


$(UNIQUE_PKG_SRC_IMP_FILES): $(UNIQUE_PKG_SRC_FILES) 
ifdef VERBOSE
	$(ECHO) "IMPORT-SRCFILES:$(notdir $@)"
endif
	@$(CPA) $(BLD_ROOT)$(notdir $@)  $(TGZ_ROOT)

$(UNIQUE_PKG_SRC_IMP_DIRS): $(UNIQUE_PKG_SRC_DIRS) 
ifdef VERBOSE
	$(ECHO) "IMPORT-SRCDIRS:$(notdir $@)"
endif
	@$(CPA) $(BLD_ROOT)$(notdir $@)  $(TGZ_ROOT)

$(SRC_POOL): $(ENVFILES)
	@echo "###Change to:$@"
	cd $@&& $(MAKE) $(MFLAGS)
	@echo "###..return from $@"


SRC_BLD:
	$(ECHO) "##Change to:src"
	$(MAKE) -C $(BLD_ROOT)src $(MFLAGS)
	$(ECHO) "##..return from $@"

DOC_BLD:
	@echo "###Change to:$@"
	$(MAKE) -C $(BLD_ROOT)doc $(MFLAGS)
	@echo "###..return from $@"


include $(BLD_ROOT)include/Makefile-post.mk
