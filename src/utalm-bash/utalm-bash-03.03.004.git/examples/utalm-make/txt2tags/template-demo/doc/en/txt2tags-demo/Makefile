## \cond
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
##
## \endcond
##
## @ingroup txt2tagsExamples
## @file
## @brief Top Makefile in BLD_ROOT
##
## The Makefile located within BLD_ROOT directory. 
##
## \cond
##
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

## \endcond
SRC_POOL =
## \cond

vpath t2t $(DOC_BLD_ROOT)include
vpath inc $(BLD_ROOT)include
vpath inc $(DOC_BLD_ROOT)include
vpath inc include

T2T_SRC_FILES	= $(wildcard *.t2t)
T2T_MAIN_FILES	= $(wildcard main.t2t)
T2T_DEPS	= $(T2T_SRC_FILES)
## \endcond

OUTSTEM		= $(CALLDIRNAME)
OUTFNAMES	= 
#TXT3_FILES	= $(OUTTXT3)/$(OUTSTEM).txt
TEX_FILES	= 
TEX3_FILES	= $(OUTTEX3)/$(OUTSTEM).tex
TMP_TEX_FILES	= 
HTML_FILES	= 
HTML3_FILES	= $(OUTHTML3)/$(OUTSTEM).html
HTML7_FILES	= 
DOC_FILES	= 
DOC3_FILES	= $(OUTDOC3)/$(OUTSTEM)-doc.tex
DOC7_FILES	= 
PDF_FILES	= 
PDF3_FILES	= $(OUTPDF3)/$(OUTSTEM).pdf
PDF7_FILES	= 
MAN3_FILES	= $(OUTMAN3)/$(OUTSTEM).3
MAN7_FILES	=
WIKI3_FILES	= $(OUTWIKI3)/$(OUTSTEM).wiki
WIKI7_FILES	=
GWIKI3_FILES	= $(OUTGWIKI3)/$(OUTSTEM).gwiki
GWIKI7_FILES	=
HELP_FILES	= $(OUTHELP)/$(OUTSTEM)-help.txt

OUTFILES	= $(MAN3_FILES) $(MAN7_FILES)
OUTFILES	+= $(WIKI3_FILES) $(WIKI7_FILES) 
OUTFILES	+= $(GWIKI3_FILES) $(GWIKI7_FILES) 
OUTFILES	+= $(HTML3_FILES) $(HTML7_FILES) 
OUTFILES	+= $(PDF3_FILES) $(PDF7_FILES) 
OUTFILES	+= $(TEX3_FILES) $(TEX7_FILES) $(TMP_TEX_FILES)
OUTFILES	+= $(TXT3_FILES) $(TXT7_FILES)
#OUTFILES	+= $(DOC3_FILES) $(DOC7_FILES)
OUTFILES	+= $(HELP_FILES) 

ADDHTMLOPTS     = --toc

## \cond
#for safety now
INCLUDES =$(wildcards $(BLD_ROOT)include/*)
INCLUDES +=$(wildcards $(DOC_BLD_ROOT)include/*)
INCLUDES +=$(wildcards ../include/*)

all:outdirs $(ENVFILES) $(OUTFILES) $(INCLUDES)

#
include $(BLD_ROOT)include/Makefile-rules.mk
#
#######################################################
#
include $(BLD_ROOT)include/Makefile-post.mk
#
## \endcond
