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
tgz:all
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

all: outdirs SRC_BLD EXAMPLES_BLD TESTS_BLD DOC_BLD $(TGZ_PNAME)
.PHONY: outdirs src doc prep

$(TGZ_PNAME):pkgcopy
pkgcopy:$(TGZ_PNAME_BLD)
ifdef DBG
	$(ECHO) "Copy TGZ-archive:$(TGZ_PNAME_BLD)"
endif
	cp $(TGZ_PNAME_BLD) $(TGZ_PNAME)

#
_IMPORT_DIRS_DOCBASE_ML:=$(subst $(DOCBASE_ML),$(TGZ_ROOT)/doc/,$(IMPORT_DIRS_DOCBASE_ML))
UNIQUE_IMPORT_DIRS_DOCBASE_ML:=$(shell for i in ${_IMPORT_DIRS_DOCBASE_ML};do echo $$i;done|sort -u)
ifdef DBG
$(warning "UNIQUE_IMPORT_DIRS_DOCBASE_ML" $(UNIQUE_IMPORT_DIRS_DOCBASE_ML))
endif
#
_IMPORT_FILES_DOCBASE_ML:=$(subst $(DOCBASE_ML),$(TGZ_ROOT)/,$(IMPORT_FILES_DOCBASE_ML))
UNIQUE_IMPORT_FILES_DOCBASE_ML:=$(shell for i in ${_IMPORT_FILES_DOCBASE_ML};do echo $$i;done|sort -u)
ifdef DBG
$(warning "UNIQUE_IMPORT_FILES_DOCBASE_ML" $(UNIQUE_IMPORT_FILES_DOCBASE_ML))
endif
#
_IMPORT_DIRS_RTBASE:=$(subst $(RTBASE),$(TGZ_ROOT)/,$(IMPORT_DIRS_RTBASE))
UNIQUE_IMPORT_DIRS_RTBASE:=$(shell for i in ${_IMPORT_DIRS_RTBASE};do echo $$i;done|sort -u)
ifdef DBG
$(warning "UNIQUE_IMPORT_DIRS_RTBASE" $(UNIQUE_IMPORT_DIRS_RTBASE))
endif
#
_IMPORT_FILES_RTBASE:=$(subst $(RTBASE),$(TGZ_ROOT)/,$(IMPORT_FILES_RTBASE))
UNIQUE_IMPORT_FILES_RTBASE:=$(shell for i in ${_IMPORT_FILES_RTBASE};do echo $$i;done|sort -u)
ifdef DBG
$(warning "UNIQUE_IMPORT_FILES_RTBASE" $(UNIQUE_IMPORT_FILES_RTBASE))
endif
#
_IMPORT_DIRS_BLD:=$(subst $(BLD_ROOT),$(TGZ_ROOT)/,$(IMPORT_DIRS_BLD))
UNIQUE_IMPORT_DIRS_BLD:=$(shell for i in ${_IMPORT_DIRS_BLD};do echo $$i;done|sort -u)
ifdef DBG
$(warning "UNIQUE_IMPORT_DIRS_BLD" $(UNIQUE_IMPORT_DIRS_BLD))
endif
#
_IMPORT_FILES_BLD:=$(subst $(BLD_ROOT),$(TGZ_ROOT)/,$(IMPORT_FILES_BLD))
UNIQUE_IMPORT_FILES_BLD:=$(shell for i in ${_IMPORT_FILES_BLD};do echo $$i;done|sort -u)
#
$(TGZ_PNAME_BLD): pkgbuild
pkgbuild: $(UNIQUE_IMPORT_DIRS_DOCBASE_ML) $(UNIQUE_IMPORT_FILES_DOCBASE_ML) $(UNIQUE_IMPORT_DIRS_RTBASE) $(UNIQUE_IMPORT_FILES_RTBASE) $(UNIQUE_IMPORT_DIRS_BLD) $(UNIQUE_IMPORT_FILES_BLD)
	$(ECHO) "Create TGZ-archive:$@"
