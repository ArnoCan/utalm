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
#
# Nodewalk is an abstract make module, which navigates downward thres a
# inverted treestructure, passing each branch and touching each leaf once. 
# The path resolution is from left first, downward from leftmost first.
# Thus the order of reachin terminating leafs and executing the foreseen 
# action is the lowest level of the leftmost subtree first, following the
# next lowest level, and so on. Each subtree is finalised by performing 
# actions on their intersetion point.  
#
#
#

ifndef _MAKE_NODEWALK_INCLUDED_
_MAKE_NODEWALK_INCLUDED_:=1

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
$(error "Missing environment variable BLD_ROOT")
endif #BLD_ROOT

ifndef SUBROOTTOP
$(error "Missing environment variable SUBROOTTOP - basename of a valid sub tree of BLD_ROOT")
endif

#
CURSUBPATH := $(subst $(BLD_ROOT),,$(shell pwd))
.PHONY:CURSUBPATH

TARGETBASE=
ifeq ($(SUBROOTTOP),doc)
TARGETBASE=$(DOCVARIANT)
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
TARGET_DIRS += $(addprefix $(TARGETBASE)/,$(addprefix $(CURSUBPATH)/,$(UNIQUE_DIRS)))
TARGET_FILES += $(addprefix $(TARGETBASE)/,$(addprefix $(CURSUBPATH)/,$(UNIQUE_FILES)))
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
$(TARGET_DIRS): $(UNIQUE_DIRS)
ifdef DBG
	$(ECHO) "$(INDENT1)IMPORT-DIRS:$@"	
	$(ECHO) "$(INDENT1)$(CPA) $? $(TARGETBASE)/$(CURSUBPATH)"
endif
	$(MKDIR) $(TARGETBASE)/$(CURSUBPATH)
	$(CPA) $? $(TARGETBASE)/$(CURSUBPATH)

$(TARGET_FILES):$(UNIQUE_FILES)
ifdef DBG
	$(ECHO) "$(INDENT1)IMPORT-FILES:$@"
	$(ECHO) "$(INDENT1)$(CPA) $? $(TARGETBASE)/$(CURSUBPATH)"
endif
	$(CPA) $? $(TARGETBASE)/$(CURSUBPATH)

else
_forward_test_all: all
endif #NODEACTIONONLY

$(SUB_POOLS):
ifdef DEBUG 
	@$(ECHO) "$(INDENT0)###################################"
	@$(ECHO) "$(INDENT1)#Change to:$(CURSUBPATH)/$@"
	@$(ECHO) "$(INDENT1)#INDENT0="   $(INDENT0)" INDENT1="   $(INDENT1)" BLD_ROOT=$(BLD_ROOT) OUTLANG=$(OUTLANG) SUBROOTTOP=$(SUBROOTTOP) CURSUBPATH=$(CURSUBPATH)/$@ $(MAKE) -C $@ $(MFLAGS) $(MAKECMDGOALS)"
else
	@$(ECHO) "$(INDENT0)#Change to:$(CURSUBPATH)/$@"
endif	
	INDENT0="   $(INDENT0)" INDENT1="   $(INDENT1)" BLD_ROOT=$(BLD_ROOT) OUTLANG=$(OUTLANG) SUBROOTTOP=$(SUBROOTTOP) CURSUBPATH=$(CURSUBPATH)/$@ $(MAKE) -C $@ $(MFLAGS) $(MAKECMDGOALS)
	@$(ECHO) "$(INDENT1)#...return from $(CURSUBPATH)/$@($$?)"

include $(BLD_ROOT)include/Makefile-post.mk

endif #_MAKE_NODEWALK_INCLUDED_