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
pkg-src srcrpm:all
ifndef BLD_ROOT
  BLD_ROOT := $(dir $(shell pwd))/
endif
ifdef BLD_ROOT
  include $(BLD_ROOT)include/Makefile-pre.mk
else
  $(error "Missing environment variable BLD_ROOT - see utalm-bash-API(3)")
endif
################################################################

SRC_POOL =
OUTFILES = 

#SRCRPM_OPTS = -ba --buildroot=$(SRCRPMBLD)/bldroot --target=$(ARCH)
SRCRPM_OPTS = -ba --buildroot=$(SRCRPMBLD)/bldroot 
SRCRPM_OPTS += --define "%_topdir $(SRCRPMBLD)/redhat"
SRCRPM_OPTS += --define "%_sourcedir $(VARIANT_ROOT)"
#
SRCRPM_OPTS += --define "mydirname    ${PACKAGE}.src"
SRCRPM_OPTS += --define "mytgzname    ${PACKAGE}.src"
#SRCRPM_OPTS += --define "mytgzname    ${SRCTGZ_NAME}"
SRCRPM_OPTS += --define "mytgzfilename ${SRCTGZ_NAME}"
SRCRPM_OPTS += --define "mytgzpname   ${SRCTGZ_PNAME}"
SRCRPM_OPTS += --define "myversion    ${VERSION}"
SRCRPM_OPTS += --define "myvariant    ${VARIANT}"
SRCRPM_OPTS += --define "mylicense    ${LICENSE}"
SRCRPM_OPTS += --define "myproject    ${PROJECT}"
SRCRPM_OPTS += --define "myname       ${PACKAGE}"
SRCRPM_OPTS += --define "myvendor     \'${VENDOR}\'"
SRCRPM_OPTS += --define "mypackager   \'${PACKAGER}\'"
SRCRPM_OPTS += --define "myurl        '${WWW_PROJ}'"
 
ifeq ($(VARIANT),ALL)
OUTFILES += $(SRCRPM_PNAME)
SRCRPM_OPTS += --define "myrelease    ${RELEASE}_${VARIANT}"
endif

ifeq ($(VARIANT),ALPHA)
OUTFILES += $(SRCRPM_PNAME)
SRCRPM_OPTS += --define "myrelease    ${RELEASE}_${VARIANT}"
endif

ifeq ($(VARIANT),BETA)
OUTFILES += $(SRCRPM_PNAME)
SRCRPM_OPTS += --define "myrelease    ${RELEASE}_${VARIANT}"
endif

ifeq ($(VARIANT),INTERNAL)
OUTFILES += $(SRCRPM_PNAME)
SRCRPM_OPTS += --define "myrelease    ${RELEASE}_${VARIANT}"
endif

ifeq ($(VARIANT),SUPPORT)
OUTFILES += $(SRCRPM_PNAME)
SRCRPM_OPTS += --define "myrelease    ${RELEASE}_${VARIANT}"
endif

ifeq ($(VARIANT),RELEASE)
OUTFILES += $(SRCRPM_PNAME)
SRCRPM_OPTS += --define "myrelease    ${RELEASE}"
endif
ifeq ($(VARIANT),NIGHTLY)
OUTFILES += $(SRCRPM_PNAME)
SRCRPM_OPTS += --define "myrelease    ${RELEASE}_${VARIANT}"
endif

RPMDIRS =  $(foreach X, BUILD SOURCES SRPMS SPECS RPMS, $(SRCRPMBLD)/redhat/$(X))
RPMDIRS += $(foreach X, noarch i386 x86_64, $(SRCRPMBLD)/redhat/RPMS/$(X))
OUTDIRS += $(RPMDIRS)

ifndef DBG
SRCRPM_OPTS += --quiet
endif

all: outdirs $(SRCTGZ_PNAME) $(OUTFILES)  
pkg:$(OUTFILES)

#
################################################
#
#
pkgcopy $(SRCRPM_PNAME):  $(SRCTGZ_PNAME) $(SRCRPM_PNAME_BLD) 
	@$(ECHO) "#"
	@$(ECHO) "Copy RPM to $@"
	@$(CPA) $(SRCRPM_PNAME_BLD) $@

$(SRCRPM_PNAME_BLD): $(SRCRPM_SRCTGZ_PNAME) pkgbuild
pkgbuild: $(SRCRPM_SPECPATH)
	@$(ECHO) "#"
ifdef DBG
	@$(ECHO) "##########################################################################################"
	@$(ECHO) "#"
endif
	@$(ECHO) "Create RPM-all-archive:$@"
ifdef DBG
	@$(ECHO) 
	@$(ECHO) "SRCRPM_SPECNAME="$(SRCRPM_SPECNAME)
	@$(ECHO) 
	@$(ECHO) "SRCTGZ_PNAME="$(SRCTGZ_PNAME)
	@$(ECHO) 
	@$(ECHO) "$(RPMBUILD) $(SRCRPM_OPTS) $(SRCRPM_SPECPATH)"
endif
	@$(RPMBUILD) $(SRCRPM_OPTS) $(SRCRPM_SPECPATH) 

RPMDIRS: 
	$(ECHO) "Create redhat-rpm-directories"
	$(MKDIR) $(RPMBLD)/redhat/{BUILD,SOURCES,SRPMS,SPECS,RPMS} 
	$(MKDIR) $(RPMBLD)/redhat/RPMS/{noarch,i386,x86_64} 


$(SRCRPM_SPECPATH): $(SRCRPM_SPECNAME)
	@$(CPA) $(SRCRPM_SPECNAME) $@

$(SRCRPM_TGZ_PNAME): $(SRCTGZ_PNAME)
	$(ECHO) "Update TGZ in rpm-Tree"
	$(CPA) $(SRCTGZ_PNAME) $(RPMBLD)/redhat/RPMS/$(ARCH) 


$(SRCTGZ_PNAME):
	$(ECHO) "Update TGZ-Tree"
	$(MAKE) -C $(BLD_ROOT)tgz $(MFLAGS)

$(SRC_POOL): $(ENVFILES)
	@echo "###Change to:$@"
	cd $@&& $(MAKE) $(MFLAGS)

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

.PHONY: PREPMETA 

################################################################
ifdef BLD_ROOT
  include $(BLD_ROOT)include/Makefile-post.mk
else
  $(error "Missing environment variable BLD_ROOT - see utalm-bash-API(3)")
endif
