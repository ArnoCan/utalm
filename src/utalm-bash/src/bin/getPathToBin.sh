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
## @ingroup utalm_bash
## @file
## @brief returns absolute path for requested executable
##
## Search order:
##   1 PWD
##   2 PATH
##   3 HOME/bin
##   3 /usr/bin
## 
## When no argument is provided the first existing bin
## directory is provided.
## \cond
##
#
[[ -e "${0%/*}/$1" ]]&&{ echo -n "${0%/*}${1:+/$1}"&&exit 0 ; }
for i in ${PATH//:/ };do
	[[ -e "${i}/$1" ]]&&{ echo -n "${i}${1:+/$1}"&&exit 0 ; }
done
[[ -e "${HOME}/bin/$1" ]]&&{ echo -n "${HOME}/bin${1:+/$1}"&&exit 0 ; }
[[ -e "/usr/bin/$1" ]]&&{ echo -n "/usr/bin${1:+/$1}"&&exit 0 ; }
exit 1
## \endcond
