## \cond
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-python
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
#HEADEND################################################################
#
#$Header$
#
##
## \endcond
##
## @file
## @author Arno-Can Uestuensoez
## @date 2013.10.10
## @version 03_03_003
## @brief Demo Makefile for documentation by doxygen
##
## The Makefile demonstrates ...
##
## @ingroup doxygenmakedocexample
## \cond
##

ifndef BLD_ROOT_PRE_INCLUDED
BLD_ROOT_PRE_INCLUDED:=1

include $(BLD_ROOT)include/Makefile-version.mk
include $(BLD_ROOT)include/Makefile-root.mk


ifndef OUTLANG
  $(error "Missing environment variable OUTLANG")
endif


#
## \cond
ENV_FILES	=  Makefile
## \endcond
ENV_FILES	+= $(BLD_ROOT)include/Makefile-pre.mk
ENV_FILES	+= $(BLD_ROOT)include/Makefile-post.mk
ENV_FILES	+= $(BLD_ROOT)include/Makefile-rules.mk

#
#bld root-subdirs
#
## \cond
OUTDOC		= "$(DOCBASE)doc"
OUTDIRS		+= "$(OUTDOC)"
OUTDOC1		= "$(OUTDOC)/man1"
OUTDIRS		+= $(OUTDOC1)
## \endcond



#tgz - generic
TGZ_ROOT	= $(VARIANT_ROOT)/$(PACKAGE)-$(VERSION).$(ARCH)
OUTDIRS  	+= $(TGZ_ROOT)
ifeq ($(VARIANT),RELEASE)
TGZ_NAME	= $(PACKAGE)-$(VERSION)-$(RELEASE).$(ARCH).tgz
else
TGZ_NAME	= $(PACKAGE)-$(VERSION)-$(RELEASE)_$(VARIANT).$(ARCH).tgz
endif
TGZ_PNAME	= $(DIST_ROOT)/$(TGZ_NAME)
TGZ_PNAME_BLD = $(VARIANT_ROOT)/$(TGZ_NAME)

#tgz-devel - generic
TGZ_DEVEL_ROOT	= $(VARIANT_ROOT)/$(PACKAGE)-devel-$(VERSION).$(ARCH)
OUTDIRS  	+= $(TGZ_DEVEL_ROOT)
ifeq ($(VARIANT),RELEASE)
TGZ_DEVEL_NAME	= $(PACKAGE)-devel-$(VERSION)-$(RELEASE).$(ARCH).tgz
else
TGZ_DEVEL_NAME	= $(PACKAGE)-devel-$(VERSION)-$(RELEASE)_$(VARIANT).$(ARCH).tgz
endif
TGZ_DEVEL_PNAME	= $(DIST_ROOT)/$(TGZ_DEVEL_NAME)
TGZ_DEVEL_PNAME_BLD = $(VARIANT_ROOT)/$(TGZ_DEVEL_NAME)


endif

## \endcond
