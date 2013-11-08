## \cond
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-python
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
##
## @file
## @brief Provides standard filesystem variables for make
##
## The environment is based on the anchors BLD_ROOT and DOC_BLD_ROOT,
## which define the anchor of the source files for build usage.
## In addition the build variable OUTLANG is required, 'en' is
## currently the only supported language setting.
## This resolves dependencies of the build process itself.
## These variables has to be pre-defined as exported shell 
## environment variables.
##
## The utility \ref sourceEnvironment.sh provides the root nodes by
## source-ing.
## @ingroup libutalm_make
## \cond
#***MODUL_DOXYGEN_END***
ifndef BLD_ROOT_PRE_INCLUDED
BLD_ROOT_PRE_INCLUDED:=1

ifndef BLD_ROOT
  $(error "Missing environment variable BLD_ROOT")
endif

include $(BLD_ROOT)Makefile-version.mk
include $(BLD_ROOT)Makefile-root.mk


ifndef OUTLANG
  $(error "Missing environment variable OUTLANG")
endif


#
## \endcond
## @ingroup libutalm_make
ENV_FILES	=  "Makefile"
ENV_FILES	+= "$(BLD_ROOT)include/Makefile-pre.mk"
ENV_FILES	+= "$(BLD_ROOT)include/Makefile-post.mk"
ENV_FILES	+= "$(BLD_ROOT)include/Makefile-rules.mk"

#
#bld root-subdirs
#
## @ingroup libutalm_make
OUTDOC		= "$(DOCBASE)doc"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTDOC)"
## @ingroup libutalm_make
OUTDOC1		= "$(OUTDOC)/man1"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTDOC1)"
## @ingroup libutalm_make
OUTDOC3		= "$(OUTDOC)/man3"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTDOC3)"
## @ingroup libutalm_make
OUTDOC7		= "$(OUTDOC)/man7"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTDOC7)"

## @ingroup libutalm_make
OUTHTML		= "$(DOCBASE)html"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTHTML)"
## @ingroup libutalm_make
OUTHTML1	= "$(OUTHTML)/man1"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTHTML1)"
## @ingroup libutalm_make
OUTHTML3	= "$(OUTHTML)/man3"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTHTML3)"
## @ingroup libutalm_make
OUTHTML7	= "$(OUTHTML)/man7"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTHTML7)"

## @ingroup libutalm_make
OUTTEX		= "$(DOCBASE)tex"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTTEX)"
## @ingroup libutalm_make
OUTTEX1		= "$(OUTTEX)/man1"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTTEX1)"
## @ingroup libutalm_make
OUTTEX3		= "$(OUTTEX)/man3"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTTEX3)"
## @ingroup libutalm_make
OUTTEX7		= "$(OUTTEX)/man7"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTTEX7)"

## @ingroup libutalm_make
OUTPDF		= "$(DOCBASE)pdf"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTPDF)"
## @ingroup libutalm_make
OUTPDF1		= "$(OUTPDF)/man1"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTPDF1)"
## @ingroup libutalm_make
OUTPDF3		= "$(OUTPDF)/man3"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTPDF3)"
## @ingroup libutalm_make
OUTPDF7		= "$(OUTPDF)/man7"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTPDF7)"

## @ingroup libutalm_make
OUTMAN		= "$(DOCBASE)man"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTMAN)"
## @ingroup libutalm_make
OUTMAN1		= "$(OUTMAN)/man1"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTMAN1)"
## @ingroup libutalm_make
OUTMAN3		= "$(OUTMAN)/man3"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTMAN3)"
## @ingroup libutalm_make
OUTMAN7		= "$(OUTMAN)/man7"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTMAN7)"

## @ingroup libutalm_make
OUTTXT		= "$(DOCBASE)txt"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTTXT)"
## @ingroup libutalm_make
OUTTXT1		= "$(OUTTXT)/man1"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTTXT1)"
## @ingroup libutalm_make
OUTTXT3		= "$(OUTTXT)/man3"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTTXT3)"
## @ingroup libutalm_make
OUTTXT7		= "$(OUTTXT)/man7"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTTXT7)"

## @ingroup libutalm_make
OUTEPUB		= "$(DOCBASE)epub"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTEPUB)"
## @ingroup libutalm_make
OUTEPUB1	= "$(OUTEPUB)/man1"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTEPUB1)"
## @ingroup libutalm_make
OUTEPUB3	= "$(OUTEPUB)/man3"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTEPUB3)"
## @ingroup libutalm_make
OUTEPUB7	= "$(OUTEPUB)/man7"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTEPUB7)"

