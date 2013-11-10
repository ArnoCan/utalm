## \cond
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-make
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
##
## \endcond
##
## @file
## @brief Makefile for parsing and performing actions on directory-trees
##
## A Makefile for parsing and performing actions on directory-trees.
## This includes default action for collection of contents defined
## by included lists. These are collected to a meta-pool for actual 
## pre-assembling and production of the target configuration.
## cross-dependencies are worked out in a 2-level-approach.
##
## Nodewalk is therefore an abstract make module, which navigates downward
## trees in an inverted treestructure, passing each branch and touching each
## leaf once. The path resolution is from left first, downward from leftmost
## first. Thus the order of entering terminating leafs and executing the 
## foreseen action is for the lowest level on the leftmost subtree first.
## Following the next lowest level, and so on. Each subtree is finalised by
## performing actions on their intersetion point.
##
## The current interface for inclusion is:
##
##	- $(BLD_ROOT)include/Makefile-pre.mk    - mandatory
##	- Makefile-src-en.mk                    - optional
##	- Makefile-nodeaction-en.mk             - optional
##	- $(BLD_ROOT)include/Makefile-post.mk   - mandatory
## 
## This could be customized as required.
## @ingroup libutalm_make
## \cond
##
#
ifndef _MAKE_NODEWALK_INCLUDED_
_MAKE_NODEWALK_INCLUDED_:=1

ifndef MAKE_VERSION
$(error "requires GNUmake")
endif

## \endcond
# \brief Provides sub-help
#
# @ingroup libutalm_make
#
MYHELPTARGETS = help help_test help_utalm
## \cond

ifdef UTALM
$(warning "UTALM:" $(UTALM))
TARGETS=utalm

utalm:
	echo "UTALM-target"
ifdef D
ifeq ($(D),help)
	utalmhelp.sh html&
endif
ifeq ($(D),help:pdf)
	echo epdfview $${HOME}/doc/en/pdf/man3/utalm-make.pdf
	epdfview $${HOME}/doc/en/pdf/man3/utalm-make.pdf&
endif
endif
	

endif
	

