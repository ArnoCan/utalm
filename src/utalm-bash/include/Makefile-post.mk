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
ifndef BLD_ROOT_POST_INCLUDED
BLD_ROOT_POST_INCLUDED:=1

_all:all

help:
	@echo "***************************************"
	@echo
	@echo "  VERSION        = $(VERSION)"
	@echo "  PACKAGE        = $(PACKAGE)"
	@echo "  WWW_PROJ       = $(WWW_PROJ)"
	@echo "  WWW_REPOS      = $(WWW_REPOS)"
	@echo "  WWW_REF        = $(WWW_REF)"
	@echo "  WWW_USM        = $(WWW_USM)"
	@echo
	@echo "***************************************"
	@echo
	@echo "  make help        - display this help"
	@echo
	@echo "  make rt          - build runtime"
	@echo "  make doc         - build documents"
	@echo
	@echo "  make tgz         - generic package for userland"
	@echo "  make rpm         - RHEL and derived"
	@echo "  make deb         - Debian and derived"
	@echo
	@echo "  make clean       - clean up"
	@echo "  make distclean   - clean up, except packages"
	@echo "  make mrproper    - clean all"
	@echo
	@echo "  make outdirs     - create production tree"
	@echo
	@echo "  make createlinks - creates elevator links"
	@echo "  make cleanlinks  - cleans elevator links"
	@echo
	@echo
	@echo "  BASE             = $(BASE)"
	@echo "  TMP              = $(TMP)"
	@echo "  OUTDIR           = $(OUTDIR)"
	@echo "  WWWLNK           = $(WWWLNK)"
	@echo "  WWWBASE          = $(WWWBASE)"
	@echo "  DOCLNK           = $(DOCLNK)"
	@echo "  DOCBASE          = $(DOCBASE)"
	@echo "  RTLNK            = $(RTLNK)"
	@echo "  RTBASE           = $(RTBASE)"
	@echo
	@echo "  VERBOSE=1"
	@echo "  ERRSTOP=1"
	@echo "  KEEPMETA=1"
	@echo
	@echo "  INTERNAL=1"
	@echo "     Creates private components"
	@echo
	@echo
	@echo "  VARIANT=<variant>"
	@echo "    RELEASE"
	@echo "    BETA"
	@echo "    ALPHA"
	@echo "    NIGHTLY"
	@echo
	@echo "    SUPPORT"
	@echo
	@echo "    ALL"
	@echo

#### filesystem

cleanlinks::
	@$(ECHO) "Clean rootlinks:bld"
	-$(RM)  -f $(OUTDIR)
	-cd $(BLD_ROOT) && $(FIND) $(ROOT_LNK_POOL) -type l -name bld -exec rm {} \;

createlinks:: cleanlinks $(OUTDIR)
	@$(ECHO) "Create rootlinks:bld"
	cd $(BLD_ROOT) && $(MK_BLD_LINKS) bld $(addprefix ./,$(ROOT_LNK_POOL))


clean:
	@echo "Cleanup..."
#	@echo "**->In "$(shell echo $${PWD##*/})
	@echo "**->In "$(shell echo $${PWD})
ifdef OUTFILES
	@echo
	@echo "$(RMRF) $(OUTFILES)"
	$(RMRF) $(OUTFILES)
endif
ifdef SRC_POOL
	@echo 
	@echo "SRC_POOL=$(SRC_POOL)"
	for ixy in $(SRC_POOL);do echo "ixy=$${ixy}";[ -z "$${ixy}" ]&&continue;[ ! -e "$${ixy}" ]&&continue;cd $${ixy};$(MAKE) $(MFLAGS) clean;cd ->/dev/null;done
endif
	@echo
	@echo "...finished:"$(shell echo $${PWD##*/})
	@echo

distclean: 
	@echo "Clean complete build meta-output."
	@echo "$(RMRF) $(BASE)"
	$(RMRF) $(BASE)
	@echo "$(RM) $(OUTDIR)"
	$(RM) -f $(OUTDIR)

mrproper: distclean
	@echo "Clean complete build output."
	@echo "$(RM) -f $(OUTFILES)"
	$(RM) -f $(OUTFILES)

#UNIQUE_OUTDIRS=$(dir ${OUTDIRS})
UNIQUE_OUTDIRS:=$(shell for i in ${OUTDIRS};do echo $$i;done|sort -u)
outdirs: $(UNIQUE_OUTDIRS)
#	echo "OUT=$(OUTDIR)"
#	echo "OUTDIRS=$(OUTDIRS)"


$(UNIQUE_OUTDIRS):
ifdef VERBOSE
	@echo "MKDIR:$@"
endif
	$(MKDIR) $@
	$(CHMOD) 755 $@

$(OUTDIR):	
	@echo "Remove outlinks..."
	@echo "->$(OUTDIR)"
	-$(RM) -f $(OUTDIR)
	@echo "Re-Create outlinks..."
	@echo "->$(BASE) => $(OUTDIR)"
	-$(LNS) $(BASE) $(OUTDIR)


# clean:
# 	@echo "Cleanup..."

.SILENT:
.PHONY: all help clean distclean


ifneq ($(VARIANT),ALL)
ifneq ($(VARIANT),INTERNAL)
ifneq ($(VARIANT),SUPPORT)
ifneq ($(VARIANT),RELEASE)
ifneq ($(VARIANT),NIGHTLY)
ifneq ($(VARIANT),ALPHA)
ifneq ($(VARIANT),BETA)
  $(info  "Available VARIANT={ ALL | RELEASE | SUPPORT | BETA | ALPHA | NIGHTLY | INTERNAL }")
  $(error "Unknown VARIANT=" $(VARIANT))
endif
endif
endif
endif
endif
endif
endif

endif
