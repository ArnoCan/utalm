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
ifndef BLD_ROOT_POST_INCLUDED
BLD_ROOT_POST_INCLUDED:=1

help:
	@echo "***************************************"
	@echo
	@echo "  VERSION        = $(VERSION)"
	@echo "  PACKAGE        = $(PACKAGE)"
	@echo "  WWW_PROJ       = $(WWW_PROJ)"
	@echo "  WWW_REPO_00    = $(WWW_REPO_00)"
	@echo "  WWW_REPO_01    = $(WWW_REPO_01)"
	@echo "  WWW_REF        = $(WWW_REF)"
	@echo "  WWW_USM        = $(WWW_USM)"
	@echo
	@echo "***************************************"
	@echo
	@echo "  make help                   - display this help"
	@echo
	@echo "  make rt                     - build runtime"
	@echo "  make src                    - build sources"
	@echo "  make examples               - build documents"
	@echo "  make doc                    - build documents"
	@echo
	@echo "  TDD support"
	@echo "   make test                  - calls regression tests"
	@echo "   make testref               - calls creation of required reference data for tests"
	@echo "   make unit                  - calls unit tests"
	@echo
	@echo "   support-variables"
	@echo "     CALLTEST                 - Default call in leafs"
	@echo "     CALLTESTOPTS             - Default options"
	@echo
	@echo "     UNIT_COUNTERRORS_OPTS    - options set by make for countErros.sh"
	@echo
	@echo "  make install                - Not yet supported - use script 'install.sh'"
	@echo "  make uninstall              - Not yet supported"
	@echo
	@echo "  make pkg                    - generic packages for userland: tgz, rpm"
	@echo "  make pkg-devel              - developer package for userland: tgz-devel, rpm-devel"
	@echo "  make pkg-src                - generic source package: srctgz, srcrpm"
	@echo
	@echo "  make clean                  - clean up"
	@echo "  make distclean              - clean up, except packages"
	@echo "  make mrproper               - clean all"
	@echo
	@echo "  make outdirs                - create production tree"
	@echo
	@echo "  make createlinks            - creates elevator links - obsolet"
	@echo "  make cleanlinks             - cleans elevator links - obsolet"
	@echo
	@echo "  make help-utalm             - starts html help for developer"
	@echo
	@echo "***************************************"
	@echo
	@echo "  BASE         = $(BASE)"
	@echo "  TMP          = $(TMP)"
	@echo "  OUTDIR       = $(OUTDIR)"
	@echo "  WWWLNK       = $(WWWLNK)"
	@echo "  WWWBASE      = $(WWWBASE)"
	@echo "  DOCLNK       = $(DOCLNK)"
	@echo "  DOCBASE      = $(DOCBASE)"
	@echo "  RTLNK        = $(RTLNK)"
	@echo "  RTBASE       = $(RTBASE)"
	@echo "  TSTLNK       = $(TSTLNK)"
	@echo "  TSTBASE      = $(TSTBASE)"
	@echo "  TSTREFLNK    = $(TSTREFLNK)"
	@echo "  TSTREF       = $(TSTREF)"
	@echo
	@echo "  DBG=1"
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

help-utalm:
	firefox $${HOME}/doc/en/html/man3/utalm-bash-API/index.html

cleanlinks::
	@$(ECHO) "Clean rootlinks:bld"
	-$(RM)  -f $(OUTDIR)
	-cd $(BLD_ROOT) && $(FIND) $(ROOT_LNK_POOL) -type l -name bld -exec rm {} \;

createlinks:: cleanlinks $(OUTDIR)
	@$(ECHO) "Create rootlinks:bld"
	cd $(BLD_ROOT) && $(MK_BLD_LINKS) bld $(addprefix ./,$(ROOT_LNK_POOL))


clean:
	@echo "Cleanup..."
	@echo "**->In "$(shell echo $${PWD})
ifdef DEBUG
	@echo
	@echo "$(RMRF) $(OUTFILES)"
	@echo 
	@echo "SRC_POOL=$(SRC_POOL)"
endif
	$(RMRF) $(OUTFILES)
	for ixy in $(SRC_POOL);do echo "ixy=$${ixy}";[ -z "$${ixy}" ]&&continue;[ ! -e "$${ixy}" ]&&continue;cd $${ixy};$(MAKE) $(MFLAGS) clean;cd ->/dev/null;done
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
ifdef OUTFILES
	@echo "$(RM) -f $(OUTFILES)"
	$(RM) -f $(OUTFILES)
endif

UNIQUE_OUTDIRS:=$(shell for i in ${OUTDIRS};do echo $$i;done|sort -u)
outdirs: $(UNIQUE_OUTDIRS)


$(UNIQUE_OUTDIRS):
ifdef DBG
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

endif #BLD_ROOT_POST_INCLUDED
## \endcond