X0=$(firstword $(MAKECMDGOALS))
X=$(shell X="$(X0)"&&echo $${X%%:*} )
#
ifneq ($(MYGOAL), help)
ifeq ($(firstword $(X)), help)
MYGOAL=$(shell X="$(MAKECMDGOALS)"&&echo -n $${X// /_})
$(warning "help for:" $(MYGOAL))

ifneq ($(filter $(MYGOAL),$(MYHELPTARGETS)),)
$(warning "help for:" $(MYGOAL))
.PHONY:$(MYGOAL)
_help:$(MYGOAL)
endif
endif
endif
#$(error "")

ifndef INDENT0
INDENT0=+--+>
endif
ifndef INDENT1
INDENT1="\|...."
endif
#
ifdef BLD_ROOT
include $(BLD_ROOT)include/Makefile-pre.mk
else
$(error "Missing environment variable BLD_ROOT - see utalm-bash-API(3)")
endif #BLD_ROOT

#
ifndef CURSUBPATH
ifeq ($(shell pwd)/,$(BLD_ROOT))
CURSUBPATH := 
else
CURSUBPATH := $(subst $(BLD_ROOT),,$(shell pwd))
endif
endif
.PHONY:CURSUBPATH

TARGETBASE=
ifdef SUBROOTTOP
ifeq ($(SUBROOTTOP),doc)
TARGETBASE=$(DOCVARIANT)
else
TARGETBASE=$(RTBASE)$(SUBROOTTOP)/
endif 
else
TARGETBASE=$(RTBASE)
endif 

ifndef TARGETBASE
$(error "Missing environment variable TARGETBASE - root node for output")
endif

###
# IMPORT
SRC_FILES = 
SRC_DIRS =
SUB_POOLS = 
-include  Makefile-src-en.mk
.PHONY:$(SUB_POOLS)
#
###
# APPEND

#
###
# PREPARE
UNIQUE_DIRS:=$(shell for i in ${SRC_DIRS};do echo $$i;done|sort -u)
UNIQUE_FILES:=$(shell for i in ${SRC_FILES};do echo $$i;done|sort -u)
ifeq ($(CURSUBPATH),)
TARGET_DIRS += $(addprefix $(TARGETBASE),$(UNIQUE_DIRS))
TARGET_FILES += $(addprefix $(TARGETBASE),$(UNIQUE_FILES))
else
TARGET_DIRS += $(addprefix $(TARGETBASE),$(addprefix $(CURSUBPATH)/,$(UNIQUE_DIRS)))
TARGET_FILES += $(addprefix $(TARGETBASE),$(addprefix $(CURSUBPATH)/,$(UNIQUE_FILES)))
endif
OUTDIRS += $(dir $(TARGET_FILES))
#
###

forward_test_all:_forward_test_all
.PHONY:forward_test_all _forward_test_all
#
# May define NODEACTIONONLY in order to supress standard actions
#
-include Makefile-nodeaction-en.mk
#
ifndef NODEACTIONONLY
#
# Default is export selected items to intermediate tree
#
_forward_test_all all: outdirs $(SUB_POOLS) $(TARGET_DIRS) $(TARGET_FILES)
dirs:$(TARGET_DIRS)
.PHONY:dirs
$(TARGET_DIRS): $(UNIQUE_DIRS)
ifdef DBG
	$(ECHO) "$(INDENT1)IMPORT-DIRS:$@"	
	$(ECHO) "$(INDENT1)$(CPA) $? $(TARGETBASE)/$(CURSUBPATH)"
endif
	$(MKDIR) $(TARGETBASE)$(CURSUBPATH)
	$(CPA) $? $(TARGETBASE)$(CURSUBPATH)

files:$(TARGET_FILES)
.PHONY:files
$(TARGET_FILES):$(UNIQUE_FILES)
ifdef DBG
	$(ECHO) "$(INDENT1)IMPORT-FILES:$@"
	$(ECHO) "$(INDENT1)$(CPA) $? $(TARGETBASE)/$(CURSUBPATH)"
endif
	$(CPA) $? $(TARGETBASE)/$(CURSUBPATH)

else
_forward_test_all: all
endif #NODEACTIONONLY

subpools:$(SUB_POOLS)
.PHONY:subpools
$(SUB_POOLS):
ifdef DEBUG 
	@$(ECHO) "$(INDENT0)###################################"
	@$(ECHO) "$(INDENT1)#Change to:$(CURSUBPATH)/$@"
	@$(ECHO) "$(INDENT1)#INDENT0="   $(INDENT0)" INDENT1="   $(INDENT1)" BLD_ROOT=$(BLD_ROOT) OUTLANG=$(OUTLANG) SUBROOTTOP=$(SUBROOTTOP) CURSUBPATH=$(CURSUBPATH)/$@ $(MAKE) -C $@ $(MFLAGS) $(MAKECMDGOALS)"
endif
ifndef UNITTEST
	@$(ECHO) "$(INDENT0)#Change to:$(CURSUBPATH)/$@"
endif
	INDENT0="   $(INDENT0)" INDENT1="   $(INDENT1)" BLD_ROOT=$(BLD_ROOT) OUTLANG=$(OUTLANG) SUBROOTTOP=$(SUBROOTTOP) CURSUBPATH=$(CURSUBPATH)/$@ $(MAKE) -C $@ $(MFLAGS) $(MAKECMDGOALS)
ifndef UNITTEST
	@$(ECHO) "$(INDENT1)#...return from:$(CURSUBPATH)/$@($$?)"
endif

include $(BLD_ROOT)include/Makefile-post.mk

endif #_MAKE_NODEWALK_INCLUDED_
## \endcond
