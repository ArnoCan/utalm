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
OUTLANG:=en
DOC_BLD_ROOT:=$(BLD_ROOT)docsrc/

ifdef DOC_BLD_ROOT
  include $(DOC_BLD_ROOT)include/Makefile-pre.mk
else
  $(error "Missing environment variable BLD_ROOT - see utalm-bash-API(3)")
endif

SRC_POOL        =  
SRC_POOL        +=  images
SRC_POOL        +=  txt2tags-demo



.PHONY: $(SRC_POOL) css js
all: outdirs css js $(SRC_POOL)

$(SRC_POOL): $(ENVFILES)
	@echo "###Change to:$@"
	cd $@&& BLD_ROOT=$(BLD_ROOT) DOC_BLD_ROOT=$(DOC_BLD_ROOT) OUTLANG=$(OUTLANG) $(MAKE) $(MFLAGS)
	@echo "...return from $@"

css js:
ifdef DBG
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
