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
#
# Nodewalk is an abstract make module, which navigates downward thres a
# inverted treestructure, passing each branch and touching each leaf once. 
# The path resolution is from left first, downward from leftmost first.
# Thus the order of reachin terminating leafs and executing the foreseen 
# action is the lowest level of the leftmost subtree first, following the
# next lowest level, and so on. Each subtree is finalised by performing 
# actions on their intersetion point.  
#
#
#
## \endcond
## @file
## \cond

ifndef _MAKE_NODEWALK_NODEACTION_TESTS_INCLUDED_
_MAKE_NODEWALK_NODEACTION_TESTS_INCLUDED_:=1

#NODEACTIONONLY=1
#all: outdirs $(SUB_POOLS)

include $(BLD_ROOT)lib/Makefile.lib/Makefile-test.mk
include $(BLD_ROOT)lib/Makefile.lib/Makefile-test.mk


endif #_MAKE_NODEWALK_NODEACTION_TESTS_INCLUDED_
## \endcond
