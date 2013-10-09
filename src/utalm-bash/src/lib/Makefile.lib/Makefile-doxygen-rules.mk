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
ifndef _DOXYGEN_RULES_INCLUDED_
_DOXYGEN_RULES_INCLUDED_:=1


DOXYGEN = doxygen
DOXYGEN_OPTS =

#sed -i 's@--INPUT--@'"$(echo $(find . -name '*.sh' ))"'@' Doxyfile


#
ifndef DOXYGEN_HTML_CALLBASE
$(error "Missing definition of DOXYGEN_HTML_CALLBASE")
endif

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

ifndef DOXYGEN_HTML_INPUT_CONF
$(error "Missing definition of DOXYGEN_HTML_INPUT_CONF")
endif

ifndef DOXYGEN_HTML_OUTPUT_CONF
$(error "Missing definition of DOXYGEN_HTML_OUTPUT_CONF")
endif



html:$(DOXYGEN_HTML_FILES)
$(DOXYGEN_HTML_FILES): $(ENV_FILES) $(DOXYGEN_HTML_INPUT)
ifdef DBG
	@$(ECHO) "Create by doxygen in:$(DOXYGEN_HTML_DIR)"
	@$(ECHO) "From:$(DOXYGEN_HTML_INPUT)"
endif
	$(MKDIR) $(DOXYGEN_HTML_DIR)
	$(CP) $(DOXYGEN_HTML_CONF) $(DOXYGEN_HTML_DIR)
	
	echo "OUTPUT_DIRECTORY = "$(DOXYGEN_HTML_DIR) >> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
	echo "INPUT = "$(DOXYGEN_HTML_INPUT) >> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
	echo "ECLIPSE_DOC_ID = "$(DOXYGEN_HTML_INPUT) >> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
	echo 'FILE_PATTERNS = *.sh *.awk *.sed *.mk Makefile' >> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
	echo "STRIP_FROM_PATH = "$(STRIP_FROM_PATH) >> $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
		
	cd $(DOXYGEN_HTML_CALLBASE)&& $(DOXYGEN)  $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
	$(RM) $(DOXYGEN_HTML_DIR)/$(DOXYGEN_HTML_CONF)
	$(RMRF) $(DOXYGEN_HTML_DIR)/latex
	$(MV) $(DOXYGEN_HTML_DIR)/html/* $(DOXYGEN_HTML_DIR) 
	$(RMRF) $(DOXYGEN_HTML_DIR)/html
	$(CPA) $(DOXYGEN_HTML_DIR) $(DOCBASE_ECLIPSE)/$(ECLIPSE_DOC_ID)
.PHONY:html



endif # _DOXYGEN_RULES_INCLUDED_