## @ingroup libutalm_make
OUTWIKI		= "$(DOCBASE)wiki"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTWIKI)"
## @ingroup libutalm_make
OUTWIKI1	= "$(OUTWIKI)/man1"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTWIKI1)"
## @ingroup libutalm_make
OUTWIKI3	= "$(OUTWIKI)/man3"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTWIKI3)"
## @ingroup libutalm_make
OUTWIKI7	= "$(OUTWIKI)/man7"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTWIKI7)"

## @ingroup libutalm_make
OUTGWIKI	= "$(DOCBASE)gwiki"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTGWIKI)"
## @ingroup libutalm_make
OUTGWIKI1	= "$(OUTGWIKI)/man1"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTGWIKI1)"
## @ingroup libutalm_make
OUTGWIKI3	= "$(OUTGWIKI)/man3"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTGWIKI3)"
## @ingroup libutalm_make
OUTGWIKI7	= "$(OUTGWIKI)/man7"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTGWIKI7)"

## @ingroup libutalm_make
OUTIMGTMP	= "$(TMP)doc/images/"
## @ingroup libutalm_make
OUTIMGLANGTMP	= "$(OUTIMGTMP)/$(OUTLANG)/images/"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTIMGTMP)"
## @ingroup libutalm_make
OUTIMGDOC	= "$(DOCBASE_ML)images"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTIMGDOC)"
## @ingroup libutalm_make
OUTIMGDOCLANG = "$(DOCBASE)images"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTIMGDOCLANG)"
## @ingroup libutalm_make
TMPTEX		= "$(TMP)tex/$(OUTLANG)"
## @ingroup libutalm_make
OUTDIRS		+= "$(TMPTEX)"

## @ingroup libutalm_make
OUTHELP		= "$(DOCBASE)help/$(OUTLANG)"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTHELP)"

## @ingroup libutalm_make
OUTINTERNAL	= "$(DOCBASE)internal/$(OUTLANG)"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTINTERNAL)"

## @ingroup libutalm_make
OUTINTRO	= "$(DOCBASE)intro/$(OUTLANG)"
## @ingroup libutalm_make
OUTDIRS		+= "$(OUTINTRO)"


#tgz - generic
## @ingroup libutalm_make
TGZ_ROOT	= "$(VARIANT_ROOT)/$(PACKAGE)-$(VERSION).$(ARCH)"
## @ingroup libutalm_make
OUTDIRS  	+= "$(TGZ_ROOT)"
ifeq ($(VARIANT),RELEASE)
## @ingroup libutalm_make
TGZ_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE).$(ARCH).tgz"
else
## @ingroup libutalm_make
TGZ_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE)_$(VARIANT).$(ARCH).tgz"
endif
## @ingroup libutalm_make
TGZ_PNAME	= "$(DIST_ROOT)/$(TGZ_NAME)"
## @ingroup libutalm_make
TGZ_PNAME_BLD = "$(VARIANT_ROOT)/$(TGZ_NAME)"

#tgz-devel - generic
## @ingroup libutalm_make
TGZ_DEVEL_ROOT	= "$(VARIANT_ROOT)/$(PACKAGE)-devel-$(VERSION).$(ARCH)"
## @ingroup libutalm_make
OUTDIRS  	+= "$(TGZ_DEVEL_ROOT)"
ifeq ($(VARIANT),RELEASE)
## @ingroup libutalm_make
TGZ_DEVEL_NAME	= "$(PACKAGE)-devel-$(VERSION)-$(RELEASE).$(ARCH).tgz"
else
## @ingroup libutalm_make
TGZ_DEVEL_NAME	= "$(PACKAGE)-devel-$(VERSION)-$(RELEASE)_$(VARIANT).$(ARCH).tgz"
endif
## @ingroup libutalm_make
TGZ_DEVEL_PNAME	= "$(DIST_ROOT)/$(TGZ_DEVEL_NAME)"
## @ingroup libutalm_make
TGZ_DEVEL_PNAME_BLD = "$(VARIANT_ROOT)/$(TGZ_DEVEL_NAME)"

