#HEADSTART##############################################################
#
#PROJECT:      UnifiedTraceAndLogManager
#AUTHOR:       Arno-Can Uestuensoez - acue.opensource@gmail.com
#MAINTAINER:   Arno-Can Uestuensoez - acue.opensource@gmail.com
#SHORT:        utalm-bash
#LICENCE:      Apache-2.0
#VERSION:      01_02_001
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
Source:%{mytgzname}
URL: %{myurl}
Distribution: %{myname}
Vendor: %{myvendor}
Packager: %{mypackager}

BuildRoot: /tmp/rpm/%{mytgzname}
ExclusiveOS: Linux

#Prefix: /usr/share
Prefix: /opt/tracelogger

#Requires:


%description
The 'bash' variant of UnifiedTraceAndLogManager provides th components for 
debugging and production time  logging of the UnifiedTraceAndLogManager
project.  

For additional information and first steps after installation
the following options are available:

1. Install the package and set the following paths:
   PATH=$PATH:<Prefix>/bin
   
   Use in your scripting code:
     '. <Prefix>/lib/libtracelogger.sh
 
   By default:
      <Prefix>:=/opt/tracelogger

2. When a local user installation is required just copy the
   tgz-file into your home directory and unpack it.

	cd $HOME
	cp libutalm-bash-02.01.001.tgz
	tar zxf libutalm-bash-02.01.001.tgz   


%prep
%setup -n %{myname}-%{myversion}

%build

%install
INSTBASE=${RPM_BUILD_ROOT}/opt
INSTTARGET=${INSTBASE}/libutalm-bash-${RPM_PACKAGE_VERSION}

echo ${VARIANT_ROOT}/redhat
rm -rf ${INSTTARGET}
mkdir -p ${INSTBASE}
pwd
tar -C ${INSTBASE} -zxf %{mytgzpname}
chmod -R 755 ${INSTTARGET}

%post

%postun

%files
%defattr(-,root,root)

/opt/%{myname}-%{myversion}

%clean
rm -rf ${RPM_BUILD_ROOT}

%changelog
* Tue Sep 15 2013 Arno-Can Uestuensoez <acue.opensource@gmail.com>
- Version-02.01.001

