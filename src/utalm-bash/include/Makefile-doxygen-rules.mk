#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-python
#LICENCE:      Apache-2.0
#VERSION:      03_02_003
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

#proxy only
ifndef _DOXYGEN_INCLUDED_
_DOXYGEN_INCLUDED_:=1

DOXYGENINCLUDE=$(shell X=$(BLD_ROOT)lib/Makefile.lib/Makefile-doxygen-rules.mk;if [ -e $$X ];then echo $$X; \
    else  X=$(BLD_ROOT)src/lib/Makefile.lib/Makefile-doxygen-rules.mk;if [ -e $$X ];then echo $$X;  \
       else  X=$(HOME)/lib/Makefile.lib/Makefile-doxygen-rules.mk;if [ -e $$X ];then echo $$X;      \
       fi; \
    fi; \
fi;)
ifndef DOXYGENINCLUDE
$(error "Missing DOXYGENINCLUDE")
endif
include $(DOXYGENINCLUDE)
ifndef _DOXYGEN_RULES_INCLUDED_
$(error "Missing: Makefile-doxygen-rules.mk -> " $(DOXYGENINCLUDE))
endif

endif #_DOXYGEN_INCLUDED_
