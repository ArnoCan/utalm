#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENCE:      Apache-2.0
#VERSION:      03_01_002
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
ifndef BLD_ROOT_RULES_INCLUDED
BLD_ROOT_PRE_RULES_INCLUDED:=1

TXT2TAGS_OPTS =
ifndef VERBOSE
TXT2TAGS_OPTS += --quiet
endif

$(HELP_FILES): %.txt: $(wildcard *.t2t) $(ENV_FILES)
	$(TXT2TAGS) $(TXT2TAGS_OPTS) -t txt -i $(notdir $(@:.txt=.t2t))  -o $(@:.txt=.tmp)
	$(SED) -i 's_^ *DESCRIPTION_DESCRIPTION_g' $(@:.txt=.tmp)
	$(SED) -i 's_^ *OPTIONS_OPTIONS_g' $(@:.txt=.tmp)
	$(SED) -i 's_^include_%!include_g' $(@:.txt=.tmp)
	$(SED) -i "s@syntax.t2t@"$(shell pwd)"/syntax.t2t@g" $(@:.txt=.tmp)
	$(TXT2TAGS) $(TXT2TAGS_OPTS) -t txt -i $(@:.txt=.tmp)  -o $@
	$(RMRF) $(@:.txt=.tmp) 

$(MAN1_FILES): %.1: $(wildcard *.t2t) $(ENV_FILES)
	$(TXT2TAGS) $(TXT2TAGS_OPTS) -t man -i $(notdir $(@:.1=.t2t))  -o $@ --quiet

$(MAN3_FILES): %.3: $(wildcard *.t2t) $(ENV_FILES)
	$(TXT2TAGS) $(TXT2TAGS_OPTS) -t man -i $(notdir $(@:.3=.t2t))  -o $@ --quiet

$(MAN7_FILES): %.7: $(wildcard *.t2t) $(ENV_FILES)
	$(TXT2TAGS) $(TXT2TAGS_OPTS) -t man -i $(notdir $(@:.7=.t2t))  -o $@

$(HTML1_FILES) $(HTML3_FILES) $(HTML7_FILES): %.html: $(wildcard *.t2t) $(ENV_FILES)
	$(TXT2TAGS) $(TXT2TAGS_OPTS) -t html -i $(notdir $(@:.html=.t2t))  -o $@

$(PDF1_FILES) $(PDF3_FILES) $(PDF7_FILES): %.pdf: $(wildcard *.t2t) $(ENV_FILES)
	$(TXT2TAGS) $(TXT2TAGS_OPTS) -t tex --headers -i $(notdir $(@:.pdf=.t2t))  -o $(@:.pdf=.tex)
	$(SED) -i 's_..backslash._\\_g' $(@:.pdf=.tex)
	$(SED) -i 's/\\{/{/g;s/\\}/}/g' $(@:.pdf=.tex)
	$(SED) -i 's/\$$|\$$/|/g;' $(@:.pdf=.tex)
	$(SED) -i 's/\$$<\$$/</g;' $(@:.pdf=.tex)
	$(SED) -i 's/\$$>\$$/>/g;' $(@:.pdf=.tex)
	$(SED) -i '1,/ACTUAL-START/d' $(@:.pdf=.tex)
ifdef VERBOSE
	$(ECHO) "$(TEX2PDF) $(TEX2PDF_INTERACTION) -output-directory=$(dir $@) $(@:.pdf=.tex) $(TEX2PDF_ERRNULL)"
	$(ECHO) -n "1.parse:"&&$(TEX2PDF) $(TEX2PDF_INTERACTION) -output-directory=$(dir $@) $(@:.pdf=.tex) $(TEX2PDF_ERRNULL)
	$(ECHO) -n "2.parse:"&&$(TEX2PDF) $(TEX2PDF_INTERACTION) -output-directory=$(dir $@) $(@:.pdf=.tex) $(TEX2PDF_ERRNULL)
else
	$(TEX2PDF) $(TEX2PDF_INTERACTION) -output-directory=$(dir $@) $(@:.pdf=.tex) $(TEX2PDF_ERRNULL)>/dev/null
	$(TEX2PDF) $(TEX2PDF_INTERACTION) -output-directory=$(dir $@) $(@:.pdf=.tex) $(TEX2PDF_ERRNULL)>/dev/null
