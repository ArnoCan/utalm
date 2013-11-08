#!/bin/bash
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
#***MODUL_DOXYGEN_START***
## \endcond
##
## @file
## @brief Basic environment settings.
## 
## @ingroup libutalm_make
## \cond
#***MODUL_DOXYGEN_END***

## \endcond
## @ingroup libutalm_make
BLD_ROOT="$PWD/"
## \cond
export BLD_ROOT;

## \endcond
## @ingroup libutalm_make
DOC_BLD_ROOT="$BLD_ROOT/doc/"
## \cond
export DOC_BLD_ROOT;


## \endcond
## @ingroup libutalm_make
OUTLANG="en"
## \cond
export OUTLANG;

## \endcond
## @ingroup libutalm_make
OUTLANGLST="en"
## \cond
export OUTLANGLST;

if [ -z "$PATH_ORG" ];then
## \endcond
## @ingroup libutalm_make
PATH_ORG="$PATH"
## \cond
fi

## \endcond
## @ingroup libutalm_make
PATH="${BLD_ROOT}src/bin:${BLD_ROOT}bin:$PATH_ORG"
## \cond

if [ -z "$PATH_ORG" ];then
## \endcond
## @ingroup libutalm_make
LD_LIBRARY_PATH_ORG="$LD_LIBRARY_PATH"
## \cond
fi

## \endcond
## @ingroup libutalm_make
LD_LIBRARY_PATH="${BLD_ROOT}src/lib:${BLD_ROOT}lib:$LD_LIBRARY_PATH_ORG"
## \cond
export LD_LIBRARY_PATH

## \endcond
## @ingroup libutalm_make
#P BLD_OUT_BASE="$(sed -n 's/^[ \t]*BLD_OUT_BASE[ \t:]*=[ \t]*//p;s/(/{/g;s/)/}/g' Makefile-root.mk)"
## \cond
BLD_OUT_BASE=$(sed -n '/^[ \t]*BLD_OUT_BASE/!d;s/^[ \t]*BLD_OUT_BASE[ \t:]*=[ \t]*//;s/\$(LOGNAME)/'"$LOGNAME"'/gp' Makefile-root.mk)
export BLD_OUT_BASE


## \endcond
## @ingroup libutalm_make
PACKAGE="$(sed -n 's/^[ \t]*PACKAGE[ \t:]*=[ \t]*//p' Makefile-version.mk)"
## \cond
export PACKAGE


## \endcond
## @ingroup libutalm_make
VERSION="$(sed -n 's/^[ \t]*VERSION[ \t:]*=[ \t]*//p' Makefile-version.mk)"
## \cond
export VERSION


## \endcond
## @ingroup libutalm_make
VARIANT="$(sed -n 's/^[ \t]*VARIANT[ \t:]*=[ \t]*//p' Makefile-version.mk)"
## \cond
export VERSION


## \endcond
## @ingroup libutalm_make
BASE="${BLD_OUT_BASE}/bld/${PACKAGE}-${VERSION}/"
## \cond
export BASE


## \endcond
## @ingroup libutalm_make
TMP="$(sed -n 's/^[ \t]*TMP[ \t:]*=[ \t]*//p' Makefile-root.mk)"
## \cond
export TMP

if [ -z "$MANPATH_ORG" ];then
## \endcond
## @ingroup libutalm_make
MANPATH_ORG="$MANPATH"
## \cond
fi

## \endcond
## @ingroup libutalm_make
MANPATH="${PWD}/doc/${OUTLANG}/man:${HOME}/doc/${OUTLANG}/man:$MANPATH_ORG"
## \cond
if [ -e "$PWD/src" ];then
MANPATH="${BASE}doc-tmp/${VARIANT}/doc/${OUTLANG}/man:${MANPATH}"
fi
export MANPATH

## \endcond
## @ingroup libutalm_make
TSTBASE="${BLD_OUT_BASE}/bld/${PACKAGE}-${VERSION}/tst-tmp/"
## \cond
export TSTBASE

## \endcond
## @ingroup libutalm_make
TSTREF="${BLD_OUT_BASE}/bld/${PACKAGE}-${VERSION}/tstref-tmp/"
## \cond
export TSTREF

## \endcond
## @ingroup libutalm_make
TSTCALLROOT=""
## \cond
export TSTCALLROOT
## \endcond
