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
ifndef OUTLANG
  $(error "Missing environment variable OUTLANG")
endif
ifdef DOC_BLD_ROOT
  include $(DOC_BLD_ROOT)$(OUTLANG)/include/Makefile-pre.mk
else
  $(error "Missing environment variable DOC_BLD_ROOT")
endif

SRC_POOL        =  

IN_POOL        	=  $(wildcard *.png) $(wildcard *.eps)

#
#Quick and dirty for now:
#
#-> Latex does not reconise by default the several image-paths, just done some
#   tricks for Releasenotes, any how not the broad.
#-> Due to generation variants these might change for each build, even worst
#   within one big-parallel make for each thread
#
#
#Current workaround:
#
# Multiple copies by Make from one source at least:
#
#  1. For latex/txt2tags:
#     Generic common position
#
#  2. For HTML-Quick-Previews and Packaging
#     In each VARIANT pool of the meta-build-pool
#     and in addition into the target production pool.
#
#
#

#
#Meta-build for latex/txt2tags
OUT_POOL1	=  $(addprefix $(OUTIMGTMP)/,$(basename $(IN_POOL)))
OUT_POOL	=  $(addsuffix .png,$(OUT_POOL1))
OUT_POOL	+=  $(addsuffix .pdf,$(OUT_POOL1))

#
#production pool for each variant
BLD_SRC 	=  $(wildcard *.png) 
BLD_POOL0	=  $(addprefix $(OUTIMGDOCLANG)/,$(basename $(BLD_SRC)))
BLD_POOL	=  $(addsuffix .png,$(BLD_POOL0))

all: outdirs $(OUT_POOL) $(BLD_POOL) 
outdirs:$(OUTDIRS)

$(BLD_POOL): $(OUTIMGDOCLANG)
ifdef DBG
	$(ECHO) "Copy:"
	$(ECHO) "  from:$(OUTIMGTMP)/$(@F)"
	$(ECHO) "  to:  $(OUTIMGDOCLANG)"
endif
ifeq ($(OUTLANG),en)
	$(CP) $(OUTIMGTMP)/$(@F) $(OUTIMGDOCLANG)
	chmod 755 $(OUTIMGDOCLANG)/$(@F)
endif

$(OUT_POOL): $(IN_POOL)
ifdef DBG
	$(ECHO) "Convert:"
	$(ECHO) "  from:$(notdir $@)"
endif
ifeq ($(OUTLANG),en)
	BLD_ROOT=$(BLD_ROOT) OUTIMG=$(OUTIMGTMP) bash convertGraphics.sh $(notdir $@)
endif

$(IN_POOL): $(ENVFILES)


ifeq ($(OUTLANG),en)
UNIQUE_BLD_DIRS:=$(shell if [ "$(BLD_IMG)" != "$(OUTIMGDOCLANG)" ];then echo $$i;fi)
$(UNIQUE_BLD_DIRS):
	$(MKDIR) $@
else
$(BLD_IMG):
	$(MKDIR) $@

$(OUTIMGDOCLANG):
	$(LNS) ../en/images  $(DOCBASE)
endif

ifdef DOC_BLD_ROOT
  include $(BLD_ROOT)include/Makefile-post.mk
else
  $(error "Missing environment variable DOC_BLD_ROOT")
endif