#srctgz - generic
## @ingroup libutalm_make
SRCTGZ_ROOT= "$(VARIANT_ROOT)/$(PACKAGE)-$(VERSION).src"
## @ingroup libutalm_make
OUTDIRS  	+= "$(SRCTGZ_ROOT)"
ifeq ($(VARIANT),RELEASE)
## @ingroup libutalm_make
SRCTGZ_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE).src.tgz"
else
## @ingroup libutalm_make
SRCTGZ_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE)_$(VARIANT).src.tgz"
endif
## @ingroup libutalm_make
SRCTGZ_PNAME	= "$(DIST_ROOT)/$(SRCTGZ_NAME)"
## @ingroup libutalm_make
SRCTGZ_PNAME_BLD 	= "$(VARIANT_ROOT)/$(SRCTGZ_NAME)"

#rpm - generic
## @ingroup libutalm_make
RPM		= "$(VARIANT_ROOT)/rpm"
## @ingroup libutalm_make
RPMBLD 		= "$(RPM)/bld"
## @ingroup libutalm_make
RPM_ROOT	= "$(RPM)/$(PACKAGE)-$(VERSION)"
## @ingroup libutalm_make
OUTDIRS  	+= "$(RPM_ROOT)"
ifeq ($(VARIANT),RELEASE)
## @ingroup libutalm_make
RPM_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE).$(ARCH).rpm"
else
## @ingroup libutalm_make
RPM_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE)_$(VARIANT).$(ARCH).rpm"
endif
## @ingroup libutalm_make
RPM_PNAME	= "$(DIST_ROOT)/$(RPM_NAME)"
## @ingroup libutalm_make
RPM_SPECNAME	= "$(PACKAGE).spec"
## @ingroup libutalm_make
RPM_SPECPATH	= "$(RPMBLD)/redhat/SPECS/$(RPM_SPECNAME) "
## @ingroup libutalm_make
RPM_PNAME_BLD	= "$(RPMBLD)/redhat/RPMS/noarch/$(RPM_NAME)"
## @ingroup libutalm_make
RPM_TGZ         = ""


#rpm - devel
## @ingroup libutalm_make
RPMDEVEL	= "$(VARIANT_ROOT)/rpm-devel"
## @ingroup libutalm_make
RPMDEVELBLD	= "$(RPMDEVEL)/bld"
## @ingroup libutalm_make
RPMDEVEL_ROOT = "$(RPMDEVEL)/$(PACKAGE)-devel-$(VERSION)"
## @ingroup libutalm_make
OUTDIRS  	+= "$(RPMDEVEL_ROOT)"
ifeq ("$(VARIANT),RELEASE)"
## @ingroup libutalm_make
RPMDEVEL_NAME	= "$(PACKAGE)-devel-$(VERSION)-$(RELEASE).$(ARCH).rpm"
else
## @ingroup libutalm_make
RPMDEVEL_NAME	= "$(PACKAGE)-devel-$(VERSION)-$(RELEASE)_$(VARIANT).$(ARCH).rpm"
endif
## @ingroup libutalm_make
RPMDEVEL_PNAME	= "$(DIST_ROOT)/$(RPMDEVEL_NAME)"
## @ingroup libutalm_make
RPMDEVEL_SPECNAME	= "$(PACKAGE)-devel.spec"
## @ingroup libutalm_make
RPMDEVEL_SPECPATH	= "$(RPMDEVELBLD)/redhat/SPECS/$(RPMDEVEL_SPECNAME) "
## @ingroup libutalm_make
RPMDEVEL_PNAME_BLD	= "$(RPMDEVELBLD)/redhat/RPMS/noarch/$(RPMDEVEL_NAME)"
## @ingroup libutalm_make
RPMDEVEL_TGZ         = ""


#srcrpm - generic
## @ingroup libutalm_make
SRCRPM		= "$(VARIANT_ROOT)/srcrpm"
## @ingroup libutalm_make
SRCRPMBLD	= "$(SRCRPM)/bld"
## @ingroup libutalm_make
SRCRPM_ROOT	= "$(SRCRPM)/$(PACKAGE)-$(VERSION).src"
## @ingroup libutalm_make
OUTDIRS  	+= "$(SRCRPM_ROOT)"
ifeq ("$(VARIANT),RELEASE)"
## @ingroup libutalm_make
SRCRPM_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE).src.rpm"
else
## @ingroup libutalm_make
SRCRPM_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE)_$(VARIANT).src.rpm"
endif
## @ingroup libutalm_make
SRCRPM_PNAME	= "$(DIST_ROOT)/$(SRCRPM_NAME)"
## @ingroup libutalm_make
SRCRPM_SPECNAME	= "$(PACKAGE).src.spec"
## @ingroup libutalm_make
SRCRPM_SPECPATH	= "$(SRCRPMBLD)/redhat/SPECS/$(SRCRPM_SPECNAME) "
## @ingroup libutalm_make
SRCRPM_PNAME_BLD = "$(SRCRPMBLD)/redhat/SRPMS/$(SRCRPM_NAME)"
## @ingroup libutalm_make
SRCRPM_TGZ      = ""

