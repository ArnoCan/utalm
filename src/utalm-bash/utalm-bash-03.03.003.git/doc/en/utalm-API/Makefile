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

######################################################

#export PYTHON_STYLE_WORKAROUND = 1
#C_STYPE_WORKAROUND = 1
 
SRC_POOL =


OUTSTEM		= $(CALLDIRNAME)
OUTFNAMES	= 

include Makefile-src-en.mk

DOXYGEN_HTML_DIR = $(OUTHTML3)/$(OUTSTEM)

DOXYGEN_HTML_FILES = $(DOXYGEN_HTML_DIR)/index.html
OUTFILES	+= $(DOXYGEN_HTML_FILES) 

# DOXYGEN_HTML_CALLBASE = $(RTBASE)
STRIP_FROM_PATH = $(RTBASE)

PROJECT_LOGO = $(DOCBASE_ML)images/utalm-green-96x60.png
#PROJECT_LOGO = $(DOCBASE_ML)images/utalm-92x60.png
HTML_HEADER = header.html
HTML_STYLESHEET = utalm.css 

DOXYGEN_HTML_INPUT =

DOXYGEN_HTML_INPUT += $(RTBASE)INSTALL.txt
DOXYGEN_HTML_INPUT += $(RTBASE)RELEASENOTES.txt
DOXYGEN_HTML_INPUT += $(RTBASE)sourceEnvironment.sh

DOXYGEN_HTML_INPUT += $(RTBASE)install-devel.sh
DOXYGEN_HTML_INPUT += $(RTBASE)install.sh

DOXYGEN_HTML_INPUT += mainpage.dox
DOXYGEN_HTML_INPUT += continousintegration.dox
DOXYGEN_HTML_INPUT += components.dox
DOXYGEN_HTML_INPUT += historyandorigin.dox
DOXYGEN_HTML_INPUT += license.dox
DOXYGEN_HTML_INPUT += aboututalm.dox
DOXYGEN_HTML_INPUT += README.dox

DOXYGEN_HTML_INPUT += install.dox
DOXYGEN_HTML_INPUT += runtimeenviron.dox

DOXYGEN_HTML_INPUT += syntax-bash.dox
DOXYGEN_HTML_INPUT += lowcosttddenvironment.dox
DOXYGEN_HTML_INPUT += make-based-unittests.dox
DOXYGEN_HTML_INPUT += testing-devops-tools.dox
DOXYGEN_HTML_INPUT += debuggertracelogging.dox
DOXYGEN_HTML_INPUT += systemlogs.dox
DOXYGEN_HTML_INPUT += eclipseintegration.dox

DOXYGEN_HTML_INPUT += $(BLD_ROOT)include
DOXYGEN_HTML_INPUT += $(BLD_ROOT)include/Makefile-version.mk
DOXYGEN_HTML_INPUT += $(BLD_ROOT)include/Makefile-root.mk

DOXYGEN_HTML_INPUT += $(RTBASE)conf
DOXYGEN_HTML_INPUT += $(RTBASE)bin/bootstrap
DOXYGEN_HTML_INPUT += $(RTBASE)bin/countErrors.sh
DOXYGEN_HTML_INPUT += $(RTBASE)bin/utalmhelp.sh
DOXYGEN_HTML_INPUT += $(RTBASE)lib/core
DOXYGEN_HTML_INPUT += $(RTBASE)examples/utalm-bash/help-demo
DOXYGEN_HTML_INPUT += $(RTBASE)lib/libutalm.sh
DOXYGEN_HTML_INPUT += $(RTBASE)lib/libutalm-min.sh
#DOXYGEN_HTML_INPUT += $(RTBASE)lib/Makefile.lib/Makefile-nodewalk.mk
#DOXYGEN_HTML_INPUT += $(RTBASE)lib/Makefile.lib/Nodeaction-test.sh
#DOXYGEN_HTML_INPUT += $(RTBASE)lib/Makefile.lib/Makefile-test.mk


