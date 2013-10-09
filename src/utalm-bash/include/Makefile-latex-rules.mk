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
ifndef _LATEX_INCLUDED_
_LATEX_INCLUDED_:=1

LATEXINCLUDE=$(shell X=$(BLD_ROOT)lib/Makefile.lib/Makefile-latex-rules.mk;if [ -e $$X ];then echo $$X; \
    else  X=$(BLD_ROOT)src/lib/Makefile.lib/Makefile-latex-rules.mk;if [ -e $$X ];then echo $$X;  \
       else  X=$(HOME)/lib/Makefile.lib/Makefile-latex-rules.mk;if [ -e $$X ];then echo $$X;      \
       fi; \
    fi; \
fi;)
ifndef LATEXINCLUDE
$(error "Missing LATEXINCLUDE")
endif
include $(LATEXINCLUDE)
ifndef _LATEX_RULES_INCLUDED
$(error "Missing: Makefile-latex-rules.mk -> " $(BLD_ROOT_PYTHON_DOC_RULES_INCLUDED))
endif

endif #_LATEX_INCLUDED_
