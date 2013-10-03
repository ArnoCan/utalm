#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENCE:      Apache-2.0
#VERSION:      03_01_002
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
ifndef EN_DOC_BLD_ROOT
	ifdef DOC_BLD_ROOT
		EN_DOC_BLD_ROOT=$(DOC_BLD_ROOT)en/
	else
		$(error "Missing environment variable EN_DOC_BLD_ROOT")
	endif
endif
include $(EN_DOC_BLD_ROOT)include/Makefile-pre.mk

######################################################

vpath t2t $(DOC_BLD_ROOT)include
vpath inc $(DOC_BLD_ROOT)include

SRC_POOL =
T2T_SRC_FILES	= $(wildcard *.t2t)
T2T_MAIN_FILES	= $(wildcard main.t2t)
T2T_DEPS	= $(T2T_SRC_FILES)

OUTSTEM		= $(CALLDIRNAME)
OUTFNAMES	= 
#TXT1_FILES	= $(OUTTXT7)/$(OUTSTEM).txt
TEX_FILES	= 
TEX1_FILES	= 
TMP_TEX_FILES	= 
HTML_FILES	= 
HTML1_FILES	= 
HTML7_FILES	= $(OUTHTML7)/$(OUTSTEM).html
DOC_FILES	= 
PDF_FILES	= 
PDF1_FILES	= 
PDF7_FILES	= $(OUTPDF7)/$(OUTSTEM).pdf
MAN1_FILES	= 
MAN7_FILES	= $(OUTMAN7)/$(OUTSTEM).7
WIKI1_FILES	= 
WIKI7_FILES	= $(OUTWIKI7)/$(OUTSTEM).wiki
GWIKI1_FILES	= 
GWIKI7_FILES	= $(OUTGWIKI7)/$(OUTSTEM).gwiki
HELP_FILES	= $(OUTHELP)/$(OUTSTEM)-help.txt

OUTFILES	= $(MAN7_FILES)
OUTFILES	+= $(WIKI1_FILES) $(WIKI7_FILES) 
OUTFILES	+= $(GWIKI1_FILES) $(GWIKI7_FILES) 
OUTFILES	+= $(HTML7_FILES) 
OUTFILES	+= $(PDF7_FILES) 
OUTFILES	+= $(TEX7_FILES) $(TMP_TEX_FILES)
OUTFILES	+= $(TXT7_FILES)
OUTFILES	+= $(DOC_FILES) 
OUTFILES	+= $(HELP_FILES) 

#for safety now
INCLUDES=$(wildcards $(BLD_ROOT)include/*)
INCLUDES=$(wildcards $(DOC_BLD_ROOT)include/*)
INCLUDES=$(wildcards ../include/*)

ADDHTMLOPTS     = --toc

all:outdirs $(ENVFILES) $(OUTFILES) $(INCLUDES)
outdirs:$(OUTDIRS)

#
include $(BLD_ROOT)include/Makefile-rules.mk
#
#######################################################
#
include $(BLD_ROOT)include/Makefile-post.mk
#




