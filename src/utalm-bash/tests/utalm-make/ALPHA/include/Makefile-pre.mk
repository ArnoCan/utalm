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
## \cond
##
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
ENV_FILES	=  "Makefile"
ENV_FILES	+= "$(BLD_ROOT)include/Makefile-pre.mk"
ENV_FILES	+= "$(BLD_ROOT)include/Makefile-post.mk"
ENV_FILES	+= "$(BLD_ROOT)include/Makefile-rules.mk"

#
#bld root-subdirs
#
OUTDOC		= "$(DOCBASE)doc"
OUTDIRS		+= "$(OUTDOC)"
OUTDOC1		= "$(OUTDOC)/man1"
OUTDIRS		+= "$(OUTDOC1)"
OUTDOC3		= "$(OUTDOC)/man3"
OUTDIRS		+= "$(OUTDOC3)"
OUTDOC7		= "$(OUTDOC)/man7"
OUTDIRS		+= "$(OUTDOC7)"

OUTHTML		= "$(DOCBASE)html"
OUTDIRS		+= "$(OUTHTML)"
OUTHTML1	= "$(OUTHTML)/man1"
OUTDIRS		+= "$(OUTHTML1)"
OUTHTML3	= "$(OUTHTML)/man3"
OUTDIRS		+= "$(OUTHTML3)"
OUTHTML7	= "$(OUTHTML)/man7"
OUTDIRS		+= "$(OUTHTML7)"

OUTTEX		= "$(DOCBASE)tex"
OUTDIRS		+= "$(OUTTEX)"
OUTTEX1		= "$(OUTTEX)/man1"
OUTDIRS		+= "$(OUTTEX1)"
OUTTEX3		= "$(OUTTEX)/man3"
OUTDIRS		+= "$(OUTTEX3)"
OUTTEX7		= "$(OUTTEX)/man7"
OUTDIRS		+= "$(OUTTEX7)"

OUTPDF		= "$(DOCBASE)pdf"
OUTDIRS		+= "$(OUTPDF)"
OUTPDF1		= "$(OUTPDF)/man1"
OUTDIRS		+= "$(OUTPDF1)"
OUTPDF3		= "$(OUTPDF)/man3"
OUTDIRS		+= "$(OUTPDF3)"
OUTPDF7		= "$(OUTPDF)/man7"
OUTDIRS		+= "$(OUTPDF7)"

OUTMAN		= "$(DOCBASE)man"
OUTDIRS		+= "$(OUTMAN)"
OUTMAN1		= "$(OUTMAN)/man1"
OUTDIRS		+= "$(OUTMAN1)"
OUTMAN3		= "$(OUTMAN)/man3"
OUTDIRS		+= "$(OUTMAN3)"
OUTMAN7		= "$(OUTMAN)/man7"
OUTDIRS		+= "$(OUTMAN7)"

OUTTXT		= "$(DOCBASE)txt"
OUTDIRS		+= "$(OUTTXT)"
OUTTXT1		= "$(OUTTXT)/man1"
OUTDIRS		+= "$(OUTTXT1)"
OUTTXT3		= "$(OUTTXT)/man3"
OUTDIRS		+= "$(OUTTXT3)"
OUTTXT7		= "$(OUTTXT)/man7"
OUTDIRS		+= "$(OUTTXT7)"

OUTEPUB		= "$(DOCBASE)epub"
OUTDIRS		+= "$(OUTEPUB)"
OUTEPUB1	= "$(OUTEPUB)/man1"
OUTDIRS		+= "$(OUTEPUB1)"
OUTEPUB3	= "$(OUTEPUB)/man3"
OUTDIRS		+= "$(OUTEPUB3)"
OUTEPUB7	= "$(OUTEPUB)/man7"
OUTDIRS		+= "$(OUTEPUB7)"

OUTWIKI		= "$(DOCBASE)wiki"
OUTDIRS		+= "$(OUTWIKI)"
OUTWIKI1	= "$(OUTWIKI)/man1"
OUTDIRS		+= "$(OUTWIKI1)"
OUTWIKI3	= "$(OUTWIKI)/man3"
OUTDIRS		+= "$(OUTWIKI3)"
OUTWIKI7	= "$(OUTWIKI)/man7"
OUTDIRS		+= "$(OUTWIKI7)"

OUTGWIKI	= "$(DOCBASE)gwiki"
OUTDIRS		+= "$(OUTGWIKI)"
OUTGWIKI1	= "$(OUTGWIKI)/man1"
OUTDIRS		+= "$(OUTGWIKI1)"
OUTGWIKI3	= "$(OUTGWIKI)/man3"
OUTDIRS		+= "$(OUTGWIKI3)"
OUTGWIKI7	= "$(OUTGWIKI)/man7"
OUTDIRS		+= "$(OUTGWIKI7)"

