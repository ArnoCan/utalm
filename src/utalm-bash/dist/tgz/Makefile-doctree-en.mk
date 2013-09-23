#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
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

#
#
IMGS        += $(addprefix $(TGZ_ROOT)/doc/en/images/,$(notdir $(wildcard $(DOCBASE_ML)/en/images/*.png)))

#
PKG_HLP_IMP	+= $(addprefix $(TGZ_ROOT)/help/en/,$(notdir $(wildcard $(DOCBASE_ML)/help/en/*)))

#
PKG_DOC_IMP	+= $(addprefix $(TGZ_ROOT)/doc/en/css/,$(notdir $(wildcard $(DOCBASE_ML)/en/css/*.css)))
PKG_DOC_IMP	+= $(addprefix $(TGZ_ROOT)/doc/en/js/,$(notdir $(wildcard $(DOCBASE_ML)/en/js/*.js)))

PKG_DOC_IMP	+= $(addprefix $(TGZ_ROOT)/doc/en/html/man1/,$(notdir $(wildcard $(DOCBASE_ML)/en/html/man1/libutalm-bash.html)))
PKG_DOC_IMP	+= $(addprefix $(TGZ_ROOT)/doc/en/man/man1/,$(notdir $(wildcard $(DOCBASE_ML)/en/man/man1/libutalm-bash.1)))
PKG_DOC_IMP	+= $(addprefix $(TGZ_ROOT)/doc/en/pdf/man1/,$(notdir $(wildcard $(DOCBASE_ML)/en/pdf/man1/libutalm-bash.pdf)))

PKG_DOC_IMP	+= $(addprefix $(TGZ_ROOT)/doc/en/html/man7/,$(notdir $(wildcard $(DOCBASE_ML)/en/html/man7/libutalm-bash-examples.html)))
PKG_DOC_IMP	+= $(addprefix $(TGZ_ROOT)/doc/en/man/man7/,$(notdir $(wildcard $(DOCBASE_ML)/en/man/man7/libutalm-bash-examples.7)))
PKG_DOC_IMP	+= $(addprefix $(TGZ_ROOT)/doc/en/pdf/man7/,$(notdir $(wildcard $(DOCBASE_ML)/en/pdf/man7/libutalm-bash-examples.pdf)))

