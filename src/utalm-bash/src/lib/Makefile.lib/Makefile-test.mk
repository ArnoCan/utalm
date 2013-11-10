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
## @brief Implements the Nodeaction for "test", "testref",and "unit"
##
## Implements the Nodeaction "test", refer to \ref Makefile-nodewalk.mk,
## and \ref Nodeaction-test.sh. Implements the action test for performing unit
## and regression tests on slim utilitilies.
##
## **TESTMODE** controls the control flow by follwing values:
## * CREATEREF
##   Creates and stores persistent reference data.
## * TEST
##   Performs simple test call with standard display for each case.
## * UNIT
##   Performs unit tests, where the whole subtree of current call
##   postion in filesystem is handled as one test case.
##
## @ingroup libutalm_make
## \cond
##
ifndef _MAKE_TEST_INCLUDED_
_MAKE_TEST_INCLUDED_:=1

ifndef MAKE_VERSION
$(error "requires GNUmake")
endif

## \endcond
## TEST_DIRS
#
# Call for test case.
#P TEST_DIRS = $(shell ls * 2>/dev/null|sed -n 's/\([^:]*\):/\1/p')
## \cond
ifndef TEST_DIRS 
TEST_DIRS = $(shell ls * 2>/dev/null|sed -n 's/\([^:]*\):/\1/p')
endif
.PHONY:$(TEST_DIRS)

TEST_MASKED = $(addprefix test_,$(TEST_DIRS))
.PHONY:$(TEST_MASKED) $(subst test_,,$(TEST_MASKED))

## \endcond
## CALLTEST
#
# Call for test case.
#P CALLTEST="$(shell ls CallCase.* 2>/dev/null)"
## \cond
ifndef CALLTEST
CALLTEST = $(shell ls CallCase.* 2>/dev/null)
endif

ifndef CALLTESTREF
CALLTESTREF = $(shell ls CallCase .* 2>/dev/null)
endif

## \endcond
## CALLTESTOPTS
#
# Options for CALLTEST
#P CALLTESTOPTS=-d L:0,W:0,I:0
## \cond
ifndef CALLTESTOPTS
CALLTESTOPTS=-d L:0,W:0,I:0 
endif

ifndef OUTLANG 
OUTLANG=en 
endif

## \endcond
## TESTCALLER
#
# Wrapper for test calls by CALLTEST
#P TESTCALLER=bash
## \cond
ifndef TESTCALLER 
TESTCALLER=bash 
endif

help-test:
	echo "HELP"

testref testdata: calltestref

test: calltest
unit unittests: callunit

export BLD_ROOT
export OUTLANG

#
###
#
ifeq ($(CALLTEST),CallCase.sh)
calltest: $(CALLTEST)
ifdef DBG
	if [ -e "$(CALLTEST)" ];then \
		$(ECHO) "$(INDENT1)Call test:$$PWD/$(CALLTEST) $(CALLTESTOPTS)"; \
	else \
		$(ECHO) "$(INDENT1)No test cases in current directory:$$PWD"; \
	fi
endif
	if [ -e "$(CALLTEST)" ];then \
			{ INDENT0="   $(INDENT0)" INDENT1="   $(INDENT1)"   TEST_DIRS="$(TEST_DIRS)" CURSUBPATH=$(CURSUBPATH) $(TESTCALLER) $(CALLTEST)  $(CALLTESTOPTS) | awk -v indent="${INDENT1}" '{print indent $$0}' ; } 3>&2 2>&1 1>&3 |awk -v indent="${INDENT1}" '{print indent $$0}'  >&2 ; \
	fi
else
calltest: $(TEST_DIRS)
ifdef DBG
	if [ -e "$(CALLTEST)" ];then \
		$(ECHO) "$(INDENT1)Call test:$(CALLTEST) $(CALLTESTOPTS)"; \
	else \
		$(ECHO) "$(INDENT1)No test cases in current directory:$$PWD"; \
	fi
endif
	if [ -e "$(CALLTEST)" ];then \
		{ INDENT0="   $(INDENT0)" INDENT1="   $(INDENT1)"   CURSUBPATH=$(CURSUBPATH)/$(subst test_,,$@) $(TESTCALLER) $(CALLTEST)  $(CALLTESTOPTS) | awk -v indent="${INDENT1}" '{print indent $$0}' ; } 3>&2 2>&1 1>&3 |awk -v indent="${INDENT1}" '{print indent $$0}'  >&2 ;\
	fi
endif


#
###
#
ifeq ($(CALLTEST),CallCase.sh)
calltestref: $(CALLTEST)
ifdef DBG
	if [ -e "$(CALLTEST)" ];then \
		$(ECHO) "$(INDENT1)Call test:$$PWD/$(CALLTEST) $(CALLTESTOPTS)"; \
	else \
		$(ECHO) "$(INDENT1)No test cases in current directory:$$PWD"; \
	fi