ifdef DBG
	$(ECHO) "PKG=$(TGZ_PNAME)"
	$(ECHO) "TGZ_ROOT=$(TGZ_ROOT)"
	$(ECHO) 
endif
	echo "PKG=$(TGZ_PNAME)"
	echo "TGZ_ROOT=$(TGZ_ROOT)"
	$(FIND) $(TGZ_ROOT) \
             \( -type d  -exec $(CHMOD) 755 {} \; \) \
	     -o \( -type f -name '*.sh'    -exec $(CHMOD) 755 {} \; \) \
	     -o \( -type f -exec $(CHMOD) 644 {} \; \)
ifdef DBG
	echo setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" -d 99999 
	setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" -d 99999 
	echo setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" --target=$(TGZ_ROOT)/VERSION -d 99999
	setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" --target=$(TGZ_ROOT)/VERSION -d 99999
else
	setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" 
	setversion.sh --version="$(VERSION)" --variant="$(VARIANT)" --release="$(RELEASE)" --target=$(TGZ_ROOT)/VERSION
endif
	cd $(TGZ_ROOT)&&$(BLD_ROOT)collect-filelist.sh
	cd $(dir $(TGZ_ROOT))&&$(TARGZIP) $(TGZ_PNAME_BLD) $(notdir $(TGZ_ROOT))

$(UNIQUE_IMPORT_DIRS_DOCBASE_ML) $(UNIQUE_IMPORT_FILES_DOCBASE_ML):$(subst $(TGZ_ROOT),,$@)
ifdef DBG
	$(ECHO) "Input-DOCBASE_ML:"$@ 
	$(ECHO) "  From:"$(DOCBASE_ML)$(subst $(TGZ_ROOT)/,,$@) 
	$(ECHO) "  Sub:"$(subst $(TGZ_ROOT)/,,$@) 
	$(ECHO) "  To:"$(TGZ_ROOT)
endif
	-$(CD) $(DOCBASE_ML).. && $(CP) $(CPOPTS) $(subst $(TGZ_ROOT)/,,$@) $(TGZ_ROOT)


$(UNIQUE_IMPORT_FILES_RTBASE) $(UNIQUE_IMPORT_DIRS_RTBASE):$(subst $(RTBASE),,$@)
ifdef DBG
	$(ECHO) "Input-RTBASE:"$@ 
	$(ECHO) "  From:"$(RTBASE)$(subst $(TGZ_ROOT)/,,$@) 
	$(ECHO) "  Sub:"$(subst $(TGZ_ROOT)/,,$@) 
	$(ECHO) "  To:"$(TGZ_ROOT)
endif
	-$(CD) $(RTBASE) && $(CP) $(CPOPTS) $(subst $(TGZ_ROOT)/,,$@)  $(TGZ_ROOT)


$(UNIQUE_IMPORT_DIRS_BLD) $(UNIQUE_IMPORT_FILES_BLD):$(subst $(BLD_ROOT),,$@)
ifdef DBG
	$(ECHO) "Input-BLD_ROOT:"$@ 
	$(ECHO) "  From:"$(BLD_ROOT)$(subst $(TGZ_ROOT)/,,$@) 
	$(ECHO) "  Sub:"$(subst $(TGZ_ROOT)/,,$@) 
	$(ECHO) "  To:"$(TGZ_ROOT)
endif
	-$(CD) $(BLD_ROOT) && $(CP) $(CPOPTS) $(subst $(TGZ_ROOT)/,,$@) $(TGZ_ROOT)



src:SRC_BLD
SRC_BLD:
	$(ECHO) "##Change to:src"
	$(MAKE) -C $(BLD_ROOT)src $(MFLAGS)
	$(ECHO) "##..return from $@"

docsrc:DOC_BLD
DOC_BLD:
	@echo "###Change to:$@"
	$(MAKE) -C $(BLD_ROOT)docsrc $(MFLAGS)
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
