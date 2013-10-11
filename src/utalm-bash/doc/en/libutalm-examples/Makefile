#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
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
ifndef OUTLANG
  $(error "Missing environment variable OUTLANG")
endif
ifdef DOC_BLD_ROOT
  include $(DOC_BLD_ROOT)$(OUTLANG)/include/Makefile-pre.mk
else
  $(error "Missing environment variable DOC_BLD_ROOT")
endif

######################################################

SRC_POOL =


OUTSTEM		= $(CALLDIRNAME)
OUTFNAMES	= 


DOXYGEN_HTML_DIR = $(OUTHTML7)/$(OUTSTEM)

DOXYGEN_HTML_FILES = $(DOXYGEN_HTML_DIR)/index.html
OUTFILES	+= $(DOXYGEN_HTML_FILES) 

STRIP_FROM_PATH = $(RTBASE)

PROJECT_LOGO = $(DOCBASE_ML)images/usm-green-50x50.png
HTML_HEADER = header.html
HTML_STYLESHEET = utalm.css 

DOXYGEN_HTML_INPUT =
DOXYGEN_HTML_INPUT += $(RTBASE)examples/utalm-bash
DOXYGEN_HTML_INPUT += $(RTBASE)utalm-bash-show-help.sh
DOXYGEN_HTML_INPUT += $(RTBASE)sourceEnvironment.sh

DOXYGEN_HTML_INPUT += $(RTBASE)INSTALL.txt
DOXYGEN_HTML_INPUT += $(RTBASE)RELEASENOTES.txt
DOXYGEN_HTML_INPUT += $(RTBASE)sourceEnvironment.sh
DOXYGEN_HTML_INPUT += $(RTBASE)utalm-bash-show-help.sh

DOXYGEN_HTML_INPUT += mainpage.dox

DOXYGEN_HTML_CONF = Doxyfile.conf
DOXYGEN_HTML_INPUT_CONF =  Doxyfile_Inputfiles.conf
DOXYGEN_HTML_OUTPUT_CONF =  Doxyfile_Outputfiles.conf

SRC_FILES = mainpage.dox 
OUTFILES	= 

#for safety now
INCLUDES=$(wildcards $(BLD_ROOT)include/*)
INCLUDES=$(wildcards $(DOC_BLD_ROOT)include/*)
INCLUDES=$(wildcards ../include/*)

all:outdirs $(ENVFILES)  $(INCLUDES) $(DOXYGEN_HTML_INPUT) $(DOXYGEN_HTML_FILES)

$(DOXYGEN_HTML_INPUT):$(BLD_ROOT)examples
$(BLD_ROOT)examples : outdirs $(ENVFILES) topmain
	@echo
	@echo "###"
	@echo "#Change to:$@"
	cd $@&&$(MAKE) $(MFLAGS)
	@echo "#...finished:$@"

.PHONY:topmain
topmain:
	INDENT0="$(INDENT0)" INDENT1="$(INDENT1)" BLD_ROOT=$(BLD_ROOT) OUTLANG=$(OUTLANG) SUBROOTTOP= CURSUBPATH= $(MAKE) -C $(BLD_ROOT) $(MFLAGS) files dirs

#
include $(BLD_ROOT)include/Makefile-doxygen-rules.mk
#
#######################################################
#
include $(BLD_ROOT)include/Makefile-post.mk
#
