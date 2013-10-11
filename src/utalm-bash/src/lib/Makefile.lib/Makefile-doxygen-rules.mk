## \cond
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
#***MODUL_DOXYGEN_START***
## \endcond
##
## @package libutalm_bash_devel
## @author Arno-Can Uestuensoez
## @date 2013.10.10
## @version 03_02_001
## @file
## @brief Provides rules for doxygen
##
## \cond
#***MODUL_DOXYGEN_END***
#
ifndef _DOXYGEN_RULES_INCLUDED_
_DOXYGEN_RULES_INCLUDED_:=1

PYTHON_STYLE_WORKAROUND = 1


DOXYGEN = doxygen
DOXYGEN_OPTS =

#sed -i 's@--INPUT--@'"$(echo $(find . -name '*.sh' ))"'@' Doxyfile


#
#ifndef DOXYGEN_HTML_CALLBASE
#$(error "Missing definition of DOXYGEN_HTML_CALLBASE")
#endif

#
ifndef DOXYGEN_HTML_DIR
$(error "Missing definition of DOXYGEN_HTML_DIR")
endif
OUTDIRS += $(DOXYGEN_HTML_DIR)

ifndef DOXYGEN_HTML_INPUT
$(error "Missing definition of DOXYGEN_HTML_INPUT")
endif

ifndef DOXYGEN_HTML_CONF
$(error "Missing definition of DOXYGEN_HTML_CONF")
endif

html:$(DOXYGEN_HTML_FILES)
$(DOXYGEN_HTML_FILES): $(ENV_FILES) $(DOXYGEN_HTML_INPUT)
ifdef DBG
	@$(ECHO) "Create by doxygen in:$(DOXYGEN_HTML_DIR)"
	@$(ECHO) "From:$(DOXYGEN_HTML_INPUT)"
endif
	$(MKDIR) $(DOXYGEN_HTML_DIR)
	$(CP) $(DOXYGEN_HTML_CONF) $(DOXYGEN_HTML_DIR)
ifdef SRC_FILES
	echo $(CPA) $(SRC_FILES) $(DOXYGEN_HTML_DIR)
	$(CPA) $(SRC_FILES) $(DOXYGEN_HTML_DIR)
endif	
ifdef SRC_DIRS
	$(CPA) $(SRC_DIRS) $(DOXYGEN_HTML_DIR)
endif	
	echo "OUTPUT_DIRECTORY = "$(DOXYGEN_HTML_DIR) >> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
	echo "INPUT = "$(DOXYGEN_HTML_INPUT) >> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
	echo "ECLIPSE_DOC_ID = "$(ECLIPSE_DOC_ID) >> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
	echo 'FILE_PATTERNS = *.sh *.awk *.sed *.conf *.mk Makefile' >> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
	echo "STRIP_FROM_PATH = "$(STRIP_FROM_PATH) >> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)

ifdef PROJECT_LOGO
	$(CPA) $(PROJECT_LOGO) $(DOXYGEN_HTML_DIR)
	echo "PROJECT_LOGO = "$(notdir $(PROJECT_LOGO)) >> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)		
endif
ifdef HTML_STYLESHEET
	$(CPA) $(HTML_STYLESHEET) $(DOXYGEN_HTML_DIR)
	echo "HTML_STYLESHEET = "$(notdir $(HTML_STYLESHEET)) >> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)		
endif
ifdef HTML_HEADER
	$(CPA) $(HTML_HEADER) $(DOXYGEN_HTML_DIR)
	echo "HTML_HEADER = "$(notdir $(HTML_HEADER)) >> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)		
endif
ifdef C_STYLE_WORKAROUND
	echo "C_STYLE_WORKAROUND"
	echo 'FILE_PATTERNS = *.sh *.awk *.sed *.mk'>> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
	echo "INPUT_FILTER =  \"sed -e 's|#D\(.*\)$$|#D\1 //!\1|;s|#C \(.*\)$$|\1|'\"" >> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
	echo "EXTENSION_MAPPING = sh=C mk=C conf=C ">> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
	echo "FILTER_SOURCE_FILES = YES">> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
endif
ifdef PYTHON_STYLE_WORKAROUND
	echo "PYTHON_STYLE_WORKAROUND"
	echo "INPUT_FILTER =  \"sed -e 's|#D\(.*\)$$|#D\1 //!\1|;s|#P \(.*\)$$|\1|'\"" >> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
	echo "EXTENSION_MAPPING = sh=Python mk=Python conf=Python ">> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
	echo "FILTER_SOURCE_FILES = YES">> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
endif
	cd $(DOXYGEN_HTML_DIR)&& $(DOXYGEN)  $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
	$(RMRF) $(DOXYGEN_HTML_DIR)/latex
	$(CPA) $(DOXYGEN_HTML_DIR)/html/* $(DOXYGEN_HTML_DIR) 
	$(RMRF) $(DOXYGEN_HTML_DIR)/html
	$(CPA) $(DOXYGEN_HTML_DIR) $(DOCBASE_ECLIPSE)/$(ECLIPSE_DOC_ID)
ifdef DOXYGEN_HTML_CONF
#	-$(RM) $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
endif
.PHONY:html



endif # _DOXYGEN_RULES_INCLUDED_
## \endcond
