#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-python
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

#proxy only
ifndef _TEST_INCLUDED_
_TEST_INCLUDED_:=1

ifndef BLD_ROOT
$(error "Missing BLD_ROOT")
endif

TESTINCLUDE=$(shell X=$(BLD_ROOT)lib/Makefile.lib/Makefile-test.mk;if [ -e $$X ];then echo $$X; \
    else  X=$(BLD_ROOT)src/lib/Makefile.lib/Makefile-test.mk;if [ -e $$X ];then echo $$X;  \
       else  X=$(HOME)/lib/Makefile.lib/Makefile-test.mk;if [ -e $$X ];then echo $$X;      \
       fi; \
    fi; \
fi;)
ifndef TESTINCLUDE
$(error "Missing TESTINCLUDE")
endif
include $(TESTINCLUDE)
ifndef _MAKE_TEST_INCLUDED_
$(error "Missing: Makefile-test.mk -> " $(_MAKE_TEST_INCLUDED_))
endif

endif #_TEST_INCLUDED_
