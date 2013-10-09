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
ifndef DOC_BLD_ROOT_PRE_INCLUDED
DOC_BLD_ROOT_PRE_INCLUDED:=1


ifdef BLD_ROOT
  include $(BLD_ROOT)include/Makefile-pre.mk
else
  $(error "Missing environment variable BLD_ROOT")
endif

ifndef OUTLANGLST
  $(error "Missing environment variable OUTLANGLST")
endif

ifndef VARIANT
  $(error "Missing environment variable VARIANT")
endif
#
#add to framework
#
ENV_FILES	+= $(DOC_BLD_ROOT)include/Makefile-pre.mk
ENV_FILES	+= $(DOC_BLD_ROOT)include/Makefile-post.mk
ENV_FILES	+= $(DOC_BLD_ROOT)include/conf-doc.t2t
ENV_FILES	+= $(DOC_BLD_ROOT)include/conf-man.t2t

ENV_FILES	+= $(wildcard $(DOC_BLD_ROOT)conf/common/*.tex)
ENV_FILES	+= $(wildcard $(DOC_BLD_ROOT)conf/dvi/*.tex)
ENV_FILES	+= $(wildcard $(DOC_BLD_ROOT)conf/pdf/print/*.tex)
ENV_FILES	+= $(wildcard $(DOC_BLD_ROOT)conf/pdf/screen/man/*.tex)
ENV_FILES	+= $(wildcard $(DOC_BLD_ROOT)conf/html/html0/*.tex)
ENV_FILES	+= $(wildcard $(DOC_BLD_ROOT)conf/html/html1/*.tex)

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
.SILENT:
.PHONY:  doc  docblddirs

endif
