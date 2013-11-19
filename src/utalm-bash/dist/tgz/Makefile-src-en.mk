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

CPOPTS += --parents 

IMPORT_FILES_BLD	+= $(BLD_ROOT)README.md
IMPORT_FILES_BLD	+= $(BLD_ROOT)RELEASENOTES.txt
IMPORT_FILES_BLD	+= $(BLD_ROOT)INSTALL.txt
IMPORT_FILES_BLD	+= $(BLD_ROOT)Apache-2.0.txt
IMPORT_FILES_BLD	+= $(BLD_ROOT)install.sh
IMPORT_FILES_BLD	+= $(BLD_ROOT)sourceEnvironment.sh

IMPORT_FILES_BLD	+= $(BLD_ROOT)TODO.txt
IMPORT_FILES_BLD	+= $(BLD_ROOT)collect-filelist.sh

#
IMPORT_FILES_BLD	+= $(BLD_ROOT)include/Makefile-root.mk
IMPORT_FILES_BLD	+= $(BLD_ROOT)include/Makefile-version.mk

#
IMPORT_DIRS_RTBASE	+= $(RTBASE)conf

IMPORT_DIRS_RTBASE	+= $(RTBASE)doc/css
IMPORT_DIRS_RTBASE	+= $(RTBASE)doc/images
IMPORT_DIRS_RTBASE	+= $(RTBASE)doc/js

IMPORT_FILES_RTBASE	+= $(RTBASE)doc/$(OUTLANG)/gwiki/man3/utalm-awk.gwiki
IMPORT_FILES_RTBASE	+= $(RTBASE)doc/$(OUTLANG)/gwiki/man3/utalm-bash.gwiki
IMPORT_FILES_RTBASE	+= $(RTBASE)doc/$(OUTLANG)/html/man3/utalm-awk.html
IMPORT_FILES_RTBASE	+= $(RTBASE)doc/$(OUTLANG)/html/man3/utalm-bash.html
IMPORT_DIRS_RTBASE	+= $(RTBASE)doc/$(OUTLANG)/html/man3/utalm-API
IMPORT_DIRS_RTBASE	+= $(RTBASE)doc/$(OUTLANG)/html/man3/utalm-awk-API
IMPORT_DIRS_RTBASE	+= $(RTBASE)doc/$(OUTLANG)/html/man3/utalm-bash-API
IMPORT_FILES_RTBASE	+= $(RTBASE)doc/$(OUTLANG)/man/man3/utalm-awk.3
IMPORT_FILES_RTBASE	+= $(RTBASE)doc/$(OUTLANG)/man/man3/utalm-bash.3
IMPORT_FILES_RTBASE	+= $(RTBASE)doc/$(OUTLANG)/pdf/man3/utalm-awk.pdf
IMPORT_FILES_RTBASE	+= $(RTBASE)doc/$(OUTLANG)/pdf/man3/utalm-bash.pdf
IMPORT_FILES_RTBASE	+= $(RTBASE)doc/$(OUTLANG)/tex/man3/utalm-awk.tex
IMPORT_FILES_RTBASE	+= $(RTBASE)doc/$(OUTLANG)/tex/man3/utalm-bash.tex
IMPORT_FILES_RTBASE	+= $(RTBASE)doc/$(OUTLANG)/wiki/man3/utalm-awk.wiki
IMPORT_FILES_RTBASE	+= $(RTBASE)doc/$(OUTLANG)/wiki/man3/utalm-bash.wiki

#
IMPORT_DIRS_RTBASE	+= $(RTBASE)bin/bootstrap
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/check-if-fi-pairs.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/countErrors.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/getCPUinfo.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/getCurArch.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/getCurDistribution.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/getCurGID.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/getCurOSRel.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/getCurOS.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/getCurRelease.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/getCurUTALMRel.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/getCurUTALMVariant.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/getPathToBin.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/getPathToBootstrapDir.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/getPathToLib.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/getVMinfo.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/setversion.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/utalm-bash-cli.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)bin/utalmhelp.sh

#
IMPORT_DIRS_RTBASE	+= $(RTBASE)lib/core
IMPORT_FILES_RTBASE	+= $(RTBASE)lib/libutalm.awk
IMPORT_FILES_RTBASE	+= $(RTBASE)lib/libutalm-min.awk
IMPORT_FILES_RTBASE	+= $(RTBASE)lib/libutalm.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)lib/libutalm-min.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)lib/libutalmfileobjects.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)lib/libutalmfileobjects-min.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)lib/libutalmrefpersistency.sh
IMPORT_FILES_RTBASE	+= $(RTBASE)lib/libutalmrefpersistency-min.sh

#
IMPORT_DIRS_DOCBASE_ML	+= 

#
IMPORT_DIRS_RTBASE	+= $(RTBASE)examples

