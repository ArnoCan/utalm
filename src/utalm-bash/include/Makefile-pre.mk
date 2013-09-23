#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-python
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
ifndef BLD_ROOT_PRE_INCLUDED
BLD_ROOT_PRE_INCLUDED:=1


include $(BLD_ROOT)Makefile-version.mk
include $(BLD_ROOT)Makefile-root.mk

ifndef OUTLANG
  $(error "Missing environment variable OUTLANG")
endif


#
ENV_FILES	=  Makefile
ENV_FILES	+= $(BLD_ROOT)include/Makefile-pre.mk
ENV_FILES	+= $(BLD_ROOT)include/Makefile-post.mk
ENV_FILES	+= $(BLD_ROOT)include/Makefile-rules.mk

#
#bld root-subdirs
#
OUTDOC		= $(DOCBASE)/doc
OUTDIRS		+= $(OUTDOC)
OUTDOC1		= $(OUTDOC)/man1
OUTDIRS		+= $(OUTDOC1)
OUTDOC7		= $(OUTDOC)/man7
OUTDIRS		+= $(OUTDOC7)

OUTHTML		= $(DOCBASE)/html
OUTDIRS		+= $(OUTHTML)
OUTHTML1	= $(OUTHTML)/man1
OUTDIRS		+= $(OUTHTML1)
OUTHTML7	= $(OUTHTML)/man7
OUTDIRS		+= $(OUTHTML7)

OUTTEX		= $(DOCBASE)/tex
OUTDIRS		+= $(OUTTEX)
OUTTEX1		= $(OUTTEX)/man1
OUTDIRS		+= $(OUTTEX1)
OUTTEX7		= $(OUTTEX)/man7
OUTDIRS		+= $(OUTTEX7)

OUTPDF		= $(DOCBASE)/pdf
OUTDIRS		+= $(OUTPDF)
OUTPDF1		= $(OUTPDF)/man1
OUTDIRS		+= $(OUTPDF1)
OUTPDF7		= $(OUTPDF)/man7
OUTDIRS		+= $(OUTPDF7)

OUTMAN		= $(DOCBASE)/man
OUTDIRS		+= $(OUTMAN)
OUTMAN1		= $(OUTMAN)/man1
OUTDIRS		+= $(OUTMAN1)
OUTMAN7		= $(OUTMAN)/man7
OUTDIRS		+= $(OUTMAN7)

OUTTXT		= $(DOCBASE)/txt
OUTDIRS		+= $(OUTTXT)
OUTTXT1		= $(OUTTXT)/man1
OUTDIRS		+= $(OUTTXT1)
OUTTXT7		= $(OUTTXT)/man7
OUTDIRS		+= $(OUTTXT7)

OUTEPUB		= $(DOCBASE)/epub
OUTDIRS		+= $(OUTEPUB)
OUTEPUB1	= $(OUTEPUB)/man1
OUTDIRS		+= $(OUTEPUB1)
OUTEPUB7	= $(OUTEPUB)/man7
OUTDIRS		+= $(OUTEPUB7)

OUTWIKI		= $(DOCBASE)/wiki
OUTDIRS		+= $(OUTWIKI)
OUTWIKI1	= $(OUTWIKI)/man1
OUTDIRS		+= $(OUTWIKI1)
OUTWIKI7	= $(OUTWIKI)/man7
OUTDIRS		+= $(OUTWIKI7)

OUTGWIKI	= $(DOCBASE)/gwiki
OUTDIRS		+= $(OUTGWIKI)
OUTGWIKI1	= $(OUTGWIKI)/man1
OUTDIRS		+= $(OUTGWIKI1)
OUTGWIKI7	= $(OUTGWIKI)/man7
OUTDIRS		+= $(OUTGWIKI7)

OUTIMGTMP	= $(TMP)/doc/images/
OUTIMGLANGTMP	= $(OUTIMGTMP)/$(OUTLANG)/images/
OUTDIRS		+= $(OUTIMGTMP)
OUTIMGDOC	= $(DOCBASE_ML)/images
OUTDIRS		+= $(OUTIMGDOC)
OUTIMGDOCLANG = $(DOCBASE)/images
OUTDIRS		+= $(OUTIMGDOCLANG)
TMPTEX		= $(TMP)/tex/$(OUTLANG)
OUTDIRS		+= $(TMPTEX)

OUTHELP		= $(DOCBASE)/help/$(OUTLANG)
OUTDIRS		+= $(OUTHELP)

OUTINTERNAL	= $(DOCBASE)/internal/$(OUTLANG)
OUTDIRS		+= $(OUTINTERNAL)

OUTINTRO	= $(DOCBASE)/intro/$(OUTLANG)
OUTDIRS		+= $(OUTINTRO)


#tgz - generic
TGZ_ROOT	= $(VARIANT_ROOT)/$(PACKAGE)-$(VERSION).$(ARCH)
OUTDIRS  	+= $(TGZ_ROOT)
ifeq ($(VARIANT),RELEASE)
#TGZ_NAME	= $(PACKAGE)-$(VERSION)-$(RELEASE).$(ARCH).tgz
TGZ_NAME	= $(PACKAGE)-$(VERSION)-$(RELEASE).$(ARCH).tgz
else
TGZ_NAME	= $(PACKAGE)-$(VERSION)-$(RELEASE)_$(VARIANT).$(ARCH).tgz
endif
TGZ_PNAME	= $(DIST_ROOT)/$(TGZ_NAME)
TGZ_PNAME_BLD = $(VARIANT_ROOT)/$(TGZ_NAME)