OUTIMGTMP	= "$(TMP)doc/images/"
OUTIMGLANGTMP	= "$(OUTIMGTMP)/$(OUTLANG)/images/"
OUTDIRS		+= "$(OUTIMGTMP)"
OUTIMGDOC	= "$(DOCBASE_ML)images"
OUTDIRS		+= "$(OUTIMGDOC)"
OUTIMGDOCLANG = "$(DOCBASE)images"
OUTDIRS		+= "$(OUTIMGDOCLANG)"
TMPTEX		= "$(TMP)tex/$(OUTLANG)"
OUTDIRS		+= "$(TMPTEX)"

OUTHELP		= "$(DOCBASE)help/$(OUTLANG)"
OUTDIRS		+= "$(OUTHELP)"

OUTINTERNAL	= "$(DOCBASE)internal/$(OUTLANG)"
OUTDIRS		+= "$(OUTINTERNAL)"

OUTINTRO	= "$(DOCBASE)intro/$(OUTLANG)"
OUTDIRS		+= "$(OUTINTRO)"


#tgz - generic
TGZ_ROOT	= "$(VARIANT_ROOT)/$(PACKAGE)-$(VERSION).$(ARCH)"
OUTDIRS  	+= "$(TGZ_ROOT)"
## \cond
ifeq ($(VARIANT),RELEASE)
## \endcond
TGZ_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE).$(ARCH).tgz"
## \cond
else
## \endcond
TGZ_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE)_$(VARIANT).$(ARCH).tgz"
## \cond
endif
## \endcond
TGZ_PNAME	= "$(DIST_ROOT)/$(TGZ_NAME)"
TGZ_PNAME_BLD = "$(VARIANT_ROOT)/$(TGZ_NAME)"

#tgz-devel - generic
TGZ_DEVEL_ROOT	= "$(VARIANT_ROOT)/$(PACKAGE)-devel-$(VERSION).$(ARCH)"
OUTDIRS  	+= "$(TGZ_DEVEL_ROOT)"
## \cond
ifeq ($(VARIANT),RELEASE)
## \endcond
TGZ_DEVEL_NAME	= "$(PACKAGE)-devel-$(VERSION)-$(RELEASE).$(ARCH).tgz"
## \cond
else
## \endcond
TGZ_DEVEL_NAME	= "$(PACKAGE)-devel-$(VERSION)-$(RELEASE)_$(VARIANT).$(ARCH).tgz"
## \cond
endif
## \endcond
TGZ_DEVEL_PNAME	= "$(DIST_ROOT)/$(TGZ_DEVEL_NAME)"
TGZ_DEVEL_PNAME_BLD = "$(VARIANT_ROOT)/$(TGZ_DEVEL_NAME)"

#srctgz - generic
SRCTGZ_ROOT= "$(VARIANT_ROOT)/$(PACKAGE)-$(VERSION).src"
OUTDIRS  	+= "$(SRCTGZ_ROOT)"
## \cond
ifeq ($(VARIANT),RELEASE)
## \endcond
SRCTGZ_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE).src.tgz"
## \cond
else
## \endcond
SRCTGZ_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE)_$(VARIANT).src.tgz"
## \cond
endif
## \endcond
SRCTGZ_PNAME	= "$(DIST_ROOT)/$(SRCTGZ_NAME)"
SRCTGZ_PNAME_BLD 	= "$(VARIANT_ROOT)/$(SRCTGZ_NAME)"

#rpm - generic
RPM		= "$(VARIANT_ROOT)/rpm"
RPMBLD 		= "$(RPM)/bld"
RPM_ROOT	= "$(RPM)/$(PACKAGE)-$(VERSION)"
OUTDIRS  	+= "$(RPM_ROOT)"
## \cond
ifeq ($(VARIANT),RELEASE)
## \endcond
RPM_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE).$(ARCH).rpm"
## \cond
else
## \endcond
RPM_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE)_$(VARIANT).$(ARCH).rpm"
## \cond
endif
## \endcond
RPM_PNAME	= "$(DIST_ROOT)/$(RPM_NAME)"
RPM_SPECNAME	= "$(PACKAGE).spec"
RPM_SPECPATH	= "$(RPMBLD)/redhat/SPECS/$(RPM_SPECNAME) "
RPM_PNAME_BLD	= "$(RPMBLD)/redhat/RPMS/noarch/$(RPM_NAME)"
RPM_TGZ         = ""


