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

DOXYGEN_HTML_INPUT += mainpage.dox
DOXYGEN_HTML_INPUT += historyandorigin.dox
DOXYGEN_HTML_INPUT += $(BLD_ROOT)/doc/en/include/license.dox
DOXYGEN_HTML_INPUT += $(BLD_ROOT)/doc/en/include/aboututalm.dox
DOXYGEN_HTML_INPUT += license.dox
DOXYGEN_HTML_INPUT += syntax-make.dox
DOXYGEN_HTML_INPUT += intromake.dox
DOXYGEN_HTML_INPUT += make-based-unittests.dox
DOXYGEN_HTML_INPUT += testing-devops-tools.dox
DOXYGEN_HTML_INPUT += howto-make.dox



##
DOXYGEN_HTML_INPUT_FILES += $(RTBASE)INSTALL.txt
DOXYGEN_HTML_INPUT_FILES += $(RTBASE)RELEASENOTES.txt
DOXYGEN_HTML_INPUT_FILES += $(RTBASE)Makefile
DOXYGEN_HTML_INPUT_FILES += $(RTBASE)README.txt

DOXYGEN_HTML_INPUT += $(RTBASE)install-devel.sh
DOXYGEN_HTML_INPUT += $(RTBASE)install.sh


DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/check-doxygen-cond-completion.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/check-doxygen-cond-pairs.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/countErrors.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/doxygenfilter.awk
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/doxygen-html-nav-entry.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/strip-bash.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/strip-bash-min.sh
DOXYGEN_HTML_INPUT_FILES_SRC += $(RTBASE)bin/countErrors.sh

DOXYGEN_HTML_INPUT_DIRS_SRC += $(RTBASE)lib/Makefile.lib
DOXYGEN_HTML_INPUT_DIRS_SRC += $(RTBASE)lib/libutalmrefpersistency.sh
DOXYGEN_HTML_INPUT_DIRS_SRC += $(RTBASE)lib/libutalmrefpersistency-min.sh
DOXYGEN_HTML_INPUT_DIRS_SRC += $(RTBASE)include

DOXYGEN_HTML_INPUT_DIRS += $(RTBASE)examples/utalm-make
DOXYGEN_HTML_INPUT_DIRS += $(RTBASE)tests/utalm-make


DOXYGEN_HTML_INPUT += $(DOXYGEN_HTML_INPUT_FILES)
DOXYGEN_HTML_INPUT += $(DOXYGEN_HTML_INPUT_DIRS)
DOXYGEN_HTML_INPUT += $(DOXYGEN_HTML_INPUT_FILES_SRC_GEN)
DOXYGEN_HTML_INPUT += $(DOXYGEN_HTML_INPUT_FILES_SRC)
DOXYGEN_HTML_INPUT += $(DOXYGEN_HTML_INPUT_DIRS_SRC)

DOXYGEN_HTML_CONF = Doxyfile.conf
DOXYGEN_HTML_LAYOUT = DoxygenLayout.xml
DOXYGEN_HTML_INPUT_CONF =  Doxyfile_Inputfiles.conf
DOXYGEN_HTML_OUTPUT_CONF =  Doxyfile_Outputfiles.conf

OUTFILES	= 

#for safety now
INCLUDES =  $(wildcards $(BLD_ROOT)include/*)
INCLUDES += $(wildcards $(DOC_BLD_ROOT)include/*)
INCLUDES += $(wildcards ../include/*)

all: outdirs $(DOXYGEN_HTML_FILES) postpatches
#refer to Makefile-doxygen.mk for: $(DOXYGEN_HTML_FILES)

postpatches:

$(DOXYGEN_HTML_INPUT): $(DOXYGEN_HTML_CONF) $(DOXYGEN_HTML_LAYOUT) $(DOXYGEN_HTML_INPUT_CONF) $(DOXYGEN_HTML_OUTPUT_CONF)
	INDENT0="$(INDENT0)" INDENT1="$(INDENT1)" BLD_ROOT=$(BLD_ROOT) OUTLANG=$(OUTLANG) SUBROOTTOP= CURSUBPATH= $(MAKE) -C $(BLD_ROOT) $(MFLAGS) files dirs
$(DOXYGEN_HTML_CONF) $(DOXYGEN_HTML_LAYOUT) $(DOXYGEN_HTML_INPUT_CONF) $(DOXYGEN_HTML_OUTPUT_CONF): 

#
include $(BLD_ROOT)lib/Makefile.lib/Makefile-doxygen-rules.mk
#
#######################################################
#
include $(BLD_ROOT)include/Makefile-post.mk
#
