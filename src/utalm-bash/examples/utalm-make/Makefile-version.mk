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
## @ingroup utalmMakeExamples
## @file
## @brief Common release definitions
##
## \cond
##
#

#production output
VENDOR      = Ingenieurbuero Arno-Can Uestuensoez - www.i4p.com
PACKAGER    = Arno-Can Uestuensoez - acue.opensource@gmail.com
VERSION		= 03.03.005
LICENSE	    = Apache-2.0
RELEASE	    = R0
ARCH		= noarch
PROJECT     = UnifiedTraceAndLogManager-template4demo
PACKAGE_LONG = UnifiedTraceAndLogManager-utalm-bash-template4demo
PACKAGE		= utalm-bash-template4demo
WWW_PROJ	= http://sourceforge.net/projects/utalm
WWW_REPO_00	= http://sourceforge.net/p/utalm/code/ci/master/tree/
WWW_REPO_01	= https://github.com/ArnoCan/utalm
WWW_REF		= http://sourceforge.net/projects/utalm
WWW_USM		= http://UnifiedSessionsManager.org

ifndef OUTLANG
  OUTLANG=en
endif

ifndef VARIANT
  VARIANT=NIGHTLY
endif
## \endcond

