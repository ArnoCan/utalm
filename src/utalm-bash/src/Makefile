#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENSE:      Apache-2.0 + CCL-BY-SA-3.0
#VERSION:      03_03_001
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
ifdef BLD_ROOT
  include $(BLD_ROOT)include/Makefile-pre.mk
else
  $(error "Missing environment variable BLD_ROOT - see utalm-bash-API(3)")
endif


SRC_FILES = 
SRC_DIRS =

SRC_FILES += README.txt 

SRC_DIRS += bin
SRC_DIRS += conf
SRC_DIRS += lib

OUTDIRS += $(RTBASE)/bin
OUTDIRS += $(RTBASE)/conf
OUTDIRS += $(RTBASE)/lib

.PHONY: $(SRC_DIRS) stripped

all: outdirs $(SRC_FILES) $(SRC_DIRS) stripped

stripped: $(SRC_FILES) $(SRC_DIRS) 
	$(BLD_ROOT)/src/bin/strip-bash.sh DROPLINES -o $(RTBASE)bin $(RTBASE)bin/strip-bash.sh
	$(BLD_ROOT)/src/bin/strip-bash.sh DROPLINES -o $(RTBASE)lib $(RTBASE)lib/libutalm.sh
	$(BLD_ROOT)/src/bin/strip-bash.sh DROPLINES -o $(RTBASE)lib $(RTBASE)lib/libutalm.awk
	$(BLD_ROOT)/src/bin/strip-bash.sh DROPLINES -o $(RTBASE)lib $(RTBASE)lib/libutalmfileobjects.sh
	$(BLD_ROOT)/src/bin/strip-bash.sh DROPLINES -o $(RTBASE)lib $(RTBASE)lib/libutalmrefpersistency.sh

$(SRC_FILES):
ifdef DBG
	@echo "Copy $@"
endif
	@$(CPA) $@ $(RTBASE)

$(SRC_DIRS):
ifdef DBG
	@echo "Copy $@"
endif
	@$(CPA) $@ $(RTBASE)

include $(BLD_ROOT)include/Makefile-post.mk