DOXYGEN_HTML_CONF = Doxyfile.conf
DOXYGEN_HTML_LAYOUT = DoxygenLayout.xml
DOXYGEN_HTML_INPUT_CONF =  Doxyfile_Inputfiles.conf
DOXYGEN_HTML_OUTPUT_CONF =  Doxyfile_Outputfiles.conf

OUTFILES	= 

#for safety now
INCLUDES =  $(wildcards $(BLD_ROOT)include/*)
INCLUDES += $(wildcards $(DOC_BLD_ROOT)include/*)
INCLUDES += $(wildcards ../include/*)

#.PHONY: postpatches postproc_00 postproc_01 postproc_02  postproc_03 postproc_04
all:outdirs $(DOXYGEN_HTML_FILES) postpatches

postpatches:postproc_00 postproc_01 postproc_02  postproc_03 postproc_04

postproc_00:$(DOXYGEN_HTML_DIR)/usergroup0.html-old
$(DOXYGEN_HTML_DIR)/usergroup0.html-old:$(DOXYGEN_HTML_DIR)/index.html components-include.html
	touch $(DOXYGEN_HTML_DIR)/usergroup0.html-new
	cat $(DOXYGEN_HTML_DIR)/usergroup0.html |sed -e '1,/<!--header/!d;'>>$(DOXYGEN_HTML_DIR)/usergroup0.html-new
	cat $(DOXYGEN_HTML_DIR)/components-include.html >>$(DOXYGEN_HTML_DIR)/usergroup0.html-new
	cat $(DOXYGEN_HTML_DIR)/usergroup0.html |sed -e '/contents -->/,$$!d'>>$(DOXYGEN_HTML_DIR)/usergroup0.html-new
	mv $(DOXYGEN_HTML_DIR)/usergroup0.html $(DOXYGEN_HTML_DIR)/usergroup0.html-old
	touch $(DOXYGEN_HTML_DIR)/usergroup0.html-old
	mv $(DOXYGEN_HTML_DIR)/usergroup0.html-new $(DOXYGEN_HTML_DIR)/usergroup0.html

postproc_01:$(DOXYGEN_HTML_DIR)/components.html-old
$(DOXYGEN_HTML_DIR)/components.html-old:$(DOXYGEN_HTML_DIR)/index.html components-include.html
	touch $(DOXYGEN_HTML_DIR)/components.html-new
	cat $(DOXYGEN_HTML_DIR)/components.html |sed -e '1,/<!--header/!d;'>>$(DOXYGEN_HTML_DIR)/components.html-new
	cat $(DOXYGEN_HTML_DIR)/components-include.html >>$(DOXYGEN_HTML_DIR)/components.html-new
	cat $(DOXYGEN_HTML_DIR)/components.html |sed -e '/contents -->/,$$!d'>>$(DOXYGEN_HTML_DIR)/components.html-new
	mv $(DOXYGEN_HTML_DIR)/components.html $(DOXYGEN_HTML_DIR)/components.html-old
	touch $(DOXYGEN_HTML_DIR)/components.html-old
	mv $(DOXYGEN_HTML_DIR)/components.html-new $(DOXYGEN_HTML_DIR)/components.html

postproc_02:$(DOXYGEN_HTML_DIR)/usergroup3.html-old
$(DOXYGEN_HTML_DIR)/usergroup3.html-old:$(DOXYGEN_HTML_DIR)/index.html tdd-include.html
	touch $(DOXYGEN_HTML_DIR)/usergroup3.html-new
	cat $(DOXYGEN_HTML_DIR)/usergroup3.html |sed -e '1,/<!--header/!d;'>>$(DOXYGEN_HTML_DIR)/usergroup3.html-new
	cat $(DOXYGEN_HTML_DIR)/tdd-include.html >>$(DOXYGEN_HTML_DIR)/usergroup3.html-new
	cat $(DOXYGEN_HTML_DIR)/usergroup3.html |sed -e '/contents -->/,$$!d'>>$(DOXYGEN_HTML_DIR)/usergroup3.html-new
	mv $(DOXYGEN_HTML_DIR)/usergroup3.html $(DOXYGEN_HTML_DIR)/usergroup3.html-old
	touch $(DOXYGEN_HTML_DIR)/usergroup3.html-old
	mv $(DOXYGEN_HTML_DIR)/usergroup3.html-new $(DOXYGEN_HTML_DIR)/usergroup3.html

postproc_03:$(DOXYGEN_HTML_DIR)/usergroup1.html-old
$(DOXYGEN_HTML_DIR)/usergroup1.html-old:$(DOXYGEN_HTML_DIR)/index.html trace-include.html
	touch $(DOXYGEN_HTML_DIR)/usergroup1.html-new
	cat $(DOXYGEN_HTML_DIR)/usergroup1.html |sed -e '1,/<!--header/!d;'>>$(DOXYGEN_HTML_DIR)/usergroup1.html-new
	cat $(DOXYGEN_HTML_DIR)/trace-include.html >>$(DOXYGEN_HTML_DIR)/usergroup1.html-new
	cat $(DOXYGEN_HTML_DIR)/usergroup1.html |sed -e '/contents -->/,$$!d'>>$(DOXYGEN_HTML_DIR)/usergroup1.html-new
	mv $(DOXYGEN_HTML_DIR)/usergroup1.html $(DOXYGEN_HTML_DIR)/usergroup1.html-old
	touch $(DOXYGEN_HTML_DIR)/usergroup1.html-old
	mv $(DOXYGEN_HTML_DIR)/usergroup1.html-new $(DOXYGEN_HTML_DIR)/usergroup1.html

postproc_04:$(DOXYGEN_HTML_DIR)/usergroup2.html-old
$(DOXYGEN_HTML_DIR)/usergroup2.html-old:$(DOXYGEN_HTML_DIR)/index.html logging-include.html
	touch $(DOXYGEN_HTML_DIR)/usergroup2.html-new
	cat $(DOXYGEN_HTML_DIR)/usergroup2.html |sed -e '1,/<!--header/!d;'>>$(DOXYGEN_HTML_DIR)/usergroup2.html-new
	cat $(DOXYGEN_HTML_DIR)/logging-include.html >>$(DOXYGEN_HTML_DIR)/usergroup2.html-new
	cat $(DOXYGEN_HTML_DIR)/usergroup2.html |sed -e '/contents -->/,$$!d'>>$(DOXYGEN_HTML_DIR)/usergroup2.html-new
	mv $(DOXYGEN_HTML_DIR)/usergroup2.html $(DOXYGEN_HTML_DIR)/usergroup2.html-old
	touch $(DOXYGEN_HTML_DIR)/usergroup2.html-old
	mv $(DOXYGEN_HTML_DIR)/usergroup2.html-new $(DOXYGEN_HTML_DIR)/usergroup2.html

all: 	outdirs prep $(DOXYGEN_HTML_FILES) postpatches
#refer to Makefile-doxygen.mk for: $(DOXYGEN_HTML_FILES)

.PHONY:prep
prep:
	INDENT0="$(INDENT0)" INDENT1="$(INDENT1)" BLD_ROOT=$(BLD_ROOT) OUTLANG=$(OUTLANG) SUBROOTTOP= CURSUBPATH= $(MAKE) -C $(BLD_ROOT) $(MFLAGS) files dirs

postpatches:

$(DOXYGEN_HTML_INPUT): $(DOXYGEN_HTML_CONF) $(DOXYGEN_HTML_LAYOUT) $(DOXYGEN_HTML_INPUT_CONF) $(DOXYGEN_HTML_OUTPUT_CONF)
$(INCLUDES) $(DOXYGEN_HTML_CONF) $(DOXYGEN_HTML_LAYOUT) $(DOXYGEN_HTML_INPUT_CONF) $(DOXYGEN_HTML_OUTPUT_CONF):

#
include $(BLD_ROOT)lib/Makefile.lib/Makefile-doxygen-rules.mk
#
#######################################################
#
include $(BLD_ROOT)include/Makefile-post.mk
#
