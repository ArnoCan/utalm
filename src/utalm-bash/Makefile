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
BLD_ROOT := $(shell pwd)
BLD_ROOT := $(BLD_ROOT)/
DOC_BLD_ROOT := $(BLD_ROOT)

ifdef BLD_ROOT
  include $(BLD_ROOT)include/Makefile-pre.mk
else
  $(error "Missing environment variable BLD_ROOT append a '/'")
endif

ifndef DOC_BLD_ROOT
  $(error "Missing environment variable DOC_BLD_ROOT append a '/'")
endif

#SRC_POOL = $(ROOT_SRC_POOL)  src doc tgz rpm
SRC_POOL = $(ROOT_SRC_POOL)  src doc dist
LNK_POOL =  
OUTDIRS  += $(TGZ_ROOT)

.PHONY: $(SRC_POOL) 

all: outdirs  $(SRC_POOL)
rt: src
rpm: $(ENVFILES) outdirs
	@echo
	@echo "###"
	@echo "#Change to:$@"
	cd dist&&$(MAKE) $(MFLAGS) rpm
	@echo "#...finished:$@"

targz:tgz
tgz: outdirs  $(ENVFILES)
	@echo
	@echo "###"
	@echo "#Change to:$@"
	cd dist&&$(MAKE) $(MFLAGS) tgz
	@echo "#...finished:$@"

dist:
	@echo
	@echo "###"
	@echo "#Change to:$@"
	cd $@&&$(MAKE) $(MFLAGS)
	@echo "#...finished:$@"

doc: outdirs $(ENVFILES)
	@echo
	@echo "###"
	@echo "#Change to:$@"
	cd $@&&$(MAKE) $(MFLAGS)
	@echo "#...finished:$@"

src: outdirs $(ENVFILES)
	@echo
	@echo "###"
	@echo "#Change to:$@"
	cd $@&&export PATH=$(PATH):$(BLD_ROOT)/src/bin&& $(MAKE) $(MFLAGS)
	export PATH=$(PATH):$(BLD_ROOT)/src/bin&&export VERBOSE=$(VERBOSE)&&export INSTROOT=$(TGZ_ROOT)&&./install.sh >&2
	@echo "#...finished:$@"

include $(BLD_ROOT)include/Makefile-rules.mk
include $(BLD_ROOT)include/Makefile-post.mk