endif
ifeq ($(KEEPMETA),0)
	$(RMRF) $(@:.pdf=.log) $(@:.pdf=.aux) $(@:.pdf=.out) $(@:.pdf=.toc) $(@:.pdf=.lot) $(@:.pdf=.lof) $(@:.pdf=.tex)
endif

$(TXT1_FILES) $(TXT3_FILES) $(TXT7_FILES): %.txt: $(wildcard *.t2t) $(ENV_FILES)
	$(TXT2TAGS) $(TXT2TAGS_OPTS) -t txt --headers -i $(notdir $(@:.txt=.t2t))  -o $@
	
$(TEX1_FILES) $(TEX3_FILES) $(TEX7_FILES): %.tex: $(wildcard *.t2t) $(ENV_FILES)
	$(TXT2TAGS) $(TXT2TAGS_OPTS) -t tex --headers -i $(notdir $(@:.tex=.t2t))  -o $@
	$(SED) -i '1,/ACTUAL-START/d' $(@:.pdf=.tex)
	$(SED) -i 's_\$$\\backslash\$$_\\_g' $@
	$(SED) -i 's/\$$|\$$/|/g;' $@
	$(SED) -i 's/\$$<\$$/</g;' $@
	$(SED) -i 's/\$$>\$$/>/g;' $@
	$(SED) -i 's/\\{/{/g;s/\\}/}/g' $@

$(TMP_TEX_FILES): %.tex: $(wildcard *.t2t) $(ENV_FILES)
	$(TXT2TAGS) $(TXT2TAGS_OPTS) -t tex --no-headers -i $(notdir $(@:.tex=.t2t))  -o $@
	$(SED) -i 's_\$$\\backslash\$$_\\_g' $@
	$(SED) -i 's_\backslash_MATCH_g' $@
	$(SED) -i 's/\$$|\$$/|/g;' $@
	$(SED) -i 's/\$$<\$$/</g;' $@
	$(SED) -i 's/\$$>\$$/>/g;' $@
	$(SED) -i 's/\\{/{/g;s/\\}/}/g' $@

$(DOC_FILES): %.tex: $(wildcard *.t2t) $(ENV_FILES)
	$(TXT2TAGS) $(TXT2TAGS_OPTS) -t tex --no-headers -i $(notdir $(@:.tex=.t2t))  -o $@
	$(SED) -i 's_\$$\\backslash\$$_\\_g' $@
	$(SED) -i 's_\backslash_MATCH_g' $@
	$(SED) -i 's/\$$|\$$/|/g;' $@
	$(SED) -i 's/\$$<\$$/</g;' $@
	$(SED) -i 's/\$$>\$$/>/g;' $@
	$(SED) -i 's/\\{/{/g;s/\\}/}/g' $@

$(DVI_FILES): %.dvi: $(wildcard *.tex) $(ENV_FILES)
	$(ECHO) -n "1.parse:"&&$(LATEX) $(TEX2PDF_INTERACTION) -output-directory=$(dir $@) $(@:.dvi=.tex) $(TEX2PDF_ERRNULL)
ifeq ($(KEEPMETA),0)
	$(RMRF) $(@:.pdf=.log) $(@:.pdf=.aux) $(@:.pdf=.out) $(@:.pdf=.toc) $(@:.pdf=.lot) $(@:.pdf=.lof) $(@:.pdf=.tex)
endif

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

$(WIKI1_FILES) $(WIKI3_FILES) $(WIKI7_FILES): %.wiki: $(wildcard *.t2t) $(ENV_FILES)
	$(TXT2TAGS) $(TXT2TAGS_OPTS) -t wiki --headers -i $(notdir $(@:.wiki=.t2t))  -o $@
	

$(GWIKI1_FILES) $(GWIKI3_FILES) $(GWIKI7_FILES): %.gwiki: $(wildcard *.t2t) $(ENV_FILES)
	$(TXT2TAGS) $(TXT2TAGS_OPTS) -t gwiki --headers -i $(notdir $(@:.gwiki=.t2t))  -o $@
	

endif
