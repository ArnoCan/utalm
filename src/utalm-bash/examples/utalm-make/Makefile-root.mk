## \cond
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENSE:      Apache-2.0 + CCL-BY-SA-3.0
#VERSION:      03_03_001
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
#***MODUL_DOXYGEN_START***
## \endcond
## @ingroup utalmMakeExamples
## @file
## @brief Top node definitions
##
## \cond
#***MODUL_DOXYGEN_END***

#bld root

## \endcond
#P BLD_OUT_BASE = "/tmp"
## \cond
ifndef BLD_OUT_BASE
	BLD_OUT_BASE := /tmp
endif
ifndef BLD_OUT_BASE
  $(error "Missing environment variable BLD_OUT_BASE append a '/'")
endif

## \endcond
#P BASE = "$(BLD_OUT_BASE)/bld/$(PACKAGE)-$(VERSION)/"
## \cond
BASE = $(BLD_OUT_BASE)/bld/$(PACKAGE)-$(VERSION)/
## \endcond
#P TMP = "${BASE}tmp"
## \cond
TMP = ${BASE}tmp
## \endcond
#P OUTDIR = "$(BASE)-out"
## \cond
ifndef OUTDIR
	OUTDIR	= $(BASE)-out
endif
## \endcond
#P OUTDIRS = ""
## \cond
ifndef OUTDIRS
	OUTDIRS	= ""
endif

#languages
## \endcond
#P OUTLANGLST = "en"
## \cond
ifndef OUTLANGLST
	OUTLANGLST  = en
#	OUTLANGLST  = en de
endif
## \endcond
#P OUTLANG = "en"
## \cond
ifndef OUTLANG
	OUTLANG  = en
endif

#www-root
## \endcond
WWWLNK = "www-tmp"
## \cond
## \endcond
#P WWWBASE = "${BASE}$(WWWLNK)/"
## \cond
WWWBASE		= ${BASE}$(WWWLNK)/

#rt-root
## \endcond
RTLNK = "rt-tmp"
## \cond
## \endcond
#P RTBASE = "${BASE}$(RTLNK)/$(VARIANT)/"
## \cond
RTBASE = ${BASE}$(RTLNK)/$(VARIANT)/

#root for dependent parts
#RTADDONSLNK	= addons-tmp
#RTADDONSBASE  = ${BASE}/$(RTADDONSLNK)/$(VARIANT)/

#unknown temporary storage for further analysis
#UNKNOWNLNK	= addons-tmp
#UNKNOWNBASE  = ${BASE}/$(UNKNOWNLNK)/$(VARIANT)/

#doc-root - could be used autonomous too
## \endcond
DOCLNK 		= "doc-tmp"
DOCVARIANT  = "${BASE}$(DOCLNK)/$(VARIANT)/"
DOCBASE_ML	= "${BASE}$(DOCLNK)/$(VARIANT)/doc/"
DOCBASE		= "${DOCBASE_ML}$(OUTLANG)/"
DOCBASE_COMMON	= "${BASE}$(DOCLNK)/"
## \cond

#
# Eclipse
#
## \endcond
ECLIPSE_DOC_ID  = "org.i4p.utalm.bash"
DOCBASE_ECLIPSE = "${BASE}$(DOCLNK)/$(VARIANT)/eclipse"
OUTDIRS += "$(DOCBASE_ECLIPSE)"
#
#assemble generic output directories 
#
OUTDIRS		+= "$(BASE) $(TMP)"
OUTDIRS		+= "$(RTBASE) $(RTADDONSBASE) $(WWWBASE) $(DOCBASE) $(DOCBASE_COMMON)"

ROOT_SRC_POOL   =  doc src 
ROOT_LNK_POOL   =  ""

DIST_ROOT	= "$(BLD_OUT_BASE)/bld"
VARIANT_ROOT	= "$(BASE)dist-bld/$(VARIANT)"
OUTDIRS		+= "$(DIST_ROOT) $(VARIANT_ROOT)"