endif
	if [ -e "$(CALLTEST)" ];then \
			{ TESTMODE=CREATEREF INDENT0="   $(INDENT0)" INDENT1="   $(INDENT1)"   TEST_DIRS="$(TEST_DIRS)" CURSUBPATH=$(CURSUBPATH) $(TESTCALLER) $(CALLTEST)  $(CALLTESTOPTS) | awk -v indent="${INDENT1}" '{print indent $$0}' ; } 3>&2 2>&1 1>&3 |awk -v indent="${INDENT1}" '{print indent $$0}'  >&2 ; \
	fi
else
calltestref: $(TEST_DIRS)
ifdef DBG
	if [ -e "$(CALLTEST)" ];then \
		$(ECHO) "$(INDENT1)Call test:$(CALLTEST) $(CALLTESTOPTS)"; \
	else \
		$(ECHO) "$(INDENT1)No test cases in current directory:$$PWD"; \
	fi
endif
	if [ -e "$(CALLTEST)" ];then \
		{ TESTMODE=CREATEREF INDENT0="   $(INDENT0)" INDENT1="   $(INDENT1)"   CURSUBPATH=$(CURSUBPATH)/$(subst test_,,$@) $(TESTCALLER) $(CALLTEST)  $(CALLTESTOPTS) | awk -v indent="${INDENT1}" '{print indent $$0}' ; } 3>&2 2>&1 1>&3 |awk -v indent="${INDENT1}" '{print indent $$0}'  >&2 ;\
	fi
endif


#
###
#
## \endcond
## UNIT_CALLTESTOPTS
#
# Options for CALLTEST
#P UNIT_CALLTESTOPTS="-d out:1,i:0"
## \cond
ifndef UNIT_CALLTESTOPTS
UNIT_CALLTESTOPTS="-d out:1,i:0"
endif

## \endcond
## UNIT_COUNTERRORS_OPTS
#
# Options for \ref countErrors.sh
#P UNIT_COUNTERRORS_OPTS="filter=1 sums=1 flat=1"
## \cond
ifndef UNIT_COUNTERRORS_OPTS
UNIT_COUNTERRORS_OPTS="filter=1 sums=1 flat=1"
endif

ifeq ($(CALLTEST),CallCase.sh)
callunit:  
ifdef DBG
	{ \
	if [ -e "$(CALLTEST)" ];then \
		$(ECHO) "$(INDENT1)Call test:$$PWD/$(CALLTEST) $(CALLTESTOPTS)"; \
	else \
		$(ECHO) "$(INDENT1)No test cases in current directory:$$PWD"; \
	fi ; \
	if [ -e "$(CALLTEST)" ];then \
		{ DBG=1 INDENT0="   $(INDENT0)" INDENT1="   $(INDENT1)"   TEST_DIRS="$(TEST_DIRS)" CURSUBPATH=$(CURSUBPATH)/$(subst test_,,$@) $(TESTCALLER) $(CALLTEST)  $(CALLTESTOPTS) | awk -v indent="${INDENT1}" '{print indent $$0}' ; } 3>&2 2>&1 1>&3 |awk -v indent="${INDENT1}" '{print indent $$0}'  >&2 ;\
	fi ;\
	} 2>&1|countErrors.sh $(UNIT_COUNTERRORS_OPTS)
else
	{ \
	if [ -e "$(CALLTEST)" ];then \
		{ DBG=1 INDENT0="   $(INDENT0)" INDENT1="   $(INDENT1)"   TEST_DIRS="$(TEST_DIRS)" CURSUBPATH=$(CURSUBPATH)/$(subst test_,,$@) $(TESTCALLER) $(CALLTEST)  $(CALLTESTOPTS) | awk -v indent="${INDENT1}" '{print indent $$0}' ; } 3>&2 2>&1 1>&3 |awk -v indent="${INDENT1}" '{print indent $$0}'  >&2 ;\
	fi ;\
	} 2>&1|countErrors.sh $(UNIT_COUNTERRORS_OPTS)
endif
else
callunit:
	DBG=1 
	{ \
	for d in $(TEST_DIRS);do \
		if [ -e "$$d" ];then \
			$(ECHO) "$(INDENT1)Change to:$$d"; \
		else \
			$(ECHO) "$(INDENT1)No test cases in current directory:$$PWD"; \
		fi ; \
		{ DBG=1 UNIT_COUNTERRORS_OPTS="$(UNIT_COUNTERRORS_OPTS)"  INDENT0="   $(INDENT0)" INDENT1="   $(INDENT1)"   CURSUBPATH=$(CURSUBPATH)/$(subst test_,,$@) BLD_ROOT=$(BLD_ROOT) OUTLANG=$(OUTLANG) SUBROOTTOP=$(SUBROOTTOP)  $(MAKE) -C $$d $(MFLAGS) $(MAKECMDGOALS) | awk -v indent="${INDENT1}" '{print indent $$0}' ; } 3>&2 2>&1 1>&3 |awk -v indent="${INDENT1}" '{print indent $$0}'  >&2 ;\
		  $(ECHO) "$(INDENT1)return from:$$d"; \
	done ; \
	} 2>&1|countErrors.sh $(UNIT_COUNTERRORS_OPTS)
endif


#.PHONY: test calltest 

endif #_MAKE_TEST_INCLUDED_ 
## \endcond
