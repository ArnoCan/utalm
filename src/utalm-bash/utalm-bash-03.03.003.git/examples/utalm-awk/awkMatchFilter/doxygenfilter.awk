#C /*<!--#***HEADSTART***-->*/
#C /* \cond */
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENSE:      Apache-2.0 - code and concepts
#LICENSE:      CCL-BY-SA - specification, interfaces, and inline documentation
#
#
#***
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
#***
#
#<!-- $Header$ -->
#
#C /* \endcond */
#C /**
#C   * @name libutalm_awk
#C   * @file
#C   * @brief Match filter of check utility for of conf-endcond-pairs in file trees
#C   *
#C   * @ingroup libutalm_awk
#C   * @ingroup awkMatchFilter
#C   */
#C /* <!--/***HEADEND***/--> */
#C /* \cond #KEEP# PERSISTENT */
BEGIN                            {mx=0;c=0;}
$0~/\\cond/                      {c+=1;}
$0~/\\endcond/                   {c-=1;}

END                              {print FILENAME":"NR":"c;exit c;}

#C /* \endcond */