#gittree generic
## @ingroup libutalm_make
GITTREE		 = "$(VARIANT_ROOT)/git"
## @ingroup libutalm_make
GITTREE_ROOT = "$(GITTREE)/$(PACKAGE)-$(VERSION).git"
## @ingroup libutalm_make
GITTREEBLD	= "$(GITTREE)/bld"
## @ingroup libutalm_make
OUTDIRS  	+= "$(GITTREE_ROOT)"
ifeq ("$(VARIANT),RELEASE)"
## @ingroup libutalm_make
GITTREE_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE).git"
else
## @ingroup libutalm_make
GITTREE_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE)_$(VARIANT).git"
endif
## @ingroup libutalm_make
GITTREE_PNAME	= "$(DIST_ROOT)/$(SRCRPM_NAME)"


#debian
## @ingroup libutalm_make
DEB		= "$(VARIANT_ROOT)/rpm"
## @ingroup libutalm_make
DEBBLD 		= "$(DEB)/bld"
## @ingroup libutalm_make
DEB_ROOT	= "$(DEB)/$(PACKAGE)-$(VERSION)"
## @ingroup libutalm_make
OUTDIRS  	+= "$(DEB_ROOT)"

## @ingroup libutalm_make
OUTFILES        = ""
## @ingroup libutalm_make
OUTFILES        += "$(TGZ_PNAME)"
## @ingroup libutalm_make
OUTFILES        += "$(SRCTGZ_PNAME)"
## @ingroup libutalm_make
OUTFILES        += "$(RPM_PNAME)"
## @ingroup libutalm_make
OUTFILES        += "$(SRCRPM_PNAME)"
## @ingroup libutalm_make
OUTFILES        += "$(DEB_PNAME)"

#
#common calls
#
## @ingroup libutalm_make
PATH		:= "$(RTBASE)/bin:$(PATH) "
## @ingroup libutalm_make
CALLDIR		= "$(shell pwd)"
## @ingroup libutalm_make
CALLDIRNAME	= "$(notdir $(CALLDIR))"
## @ingroup libutalm_make
CD		    = "cd"
## @ingroup libutalm_make
CPA		    = "cp -a -f -u"
## @ingroup libutalm_make
CPTREE	    = "cp -a --parents"
## @ingroup libutalm_make
CPR  		= "cp -r"
## @ingroup libutalm_make
CP	    	= "cp "
## @ingroup libutalm_make
ECHO		= "echo"
## @ingroup libutalm_make
FIND		= "find"
## @ingroup libutalm_make
LNS		    = "ln -s"
## @ingroup libutalm_make
MKDIRFLGS	= "-p"
ifdef DBG
## @ingroup libutalm_make
MKDIRFLGS	+= "-v"
endif
## @ingroup libutalm_make
MKDIR		= "mkdir  $(MKDIRFLGS) "
## @ingroup libutalm_make
MV		    = "mv"
## @ingroup libutalm_make
RM		    = "rm"
## @ingroup libutalm_make
RMRF		= "$(RM) -rf"
## @ingroup libutalm_make
RPMBUILD	= "rpmbuild"
## @ingroup libutalm_make
SED		    = "sed"
## @ingroup libutalm_make
TARGZIP	    = "tar -zcf"
## @ingroup libutalm_make
CHMOD		= "chmod"

## @ingroup libutalm_make
TXT2TAGS    = "txt2tags"
## @ingroup libutalm_make
SPHINX      = "sphinx"
## @ingroup libutalm_make
EPYDOC      = "epydoc"
## @ingroup libutalm_make
DOXYGEN		= "doxygen"

## \cond
endif
## \endcond
