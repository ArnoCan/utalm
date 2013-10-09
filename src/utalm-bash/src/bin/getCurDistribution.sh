#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENCE:      Apache-2.0
#VERSION:      03_02_002
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

#FUNCBEG###############################################################
#NAME:
#  getCurDistribution.sh
#
#TYPE:
#  generic-script
#
#DESCRIPTION:
#  Used during bootstrap of each call to get current distribution.
#
#EXAMPLE:
#
#PARAMETERS:
#
#OUTPUT:
#  RETURN:
#  VALUES:
#
#FUNCEND###############################################################

CALLDIR=`dirname $0`

CUROS=`${CALLDIR}/getCurOS.sh`
CURDIST=;
case $CUROS in
  Linux) 
        #Tested for:MeeGo-1.0.0
	if [ -z "$CURDIST" -a -f /etc/meego-release ];then
	    CURDIST=MeeGo
	fi

        #Tested for:CentOS 5
        #Tested for:Scientific Linux 5
        #Tested for:Fedora 8
	if [ -z "$CURDIST" -a -f /etc/redhat-release ];then
	    CURDIST=`cat /etc/redhat-release|head -n 1|awk '{print $1;}'`
	fi

	#Tested for Oracle-Entreprise Linux 5
        #Tested for VMware-ESX-4.1.0
        #Tested for RHEL 5.5 and 6.0
	if [ -n "$CURDIST" -a  "$CURDIST" == Red ];then
	    CURDIST=""
 	    if [ -f /etc/redhat-release ];then
		CUROSREL=`${CALLDIR}/getCurOSRel.sh`
		if [ "${CUROSREL//ESX}" != "${CUROSREL}"  ];then
                    #Tested for VMware-ESX-4.1.0
		    CURDIST=ESX
		else
		    if [ -e /usr/share/doc/oracle-logos* ];then
	                #Tested for Oracle-Entreprise Linux 5
			CURDIST="EnterpriseLinux"
		    else
			if [ -e /usr/share/doc/redhat-logos*/COPYING ];then
			    grep -s "RED HAT" /usr/share/doc/redhat-logos-*/COPYING>/dev/null
			    if [ $? -eq 0 ];then
 	                        #Tested for RedHat Enterprise Linux 5.5 / 6.0
				CURDIST="RHEL"
			    fi			
			fi
		    fi
		fi
	    fi
	fi

        #Tested for:SuSE 9.3+10.3
	if [ -z "$CURDIST" -a -f /etc/SuSE-release ];then
	    CURDIST=`cat /etc/SuSE-release|head -n 1|awk '{print $1;}'`
	fi

        #Tested for:
        #debian 4.0r3,
        #debian 5.0.0,
        #debian 5.0.6,
        #Ubuntu 6.06,
        #Ubuntu 8.04,
        #Ubuntu 9.10,
        #Ubuntu 10.10,
        #Knoppix 6.2 + 6.2.1
	if [ -z "$CURDIST" -a -f /etc/debian_version ];then
	    if [ ! -f /etc/lsb-release ];then
		#check now for Knoppix vs. debian
		X=$(uname -a)
		if [ "${X//oppix}" != "$X" -o -f "/etc/syslog-knoppix.conf" ];then
		    CURDIST="Knoppix"
		else
		    CURDIST="debian"
		fi
	    else
		CURDIST=`awk -F'=' '/DISTRIB_ID/{printf("%s",$2);}' /etc/lsb-release`
		if [ -z "$CURDIST" ];then
		    CURDIST="debian-variant"
		fi
	    fi
	fi

        #Might work for more ...
	if [ -z "$CURDIST" ];then
	    CURF=`ls -1 /etc/*-release 2>/dev/null|grep -v 'lsb-release'`
	    if [ $? -eq 0  ];then
		CURDIST=`cat ${CURF}|head -n 1|awk '{print $1;}'`
		case ${CURDIST} in
#		    Gentoo)
#			;;
		    *)
			CURDIST="Linux_generic"
			;;
		esac
	    fi
	fi
	;;
  FreeBSD|OpenBSD)
	CURDIST="${CUROS}"
	;;
  SunOS)
	CURDIST="${CUROS}"
	if [ -f /etc/release ];then
	    grep  'OpenSolaris' /etc/release >/dev/null 2>/dev/null
	    if [ $? -eq 0 ];then
		CURDIST=OpenSolaris
	    fi
	fi
	;;
  CYGWIN*)
	CURDIST="CYGWIN"
	;;

  *)
	CURDIST="${CUROS}_generic"
        ;;
esac
[ -n "$_DBG_" ]&&echo "CURDIST=${CURDIST}" >&2


echo -n ${CURDIST}
