#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENCE:      Apache-2.0
#VERSION:      03_02_001
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
rpm:all
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

RPM_OPTS = -bb --buildroot=$(RPMBLD)/bldroot --target=$(ARCH)
RPM_OPTS += --define "%_topdir $(RPMBLD)/redhat"
RPM_OPTS += --define "%_sourcedir $(VARIANT_ROOT)"
#
RPM_OPTS += --define "mytgzname    ${TGZ_NAME}"
RPM_OPTS += --define "mytgzpname   ${TGZ_PNAME}"
RPM_OPTS += --define "myversion    ${VERSION}"
RPM_OPTS += --define "myvariant    ${VARIANT}"
RPM_OPTS += --define "mylicense    ${LICENSE}"
RPM_OPTS += --define "myproject    ${PROJECT}"
RPM_OPTS += --define "myname       ${PACKAGE}"
RPM_OPTS += --define "myvendor     \'${VENDOR}\'"
RPM_OPTS += --define "mypackager   \'${PACKAGER}\'"
RPM_OPTS += --define "myurl        '${WWW_PROJ}'"
 
ifeq ($(VARIANT),ALL)
OUTFILES += $(RPM_PNAME)
RPM_OPTS += --define "myrelease    ${RELEASE}_${VARIANT}"
endif
ifeq ($(VARIANT),INTERNAL)
OUTFILES += $(RPM_PNAME)
RPM_OPTS += --define "myrelease    ${RELEASE}_${VARIANT}"
endif

ifeq ($(VARIANT),SUPPORT)
OUTFILES += $(RPM_PNAME)
RPM_OPTS += --define "myrelease    ${RELEASE}_${VARIANT}"
endif

ifeq ($(VARIANT),RELEASE)
OUTFILES += $(RPM_PNAME)
RPM_OPTS += --define "myrelease    ${RELEASE}"
endif
ifeq ($(VARIANT),NIGHTLY)
OUTFILES += $(RPM_PNAME)
RPM_OPTS += --define "myrelease    ${RELEASE}_${VARIANT}"
endif

RPMDIRS =  $(foreach X, BUILD SOURCES SRPMS SPECS RPMS, $(RPMBLD)/redhat/$(X))
RPMDIRS += $(foreach X, noarch i386 x86_64, $(RPMBLD)/redhat/RPMS/$(X))
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
$(RPM_PNAME): $(RPM_PNAME_BLD) 
	@$(ECHO) "#"
	@$(ECHO) "Copy RPM to $@"
	@$(CPA) $(RPM_PNAME_BLD) $@

$(RPM_PNAME_BLD): $(RPM_SPECPATH) $(TGZ_PNAME_BLD)
	@$(ECHO) "#"
ifdef DBG
	@$(ECHO) "##########################################################################################"
	@$(ECHO) "#"
endif
	@$(ECHO) "Create RPM-all-archive:$@"
ifdef DBG
	@$(ECHO) 
	@$(ECHO) RPM_SPECPATH=$(RPM_SPECPATH)
	@$(ECHO) 
	@$(ECHO) TGZ_PNAME=$(TGZ_PNAME)
	@$(ECHO) 
	@$(ECHO) TGZ_PNAME_BLD=$(TGZ_PNAME_BLD)
	@$(ECHO) 
	@$(ECHO) "$(RPMBUILD) $(RPM_OPTS) $(RPM_SPECPATH)"
endif
	@$(RPMBUILD) $(RPM_OPTS) $(RPM_SPECPATH) 

RPMDIRS: 
	$(ECHO) "Create redhat-rpm-directories"
	$(MKDIR) $(RPMBLD)/redhat/{BUILD,SOURCES,SRPMS,SPECS,RPMS} 
	$(MKDIR) $(RPMBLD)/redhat/RPMS/{noarch,i386,x86_64} 

$(RPM_SPECPATH): $(RPM_SPECNAME)
	@$(CPA) $(RPM_SPECNAME) $@

$(RPM_SPECNAME):

$(TGZ_PNAME_BLD): TGZ
	$(ECHO) "Update TGZ in rpm-Tree"
	$(CPA) $(TGZ_PNAME) $(RPMBLD)/redhat/RPMS/$(ARCH) 

TGZ:
	$(ECHO) "Update TGZ-Tree"
	$(MAKE) -C $(BLD_ROOT)dist/tgz $(MFLAGS)

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
