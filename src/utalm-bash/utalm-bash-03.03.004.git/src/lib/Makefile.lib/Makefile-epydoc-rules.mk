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
## @brief Provides rules for epydoc
##
## For additional information refer to "man 7 man-pages"
## The following extract is applied:
##
##	...The manual Sections are traditionally defined as follows:
##	1 Commands (Programs)
##	  Those commands that can be executed by the user from within a shell.
##	2 System calls
##	  Those functions which must be performed by the kernel.
##	3 Library calls
##	  Most of the libc functions.
##	4 Special files (devices)
##	  Files found in /dev.
##	5 File formats and conventions
##	  The format for /etc/passwd and other human-readable files.
##	6 Games
##	7 Overview, conventions, and miscellaneous
##	  Overviews of various topics, conventions and protocols, character set standards, and miscellaneous other things.
##	8 System management commands
##	  Commands like mount(8), many of which only root can execute.
##
## @ingroup libutalm_make
## \cond
##
#
ifndef _EPYDOC_RULES_INCLUDED
_EPYDOC_RULES_INCLUDED:=1

ifndef MAKE_VERSION
$(error "requires GNUmake")
endif

ifdef PYTHONPATH
ifdef RTBASE
	#sets a release collection for auto scan
	PYTHONPATH := $(RTBASE):$(PYTHONPATH)
endif
else
PYTHONPATH = 
ifdef RTBASE
	#sets a release collection for auto scan
	PYTHONPATH := $(RTBASE)
endif
endif

EPYDOC = epydoc
EPYDOC_OPTS =
ifdef DBG
EPYDOC_OPTS += -v
EPYDOC_OPTS += --DBG
EPYDOC_OPTS += --debug
EPYDOC_OPTS += --include-log
endif

ifdef EPYDOCCONF
EPYDOC_OPTS += --config=$(EPYDOCCONF)
endif

ifdef EPYDOCCSS
EPYDOC_OPTS += --css=$(EPYDOCCSS)
endif

ifdef EPYDOCURL
EPYDOC_OPTS += --url=$(EPYDOCURL)
endif

ifdef ERRSTOP
EPYDOC_OPTS += --fail-on-error
endif

#EPYDOC_OPTS += --inheritance=grouped
#EPYDOC_OPTS += --inheritance=listed
EPYDOC_OPTS += --inheritance=included
#EPYDOC_OPTS += --show-imports
EPYDOC_OPTS += --no-private
EPYDOC_OPTS += --dotpath=/usr/bin/dot
EPYDOC_OPTS += --graph=all
EPYDOC_OPTS += --pstat=/tmp/epydoc
EPYDOC_OPTS += --redundant-details
EPYDOC_OPTS += $(EPYDOC_ADDITIONAL_OPTS)


#
ifndef EPYDOC_HTML_FILES
$(error "Missing definition of EPYDOC_HTML_FILES")
endif
ifndef EPYDOC_HTML_INPUT
$(error "Missing definition of EPYDOC_HTML_INPUT")
endif
html:$(EPYDOC_HTML_FILES)
$(EPYDOC_HTML_FILES): $(EPYDOC_HTML_INPUT) $(ENV_FILES)
ifdef DBG
	@$(ECHO) "export PYTHONPATH=$(PYTHONPATH); $(EPYDOC) --html $(EPYDOC_OPTS) --name=$(shell A=$(dir $@)&&A=$${A%/}&&echo $${A##*/}) --output=$(dir $@)  $(EPYDOC_HTML_INPUT)"
endif
	export PYTHONPATH=$(PYTHONPATH); $(EPYDOC) --html $(EPYDOC_OPTS) --name=$(shell A=$(dir $@)&&A=$${A%/}&&echo $${A##*/}) --output=$(dir $@) $(EPYDOC_HTML_INPUT)
.PHONY:html

ifndef EPYDOC_PDF_FILES
$(error "Missing definition of EPYDOC_PDF_FILES")
endif
ifndef EPYDOC_PDF_INPUT
$(error "Missing definition of EPYDOC_PDF_INPUT")
endif
pdf:$(EPYDOC_PDF_FILES)
$(EPYDOC_PDF_FILES): $(EPYDOC_PDF_INPUT) $(ENV_FILES)
ifdef DBG
	@$(ECHO) "export PYTHONPATH=$(PYTHONPATH); $(EPYDOC) --pdf $(EPYDOC_OPTS) --output=$(dir $@) $(EPYDOC_PDF_INPUT)"
endif
	export PYTHONPATH=$(PYTHONPATH); $(EPYDOC) --pdf $(EPYDOC_OPTS) --output=$(dir $@)/$(NAME) $(EPYDOC_PDF_INPUT)
	mv $(dir $@)/$(NAME)/*.pdf $(dir $@)
	#$(RMF) $(dir $@)/$(NAME)
	
.PHONY:pdf


#
$(EPYDOC_LATEX_FILES): $(EPYDOC_LATEX_INPUT) $(ENV_FILES)
ifdef DBG
	@$(ECHO) "export PYTHONPATH=$(PYTHONPATH); $(EPYDOC) --latex $(EPYDOC_OPTS) ---name=$(shell A=$(dir $@)&&A=$${A%/}&&echo $${A##*/}) -output=$(dir $@) $(EPYDOC_LATEX_INPUT)" 
endif
	export PYTHONPATH=$(PYTHONPATH); $(EPYDOC) --latex $(EPYDOC_OPTS) --name=$(shell A=$(dir $@)&&A=$${A%/}&&echo $${A##*/}) --output=$(dir $@) $(EPYDOC_LATEX_INPUT)

#
$(EPYDOC_DVI_FILES): $(EPYDOC_DVI_INPUT) $(ENV_FILES)
ifdef DBG
	@$(ECHO) $(EPYDOC) --latex $(EPYDOC_OPTS) --output=$(dir $@) $(EPYDOC_LATEX_INPUT)
endif
	cd $(dir $@)&&$(EPYDOC) --latex $(EPYDOC_OPTS) --output=$(dir $@) $(EPYDOC_LATEX_INPUT)

endif # _EPYDOC_RULES_INCLUDED_
## \endcond