#srctgz - generic
SRCTGZ_ROOT= $(VARIANT_ROOT)/$(PACKAGE)-$(VERSION).src
OUTDIRS  	+= $(SRCTGZ_ROOT)
ifeq ($(VARIANT),RELEASE)
#TGZ_NAME	= $(PACKAGE)-$(VERSION)-$(RELEASE).$(ARCH).tgz
SRCTGZ_NAME	= $(PACKAGE)-$(VERSION)-$(RELEASE).src.tgz
else
SRCTGZ_NAME	= $(PACKAGE)-$(VERSION)-$(RELEASE)_$(VARIANT).src.tgz
endif
SRCTGZ_PNAME	= $(DIST_ROOT)/$(SRCTGZ_NAME)
SRCTGZ_PNAME_BLD 	= $(VARIANT_ROOT)/$(SRCTGZ_NAME)

#rpm - generic
RPM			= $(VARIANT_ROOT)/rpm
RPMBLD 		= $(RPM)/bld
RPM_ROOT	= $(RPM)/$(PACKAGE)-$(VERSION)
OUTDIRS  	+= $(RPM_ROOT)
ifeq ($(VARIANT),RELEASE)
RPM_NAME	= $(PACKAGE)-$(VERSION)-$(RELEASE).$(ARCH).rpm
else
RPM_NAME	= $(PACKAGE)-$(VERSION)-$(RELEASE)_$(VARIANT).$(ARCH).rpm
endif
RPM_PNAME	= $(DIST_ROOT)/$(RPM_NAME)
RPM_SPECNAME	= $(PACKAGE).spec
RPM_SPECPATH	= $(RPMBLD)/redhat/SPECS/$(RPM_SPECNAME) 
RPM_PNAME_BLD	= $(RPMBLD)/redhat/RPMS/noarch/$(RPM_NAME)
RPM_TGZ         = 


#srcrpm - generic
SRCRPM		= $(VARIANT_ROOT)/srcrpm
SRCRPMBLD	= $(SRCRPM)/bld
SRCRPM_ROOT	= $(SRCRPM)/$(PACKAGE)-$(VERSION).src
OUTDIRS  	+= $(SRCRPM_ROOT)
ifeq ($(VARIANT),RELEASE)
SRCRPM_NAME	= $(PACKAGE)-$(VERSION)-$(RELEASE).src.rpm
else
SRCRPM_NAME	= $(PACKAGE)-$(VERSION)-$(RELEASE)_$(VARIANT).src.rpm
endif
SRCRPM_PNAME	= $(DIST_ROOT)/$(SRCRPM_NAME)
SRCRPM_SPECNAME	= $(PACKAGE).src.spec
SRCRPM_SPECPATH	= $(SRCRPMBLD)/redhat/SPECS/$(SRCRPM_SPECNAME) 
SRCRPM_PNAME_BLD = $(SRCRPMBLD)/redhat/SRPMS/$(SRCRPM_NAME)
SRCRPM_TGZ      = 



#debian
DEB		= $(VARIANT_ROOT)/rpm
DEBBLD 		= $(DEB)/bld
DEB_ROOT	= $(DEB)/$(PACKAGE)-$(VERSION)
OUTDIRS  	+= $(DEB_ROOT)
# ifeq ($(VARIANT),RELEASE)
# DEB_NAME	= $(VARIANT_ROOT)/$(PACKAGE)-$(VERSION).$(ARCH).debian.5.noarch
# else
# DEB_NAME	= $(VARIANT_ROOT)/$(PACKAGE)-$(VERSION)-$(RELEASE).$(ARCH).debian.5.noarch
# endif
# DEB_PNAME	= $(DIST_ROOT)/$(DEB_NAME)
# DEB_PNAME_BLD	= $(DEBBLD)/$(DEB_NAME)


OUTFILES        = 
OUTFILES        += $(TGZ_PNAME)
OUTFILES        += $(SRCTGZ_PNAME)
OUTFILES        += $(RPM_PNAME)
OUTFILES        += $(SRCRPM_PNAME)
OUTFILES        += $(DEB_PNAME)

#
#planned versions
#
# OPENBSD		= 
# FREEBSD		=
# SOLARIS		=

#
#common calls
#
CALLDIR		= $(shell pwd)
CALLDIRNAME	= $(notdir $(CALLDIR))
CD		    = cd
CPA		    = cp -a -f
CPTREE	    = cp -a --parents
CPR  		= cp -r
CP	    	= cp 
ECHO		= echo
FIND		= find
LNS		    = ln -s
MKDIRFLGS	= -p
MKDIR		= mkdir  $(MKDIRFLGS) 
MV		    = MV 
RM		    = rm
RMRF		= $(RM) -rf
RPMBUILD	= rpmbuild
SED		    = sed
TGZ		    = tar -zcf
CHMOD		= chmod

TXT2TAGS    = txt2tags
SPHINX      = sphinx
EPYDOC      = epydoc

MK_BLD_LINKS = $(BLD_ROOT)tools/linklst.sh

endif
