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
pkg-devel rpm-devel:all
ifndef BLD_ROOT
  BLD_ROOT := $(dir $(shell pwd))/
endif
ifdef BLD_ROOT
  include $(BLD_ROOT)include/Makefile-pre.mk
else
  $(error "Missing environment variable BLD_ROOT")
endif
################################################################

SRC_POOL =
OUTFILES = 

RPM_OPTS = -bb --buildroot=$(RPMDEVELBLD)/bldroot --target=$(ARCH)
RPM_OPTS += --define "%_topdir $(RPMDEVELBLD)/redhat"
RPM_OPTS += --define "%_sourcedir $(VARIANT_ROOT)"
#
RPM_OPTS += --define "mytgzname    ${TGZ_DEVEL_NAME}"
RPM_OPTS += --define "mytgzpname   ${TGZ_DEVEL_PNAME}"
RPM_OPTS += --define "myversion    ${VERSION}"
RPM_OPTS += --define "myvariant    ${VARIANT}"
RPM_OPTS += --define "mylicense    ${LICENSE}"
RPM_OPTS += --define "myproject    ${PROJECT}"
RPM_OPTS += --define "myname       ${PACKAGE}-devel"
RPM_OPTS += --define "myvendor     \'${VENDOR}\'"
RPM_OPTS += --define "mypackager   \'${PACKAGER}\'"
RPM_OPTS += --define "myurl        '${WWW_PROJ}'"
 
ifeq ($(VARIANT),ALL)
OUTFILES += $(RPMDEVEL_PNAME)
RPM_OPTS += --define "myrelease    ${RELEASE}_${VARIANT}"
endif
ifeq ($(VARIANT),INTERNAL)
OUTFILES += $(RPMDEVEL_PNAME)
RPM_OPTS += --define "myrelease    ${RELEASE}_${VARIANT}"
endif

ifeq ($(VARIANT),SUPPORT)
OUTFILES += $(RPMDEVEL_PNAME)
RPM_OPTS += --define "myrelease    ${RELEASE}_${VARIANT}"
endif

ifeq ($(VARIANT),RELEASE)
OUTFILES += $(RPMDEVEL_PNAME)
RPM_OPTS += --define "myrelease    ${RELEASE}"
endif
ifeq ($(VARIANT),NIGHTLY)
OUTFILES += $(RPMDEVEL_PNAME)
RPM_OPTS += --define "myrelease    ${RELEASE}_${VARIANT}"
endif

RPMDIRS =  $(foreach X, BUILD SOURCES SRPMS SPECS RPMS, $(RPMDEVELBLD)/redhat/$(X))
RPMDIRS += $(foreach X, noarch i386 x86_64, $(RPMDEVELBLD)/redhat/RPMS/$(X))
OUTDIRS += $(RPMDIRS)

ifndef DBG
RPM_OPTS += --quiet
endif


all: outdirs $(OUTFILES)  
pkg:$(OUTFILES)

#
################################################
#
#
$(RPMDEVEL_PNAME): $(RPMDEVEL_PNAME_BLD) 
	@$(ECHO) "#"
	@$(ECHO) "Copy RPMDEVEL to $@"
	@$(CPA) $(RPMDEVEL_PNAME_BLD) $@

$(RPMDEVEL_PNAME_BLD): $(RPMDEVEL_SPECPATH) $(TGZ_DEVEL_PNAME_BLD)
	@$(ECHO) "#"
ifdef DBG
	@$(ECHO) "##########################################################################################"
	@$(ECHO) "#"
endif
	@$(ECHO) "Create RPM-devel-all-archive:$@"
ifdef DBG
	@$(ECHO) 
	@$(ECHO) RPMDEVEL_SPECPATH=$(RPMDEVEL_SPECPATH)
	@$(ECHO) 
	@$(ECHO) TGZ_DEVEL_PNAME=$(TGZ_DEVEL_PNAME)
	@$(ECHO) 
	@$(ECHO) TGZ_DEVEL_PNAME_BLD=$(TGZ_DEVEL_PNAME_BLD)
	@$(ECHO) 
	@$(ECHO) "$(RPMBUILD) $(RPM_OPTS) $(RPMDEVEL_SPECPATH)"
endif
	@$(RPMBUILD) $(RPM_OPTS) $(RPMDEVEL_SPECPATH) 

RPMDEVELDIRS: 
	$(ECHO) "Create redhat-rpm-devel-directories"
	$(MKDIR) $(RPMDEVELBLD)/redhat/{BUILD,SOURCES,SRPMS,SPECS,RPMS} 
	$(MKDIR) $(RPMDEVELBLD)/redhat/RPMS/{noarch,i386,x86_64} 

$(RPMDEVEL_SPECPATH): $(RPMDEVEL_SPECNAME)
	@$(CPA) $(RPMDEVEL_SPECNAME) $@

$(RPMDEVEL_SPECNAME):$(TGZ_DEVEL_PNAME_BLD)
$(TGZ_DEVEL_PNAME_BLD): TGZ_DEVEL
	$(ECHO) "Update TGZ_DEVEL in rpm-devel-Tree"
	$(CPA) $(TGZ_DEVEL_PNAME) $(RPMDEVELBLD)/redhat/RPMS/$(ARCH) 

TGZ_DEVEL:
	$(ECHO) "Update TGZ_DEVEL-Tree"
	$(MAKE) -C $(BLD_ROOT)dist/tgz-devel $(MFLAGS)

$(SRC_POOL): $(ENVFILES)
	@echo "###Change to:$@"
	cd $@&& $(MAKE) $(MFLAGS)

.PHONY: PREPMETA 

################################################################
ifdef BLD_ROOT
  include $(BLD_ROOT)include/Makefile-post.mk
else
  $(error "Missing environment variable BLD_ROOT")
endif
