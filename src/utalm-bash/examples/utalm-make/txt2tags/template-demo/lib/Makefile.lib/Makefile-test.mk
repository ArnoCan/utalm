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
## @file
## @ingroup tagstemplateDemo
## @brief Implements the Nodeaction "test", refer to "Makefile-nodewalk.mk"
##
## Implements the action test for performing unit and regression tests
## on slim utilitilies.
##
## \cond
##
ifndef _MAKE_TEST_INCLUDED_
_MAKE_TEST_INCLUDED_:=1

ifndef TEST_DIRS 
TEST_DIRS = $(shell ls * 2>/dev/null|sed -n 's/\([^:]*\):/\1/p')
endif
TEST_MASKED = $(addprefix test_,$(TEST_DIRS))
.PHONY:$(TEST_MASKED) $(subst test_,,$(TEST_MASKED))
CALLTEST = $(shell ls CallCase.* 2>/dev/null)
ifndef CALLTESTOPTS
CALLTESTOPTS=-d L:0,W:0,I:0 
endif

ifndef OUTLANG 
OUTLANG=en 
endif

ifndef TESTCALLER 
TESTCALLER=bash 
endif

test: calltest
unit unittests: callunit

export BLD_ROOT
export OUTLANG

calltest: $(TEST_DIRS)
ifdef DBG
	if [ -e "$(CALLTEST)" ];then \
		$(ECHO) "$(INDENT1)Call test:$(CALLTEST)" \
	else \
		$(ECHO) "$(INDENT1)No test cases in current directory:$$PWD"; \
	fi
endif
	#Do the redirect on stdout and stderr seperate - for selective post-filtering .
	if [ -e "$(CALLTEST)" ];then \
		{ INDENT0="   $(INDENT0)" INDENT1="   $(INDENT1)"   CURSUBPATH=$(CURSUBPATH)/$(subst test_,,$@) $(TESTCALLER) $(CALLTEST) $(CALLTESTOPTS) | awk -v indent="${INDENT1}" '{print indent $$0}' ; } 3>&2 2>&1 1>&3 |awk -v indent="${INDENT1}" '{print indent $$0}'  >&2 ;\
	fi


callunit: $(TEST_DIRS)
ifdef DBG
	if [ -e "$(CALLTEST)" ];then \
		$(ECHO) "$(INDENT1)Call test:$(CALLTEST)" \
	else \
		$(ECHO) "$(INDENT1)No test cases in current directory:$$PWD"; \
	fi
endif
	#Do the redirect on stdout and stderr seperate - for selective post-filtering .
	if [ -e "$(CALLTEST)" ];then \
		{ UNITTEST=$(UNITTEST) INDENT0="   $(INDENT0)" INDENT1="   $(INDENT1)"   CURSUBPATH=$(CURSUBPATH)/$(subst test_,,$@) $(TESTCALLER) $(CALLTEST)  | awk -v indent="${INDENT1}" '{print indent $$0}' ; } 3>&2 2>&1 1>&3 |awk -v indent="${INDENT1}" '{print indent $$0}'  >&2 ;\
	fi |\
	countErrors.sh; 

#.PHONY: test calltest 

endif #_MAKE_TEST_INCLUDED_ 
## \endcond
