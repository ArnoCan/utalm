#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENCE:      Apache-2.0
#VERSION:      03_01_001
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

vpath t2t $(DOC_BLD_ROOT)include
vpath inc $(BLD_ROOT)include
vpath inc $(DOC_BLD_ROOT)include
vpath inc include

T2T_SRC_FILES	= $(wildcard *.t2t)
T2T_MAIN_FILES	= $(wildcard main.t2t)
T2T_DEPS	= $(T2T_SRC_FILES)

OUTSTEM		= $(CALLDIRNAME)
OUTFNAMES	= 
#TXT1_FILES	= $(OUTTXT1)/$(OUTSTEM).txt
TEX_FILES	= 
TEX1_FILES	= $(OUTTEX1)/$(OUTSTEM).tex
TMP_TEX_FILES	= 
HTML_FILES	= 
HTML1_FILES	= $(OUTHTML1)/$(OUTSTEM).html
HTML7_FILES	= 
DOC_FILES	= 
DOC1_FILES	= $(OUTDOC1)/$(OUTSTEM)-doc.tex
DOC7_FILES	= 
PDF_FILES	= 
PDF1_FILES	= $(OUTPDF1)/$(OUTSTEM).pdf
PDF7_FILES	= 
MAN1_FILES	= $(OUTMAN1)/$(OUTSTEM).1
MAN7_FILES	=
WIKI1_FILES	= $(OUTWIKI1)/$(OUTSTEM).wiki
WIKI7_FILES	=
GWIKI1_FILES	= $(OUTGWIKI1)/$(OUTSTEM).gwiki
GWIKI7_FILES	=
HELP_FILES	= $(OUTHELP)/$(OUTSTEM)-help.txt

OUTFILES	= $(MAN1_FILES) $(MAN7_FILES)
OUTFILES	+= $(WIKI1_FILES) $(WIKI7_FILES) 
OUTFILES	+= $(GWIKI1_FILES) $(GWIKI7_FILES) 
OUTFILES	+= $(HTML1_FILES) $(HTML7_FILES) 
OUTFILES	+= $(PDF1_FILES) $(PDF7_FILES) 
OUTFILES	+= $(TEX1_FILES) $(TEX7_FILES) $(TMP_TEX_FILES)
OUTFILES	+= $(TXT1_FILES) $(TXT7_FILES)
#OUTFILES	+= $(DOC1_FILES) $(DOC7_FILES)
OUTFILES	+= $(HELP_FILES) 

ADDHTMLOPTS     = --toc

#for safety now
INCLUDES=$(wildcards $(BLD_ROOT)include/*)
INCLUDES=$(wildcards $(DOC_BLD_ROOT)include/*)
INCLUDES=$(wildcards ../include/*)

all:outdirs $(ENVFILES) $(OUTFILES) $(INCLUDES)

#
include $(BLD_ROOT)include/Makefile-rules.mk
#
#######################################################
#
include $(BLD_ROOT)include/Makefile-post.mk
#
