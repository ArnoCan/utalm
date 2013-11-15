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


all: outdirs repopub 
#
################################################
#
#
repopub: 
	@$(ECHO) "#######"
	@$(ECHO) "#"
	@$(ECHO) "# Unpack SRCTGZ:$(SRCTGZ_PNAME)"
	@$(ECHO) "# to:$(GITTREE_ROOT)"
	@$(ECHO) "#"
	cd $(BLD_ROOT)dist/srctgz&& $(MAKE) $(MFLAGS)
	@$(MKDIR) $(GITTREE_ROOT)
	$(CP) -a $(SRCTGZ_ROOT)/* $(GITTREE_ROOT)

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
	@echo "  - extracts to export directory for literal copy into"
	@echo "    the local archive directory of public repository"
	@echo "    EXPORT_DIR = $(EXPORT_DIR)"
	@echo
	@echo "  make helpglobal"
	@echo "  - displays global help"
	@echo


################################################################
ifdef BLD_ROOT
  include $(BLD_ROOT)include/Makefile-post.mk
else
  $(error "Missing environment variable BLD_ROOT - see utalm-bash-API(3)")
endif