#rpm - devel
RPMDEVEL	= "$(VARIANT_ROOT)/rpm-devel"
RPMDEVELBLD	= "$(RPMDEVEL)/bld"
RPMDEVEL_ROOT = "$(RPMDEVEL)/$(PACKAGE)-devel-$(VERSION)"
OUTDIRS  	+= "$(RPMDEVEL_ROOT)"
## \cond
ifeq ("$(VARIANT),RELEASE)"
## \endcond
RPMDEVEL_NAME	= "$(PACKAGE)-devel-$(VERSION)-$(RELEASE).$(ARCH).rpm"
## \cond
else
## \endcond
RPMDEVEL_NAME	= "$(PACKAGE)-devel-$(VERSION)-$(RELEASE)_$(VARIANT).$(ARCH).rpm"
## \cond
endif
## \endcond
RPMDEVEL_PNAME	= "$(DIST_ROOT)/$(RPMDEVEL_NAME)"
RPMDEVEL_SPECNAME	= "$(PACKAGE)-devel.spec"
RPMDEVEL_SPECPATH	= "$(RPMDEVELBLD)/redhat/SPECS/$(RPMDEVEL_SPECNAME) "
RPMDEVEL_PNAME_BLD	= "$(RPMDEVELBLD)/redhat/RPMS/noarch/$(RPMDEVEL_NAME)"
RPMDEVEL_TGZ         = ""


#srcrpm - generic
SRCRPM		= "$(VARIANT_ROOT)/srcrpm"
SRCRPMBLD	= "$(SRCRPM)/bld"
SRCRPM_ROOT	= "$(SRCRPM)/$(PACKAGE)-$(VERSION).src"
OUTDIRS  	+= "$(SRCRPM_ROOT)"
## \cond
ifeq ("$(VARIANT),RELEASE)"
## \endcond
SRCRPM_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE).src.rpm"
## \cond
else
## \endcond
SRCRPM_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE)_$(VARIANT).src.rpm"
## \cond
endif
## \endcond
SRCRPM_PNAME	= "$(DIST_ROOT)/$(SRCRPM_NAME)"
SRCRPM_SPECNAME	= "$(PACKAGE).src.spec"
SRCRPM_SPECPATH	= "$(SRCRPMBLD)/redhat/SPECS/$(SRCRPM_SPECNAME) "
SRCRPM_PNAME_BLD = "$(SRCRPMBLD)/redhat/SRPMS/$(SRCRPM_NAME)"
SRCRPM_TGZ      = ""

#gittree generic
GITTREE		 = "$(VARIANT_ROOT)/git"
GITTREE_ROOT = "$(GITTREE)/$(PACKAGE)-$(VERSION).git"
GITTREEBLD	= "$(GITTREE)/bld"
OUTDIRS  	+= "$(GITTREE_ROOT)"
## \cond
ifeq ("$(VARIANT),RELEASE)"
## \endcond
GITTREE_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE).git"
## \cond
else
## \endcond
GITTREE_NAME	= "$(PACKAGE)-$(VERSION)-$(RELEASE)_$(VARIANT).git"
## \cond
endif
## \endcond
GITTREE_PNAME	= "$(DIST_ROOT)/$(SRCRPM_NAME)"


#debian
DEB		= "$(VARIANT_ROOT)/rpm"
DEBBLD 		= "$(DEB)/bld"
DEB_ROOT	= "$(DEB)/$(PACKAGE)-$(VERSION)"
OUTDIRS  	+= "$(DEB_ROOT)"

OUTFILES        = ""
OUTFILES        += "$(TGZ_PNAME)"
OUTFILES        += "$(SRCTGZ_PNAME)"
OUTFILES        += "$(RPM_PNAME)"
OUTFILES        += "$(SRCRPM_PNAME)"
OUTFILES        += "$(DEB_PNAME)"

#
#common calls
#
PATH		:= "$(RTBASE)/bin:$(PATH) "
CALLDIR		= "$(shell pwd)"
CALLDIRNAME	= "$(notdir $(CALLDIR))"
CD		    = "cd"
CPA		    = "cp -a -f -u"
CPTREE	    = "cp -a --parents"
CPR  		= "cp -r"
CP	    	= "cp "
ECHO		= "echo"
FIND		= "find"
LNS		    = "ln -s"
MKDIRFLGS	= "-p"
## \cond
ifdef DBG
## \endcond
MKDIRFLGS	+= "-v"
## \cond
endif
## \endcond
MKDIR		= "mkdir  $(MKDIRFLGS) "
MV		    = "mv"
RM		    = "rm"
RMRF		= "$(RM) -rf"
RPMBUILD	= "rpmbuild"
SED		    = "sed"
TARGZIP	    = "tar -zcf"
CHMOD		= "chmod"

TXT2TAGS    = "txt2tags"
SPHINX      = "sphinx"
EPYDOC      = "epydoc"
DOXYGEN		= "doxygen"
## \cond
endif
## \endcond
