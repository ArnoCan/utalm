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
ifndef OUTLANG
	OUTLANG=$(CALLDIRNAME)
endif
ifndef OUTLANG
  	$(error "Missing environment variable OUTLANG")
endif
ifdef DOC_BLD_ROOT
	include $(DOC_BLD_ROOT)$(OUTLANG)/include/Makefile-pre.mk
else
  $(error "Missing environment variable DOC_BLD_ROOT")
endif
SRC_POOL        =  
SRC_POOL        +=  images
SRC_POOL        +=  libutalm-bash 
#SRC_POOL        +=  libutalm-bash-examples 


.PHONY: $(SRC_POOL) css js
all: css js $(SRC_POOL)

$(SRC_POOL): $(ENVFILES)
	@echo "###Change to:$@"
	cd $@&& BLD_ROOT=$(BLD_ROOT) DOC_BLD_ROOT=$(DOC_BLD_ROOT) OUTLANG=$(OUTLANG) $(MAKE) $(MFLAGS)
	@echo "...return from $@"

css js:
ifdef VERBOSE
	@echo "##Copy:$@"
endif
	$(CPA) $@   $(DOCBASE)

#
include $(BLD_ROOT)include/Makefile-rules.mk
#
#######################################################
#
include $(BLD_ROOT)include/Makefile-post.mk
#