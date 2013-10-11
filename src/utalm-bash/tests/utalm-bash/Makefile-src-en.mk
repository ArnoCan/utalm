#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-python
#LICENCE:      Apache-2.0
#VERSION:      03_02_003
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

#
SRC_FILES	+= README.txt
SRC_FILES	+= Makefile
SRC_FILES	+= Makefile-src-en.mk
SRC_FILES	+= Makefile-nodeaction-en.mk

#
SRC_DIRS	+= 
#
ifeq ($(VARIANT),ALPHA)
SUB_POOLS   += ALPHA
endif
ifeq ($(VARIANT),BETA)
SUB_POOLS   += ALPHA
SUB_POOLS   += BETA
endif
ifeq ($(VARIANT),RELEASE)
SUB_POOLS   += ALPHA
SUB_POOLS   += BETA
SUB_POOLS   += RELEASE
endif
ifeq ($(VARIANT), NIGHTLY)
SUB_POOLS   += ALPHA
SUB_POOLS   += BETA
SUB_POOLS   += RELEASE
SUB_POOLS   += NIGHTLY
endif
ifeq ($(VARIANT),EXPERIMENTAL)
SUB_POOLS   += ALPHA
SUB_POOLS   += BETA
SUB_POOLS   += RELEASE
SUB_POOLS   += NIGHTLY
SUB_POOLS   += EXPERIMENTAL
endif
ifeq ($(VARIANT),INTERNAL)
SUB_POOLS   += ALPHA
SUB_POOLS   += BETA
SUB_POOLS   += RELEASE
SUB_POOLS   += NIGHTLY
SUB_POOLS   += INTERNAL
endif
ifeq ($(VARIANT),SUPPORT)
SUB_POOLS   += ALPHA
SUB_POOLS   += BETA
SUB_POOLS   += RELEASE
SUB_POOLS   += NIGHTLY
SUB_POOLS   += SUPPORT
endif


