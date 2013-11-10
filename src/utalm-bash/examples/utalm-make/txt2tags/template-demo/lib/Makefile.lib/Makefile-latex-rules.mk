## \cond
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-make
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
## @ingroup tagstemplateDemo
## @file
## @brief Provides rules for LaTex
##
## \cond
##
#
ifndef _LATEX_RULES_INCLUDED
_LATEX_RULES_INCLUDED:=1

$(LATEX2HTML_SINGLE_FILES): %.html: $(wildcard *.tex) $(ENV_FILES)
	export IMAGE_TYPE=png&& \
	export EXTRA_IMAGE_SCALE=0.7&& \
	latex2html \
		-dir ${HELPTMP} \
		-external_file  ${PWD}/${i%.tex} \
		-split 0 \
		-local_icons \
		-address "acue.opensource@gmail.com " \
		-contents_in_navigation \
		-short_index \
		-no_navigation  \
		-toc_depth 3 \
		-info "pre-release" \
		$(@:.html=.tex)

$(LATEX2HTML_MULTI_FILES): %.html: $(wildcard *.tex) $(ENV_FILES)
	export IMAGE_TYPE=png&& \
	export EXTRA_IMAGE_SCALE=0.7&& \
	latex2html \
		-dir ${HELPTMP} \
		-external_file  ${PWD}/${i%.tex} \
		-split 3 \
		-local_icons \
		-address "acue.opensource@gmail.com " \
		-contents_in_navigation \
		-short_index \
		-no_navigation  \
		-toc_depth 3 \
		-info "pre-release" \
		$(@:.html=.tex)

endif #_LATEX_RULES_INCLUDED
## \endcond
