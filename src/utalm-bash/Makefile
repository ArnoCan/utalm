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
SRC_POOL = $(ROOT_SRC_POOL)  src examples tests doc dist
LNK_POOL =  
OUTDIRS  += $(TGZ_ROOT)

.PHONY: $(SRC_POOL) 

all: outdirs  $(SRC_POOL)
rt: src

dist:
	@echo
	@echo "###"
	@echo "#Change to:$@"
	cd $@&&$(MAKE) $(MFLAGS)
	@echo "#...finished:$@"

pkg:tgz rpm
pkg-devel:tgz-devel rpm-devel
pkg-src:srctgz srcrpm
rpm-src:srcrpm
tgz-src :srctgz
targz:tgz
git tgz srctgz tgz-devel srcrpm rpm-devel rpm: $(ENVFILES) outdirs
	@echo
	@echo "###"
	@echo "#Change to:$@"
	cd dist&&$(MAKE) $(MFLAGS) $@
	@echo "#...finished:$@"

src examples tests doc: $(ENVFILES) outdirs
	@echo
	@echo "###"
	@echo "#Change to:$@"
	cd $@&&$(MAKE) $(MFLAGS)
	@echo "#...finished:$@"


test: outdirs $(ENVFILES)
	@echo
	@echo "###"
	@echo "#Change to:$@"
	cd tests&&$(MAKE) $(MFLAGS) test
	@echo "#...finished:$@"


include $(BLD_ROOT)include/Makefile-rules.mk
include $(BLD_ROOT)include/Makefile-post.mk
