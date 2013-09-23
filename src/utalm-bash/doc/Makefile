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

DOC_BLD_ROOT := $(shell pwd)
BLD_ROOT := $(dir $(DOC_BLD_ROOT))
DOC_BLD_ROOT := $(DOC_BLD_ROOT)/

ifdef DOC_BLD_ROOT
  include $(DOC_BLD_ROOT)include/Makefile-pre.mk
else
  $(error "Missing environment variable BLD_ROOT")
endif

SRC_POOL        =  images js css $(OUTLANGLST) 

.PHONY: $(SRC_POOL)  

all:  outdirs $(SRC_POOL) 

$(OUTLANGLST): $(ENVFILES)
	@echo "###################################"
	@echo "##Change to LANG:$@"
	cd $@&&BLD_ROOT=$(BLD_ROOT) DOC_BLD_ROOT=$(DOC_BLD_ROOT) OUTLANG=$@ $(MAKE) $(MFLAGS)
	@echo "##...return from $@"

images: 
	@echo "##Change to:$@"
	cd $@&& BLD_ROOT=$(BLD_ROOT) DOC_BLD_ROOT=$(DOC_BLD_ROOT) $(MAKE) $(MFLAGS)
	@echo "##...return from $@"

css js:
ifdef VERBOSE
	@echo "##Copy:$@"
endif
	$(CPA) $@   $(DOCBASE_ML)

#
include $(BLD_ROOT)include/Makefile-rules.mk
#
#######################################################
#
include $(BLD_ROOT)include/Makefile-post.mk
#
