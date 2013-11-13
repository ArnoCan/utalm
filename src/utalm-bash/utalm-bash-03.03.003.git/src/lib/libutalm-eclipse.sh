## \cond
#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
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
##
## @file
## @brief NOT TESTED - EXPERIMENTAL: Integration of the SourceForge Project BashEclipse
##
## This module is for integration purposes of the project BashEclipse
## from Sourcefforge.net - http://sourceforge.net/projects/basheclipse/
## by Alex Kosinsky/http://sourceforge.net/users/avkosinsky
## 
## For detailed information on <b>libutalm-eclipse.sh</b> refer to 
## <b><a href="http://sourceforge.net/projects/basheclipse/">BashEclipse</a></b>
## and 
## <b><a href="../../man3/utalm-make.html">libutalm-eclipse(3)</a></b>
## \cond
##
#
if [ -z "$__ImportFromBashEclipse__" ];then #*** prevent multiple inclusion
__ImportFromBashEclipse__=1 #*** prevent multiple inclusion



## \endcond
#P ##
#P # Fetch argv
#P #
#P #  Returns wheter debug level matches. If some specific
#P #  actions to be done. E.g. evaluating time-intensive
#P #  debug actions for tests.
#P #
#P #	doDebug <subsys> <dbg-level> <line> <file>
#P #
#P def doDebug():
#P 	pass
## \cond
#***FUNCEND***
function initBashEclipse () {
	exec 33<>/dev/tcp/localhost/33333
	function _________DEBUG_TRAP ()
	{
		local _________DEBUG_COMMAND
		read -u 33 _________DEBUG_COMMAND
		eval $_________DEBUG_COMMAND
	}
	set -o functrace
	trap _________DEBUG_TRAP DEBUG
}
if 

fi #*** _ImportFromBashEclipse_
## \endcond
