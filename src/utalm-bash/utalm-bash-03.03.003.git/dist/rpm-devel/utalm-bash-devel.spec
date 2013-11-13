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
#HEADEND################################################################
#
#$Header$
#
Summary: Trace and Logging for bash
Name: %{myname}
Version: %{myversion}
Release:%{myrelease}
License: %{mylicense}
Group: Development/Libraries
Source:%{mytgzfilename}
URL: %{myurl}
Distribution: %{myname}
Vendor: %{myvendor}
Packager: %{mypackager}

#BuildRoot: /tmp/rpm/%{mytgzname}
#BuildRoot: %{_tmppath}/%{mytgzname}
BuildRoot: %{_tmppath}/%{mytgzfilename}

BuildArch: noarch
BuildRequires: bash, make, gawk
#BuildRequires: python
ExclusiveOS: Linux

Prefix: /usr/share

Requires: coreutils , make >= 3, utalm-bash = %{myversion} 
Provides: utalm-make


%description
The 'bash' variant of UnifiedTraceAndLogManager provides the components for 
debugging and production time  logging of the UnifiedTraceAndLogManager
project.  

For additional information and first steps after installation
the following options are available:

1. Install the package and set the following paths:
   PATH=$PATH:<Prefix>/bin
   
   Use in your scripting code:
     '. <Prefix>/lib/libutalm.sh
   or
     '. <Prefix>/lib/libutalm-min.sh
 
   By default:
      <Prefix>:=/usr/share

2. When a local user installation is required just copy the
   tgz-file into your home directory and unpack it.

	cd $HOME
	cp utalm-bash-03.03.003-R0.noarch.tgz
	tar zxf utalm-bash-03.03.003-R0.noarch.tgz   


%prep
#%setup -n %{myname}-%{myversion}.%{_target_cpu}
%setup -n %{mytgzname}

%build

%install
#INSTBASE=${RPM_BUILD_ROOT}/usr/share
#INSTTARGET=${INSTBASE}/%{myname}-${RPM_PACKAGE_VERSION}.%{_target_cpu}
INSTBASE=${RPM_BUILD_ROOT}/usr/share
#INSTTARGET=${INSTBASE}/utalm-bash-${RPM_PACKAGE_VERSION}.%{_target_cpu}
INSTTARGET=${INSTBASE}/%{mydirname}

#echo ${VARIANT_ROOT}/redhat
#rm -rf ${INSTTARGET}
#mkdir -p ${INSTBASE}
#tar -C ${INSTBASE} -zxf %{mytgzpname}
#chmod -R 755 ${INSTTARGET}
echo ${VARIANT_ROOT}/redhat
rm -rf ${INSTTARGET}
mkdir -p ${INSTBASE}
echo "INSTBASE=${INSTBASE}"

tar -C ${INSTBASE} -zxf %{mytgzpname} 
chmod -R 755 ${INSTTARGET}

%post

%postun

%files
%defattr(-,root,root)

#/usr/share/%{myname}-%{myversion}.%{_target_cpu}
/usr/share/%{mydirname}

%clean
rm -rf ${RPM_BUILD_ROOT}

%changelog
* Thu Nov 10 2013 Arno-Can Uestuensoez <acue.opensource@gmail.com>
- Version-03.03.003
  Major updates and fixes, probably for eternity.
  
* Thu Nov 08 2013 Arno-Can Uestuensoez <acue.opensource@gmail.com>
- Version-03.03.001
  Major updates and fixes, probably for eternity.
  
* Sat Sep 21 2013 Arno-Can Uestuensoez <acue.opensource@gmail.com>
- Version-03.03.003

* Tue Sep 15 2013 Arno-Can Uestuensoez <acue.opensource@gmail.com>
- Version-02.01.001

