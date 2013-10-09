#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
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
ifndef EN_DOC_BLD_ROOT_PRE_INCLUDED
EN_DOC_BLD_ROOT_PRE_INCLUDED:=1

ifdef DOC_BLD_ROOT
	include $(DOC_BLD_ROOT)include/Makefile-pre.mk
else
	$(error "Missing environment variable DOC_BLD_ROOT")
endif

#
#add to framework
#
ENV_FILES	+= $(DOC_BLD_ROOT)$(OUTLANG)/include/author.t2t
ENV_FILES	+= $(DOC_BLD_ROOT)$(OUTLANG)/include/copyright.t2t

LATEX		= latex
TEX2PDF		= pdflatex
TXT2TAGS 	= txt2tags


ifndef DBG
  TEX2PDF_ERRNULL = |sed -n 's/Output written/'$(TEX2PDF)':&/p;'
  ERRNULL	  = 2>/dev/null
endif

ifndef ERRSTOP
  TEX2PDF_INTERACTION = -interaction=nonstopmode 
endif

ifndef KEEPMETA
  KEEPMETA = 0
endif

OUTDIRS		+= $(TMPTEX)
OUTDIRS     += $(OUTDOC) $(OUTMAN) $(OUTMAN1) $(OUTMAN7)
OUTDIRS     += $(OUTHTML) $(OUTHTML1) $(OUTHTML7) 
OUTDIRS     += $(OUTPDF) $(OUTPDF1) $(OUTPDF7) 
OUTDIRS     += $(OUTTEX) $(OUTTEX1) $(OUTTEX7) 
OUTDIRS     += $(OUTTXT) $(OUTTXT1) $(OUTTXT7) 
OUTDIRS     += $(OUTWIKI) $(OUTWIKI1) $(OUTWIKI7) 
OUTDIRS     += $(OUTGWIKI) $(OUTGWIKI1) $(OUTGWIKI7) 
OUTDIRS     += $(OUTHELP) $(OUTIMGTMP) $(OUTINTERNAL) 
OUTDIRS     += $(OUTINTRO) 

endif
