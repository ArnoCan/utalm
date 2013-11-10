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
#
##
## \endcond
## @ingroup txt2tagstemplateDemo
## @file
## @brief Top node actions
##
## \cond
##

#bld root

ifndef BLD_OUT_BASE
	BLD_OUT_BASE := /tmp
endif
ifndef BLD_OUT_BASE
  $(error "Missing environment variable BLD_OUT_BASE append a '/'")
endif

BASE 	= $(BLD_OUT_BASE)/bld/$(PACKAGE)-$(VERSION)/
TMP		= ${BASE}tmp
ifndef OUTDIR
	OUTDIR	= $(BASE)-out
endif

#languages
ifndef OUTLANGLST
	OUTLANGLST  = en
#	OUTLANGLST  = en de
endif
ifndef OUTLANG
	OUTLANG  = en
endif

#www-root
WWWLNK		= www-tmp
WWWBASE		= ${BASE}$(WWWLNK)/

#rt-root
RTLNK		= rt-tmp
RTBASE		= ${BASE}$(RTLNK)/$(VARIANT)/

#root for dependent parts
#RTADDONSLNK	= addons-tmp
#RTADDONSBASE  = ${BASE}/$(RTADDONSLNK)/$(VARIANT)/

#unknown temporary storage for further analysis
#UNKNOWNLNK	= addons-tmp
#UNKNOWNBASE  = ${BASE}/$(UNKNOWNLNK)/$(VARIANT)/

#doc-root - could be used autonomous too
DOCLNK 		= doc-tmp
DOCVARIANT	= ${BASE}$(DOCLNK)/$(VARIANT)/
DOCBASE_ML	= ${BASE}$(DOCLNK)/$(VARIANT)/doc/
DOCBASE		= ${DOCBASE_ML}$(OUTLANG)/
DOCBASE_COMMON	= ${BASE}$(DOCLNK)/

#
# Eclipse
#
ECLIPSE_DOC_ID  = org.i4p.utalm.bash
DOCBASE_ECLIPSE = ${BASE}$(DOCLNK)/$(VARIANT)/eclipse
OUTDIRS += $(DOCBASE_ECLIPSE)

#
# Test data
#
TST_ROOT=$(TMP)/testout

#
#assemble generic output directories 
#
OUTDIRS		+= $(BASE) $(TMP) $(TST_ROOT)
OUTDIRS		+= $(RTBASE) $(RTADDONSBASE) $(WWWBASE) $(DOCBASE) $(DOCBASE_COMMON)

ROOT_SRC_POOL   =  doc src 
ROOT_LNK_POOL   =  

DIST_ROOT	= $(BLD_OUT_BASE)/bld
VARIANT_ROOT	= $(BASE)dist-bld/$(VARIANT)
OUTDIRS		+= $(DIST_ROOT) $(VARIANT_ROOT)
## \endcond
