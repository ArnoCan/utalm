# UnifiedTraceAndLogManager #

Modern software systems and application are commonly written in multiple languages, include scripting engines, and are frequently build on multiple specialized frameworks and middleware for a considerable diversity of runtime environments.
The latest influencing update in development paradigm is the application of multicore processors.
This projects is aimed to unify the required trace and logging output and integrate into debugging environments.
The target is to provide general development, test, and production support of software environments based on multiple programming languages for distributed multicore environments.


## utalm-bash ##
This package **UnifiedTraceAndLogManager-bash** contains the support for bash scripting, refer to versions and variants for additional options.


The main logging and debugging library of the **utalm-bash** for **bash** support is called **libutalm.sh** provides for internal control as well as for command line call integration by default via **-d <debug-suboptions>** option.
A number of suboptions control the behaviour and scope of than activated debugging and logging.
This ranges from debug levels - either by numeric or symbolic names - for various severities with specific level adjustment - **DEBUG**, **INFO**, **WARNING**, and **ERROR**.
Where the severities are colored by default for ANSI terminal emulation.
In addition some enhanced features like tracing within specific files and line-ranges is supported.
The log records and control of output could be controlled widely by call parameters.
The debugging also integrates seamless into the syslog.

Adds Makefile-libraries for founding a common build platform of all supported UTALM components.

The main feature is the support of a common interface for the debugging and logging of operational data in a environment of multiple programmning languages.
The emphasis is here on distributed environments.

This is the **bash** edition, the included subcomponents are:

* utalm-bash
* utalm-awk
* utalm-make


Current online manuals are available at:
[UTALM@UnifiedSessionsManager.org](http://www.unifiedsessionsmanager.org/en/OpenSource/projects/utalm/utalm-bash/03_03_003/doc/en/html/man3/utalm-API/index.html)

Long: "http://www.unifiedsessionsmanager.org/en/OpenSource/projects/utalm/utalm-bash/03_03_003/doc/en/html/man3/utalm-API/index.html"


**Installation**:
***Package - rpm - recommended***

* Download rpm
* Install rpm, default is "/usr/share/utalm-bash-<version>.<arch>"
* Change to "/usr/share/utalm-bash-<version>.<arch>"
* Source ". sourceEnvironment.sh"
* Call "./install.sh"
* Change to your HOME directory
* Source now your local ". sourceEnvironment.sh"
* Call: "utalmhelp.sh"  and/or "utalmhelp.sh api" and/or "utalmhelp.sh intro" 


***Package - rpm-devel - recommended***

* Download rpm-devel
* Install rpm-devel, default is "/usr/share/utalm-bash-devel-<version>.<arch>"
* Change to "/usr/share/utalm-bash-<version>.<arch>"
* Source ". sourceEnvironment.sh"
* Call "./install-devel.sh"
* Change to your HOME directory
* Source now your local ". sourceEnvironment.sh"
* Call: "utalmhelp.sh" and/or "utalmhelp.sh api"
* Change to your HOME/tests directory
* Call: "**make unit**" has to result in "**utalm_sum_of_errors:0**"
  For additional info on test refer to 
  * **utalm-API**
  * **Make help**
  * **utalmhelp.sh utalm-bash-tests**
  * **utalmhelp.sh utalm-make-API**
  * **countErrors.sh --help**
  * **testCaseStatistics.sh --help**
  * **testCaseStatistics.sh**
  * **testCaseStatistics.sh --groups**


***Package - tgz***

* Download tgz
* Unpack tgz.
* Call install.sh in main directory.
  Installs in home-directory. The files.conf 
  and directories.conf contain a list of changes.

***Package - tgz-devel***

* Download tgz
* Unpack tgz.
* Call install.sh in main directory.
  Installs in home-directory. The files.conf 
  and directories.conf contain a list of changes.

***Sources***

* Download zip-file, or clone from github.
* Call **make**, or **make help**.
* Install **tgz** file or **rpm** file.
* Read man pages in $HOME/doc/{pdf,html,man}/{man3,man7}

**Build**

* Install sources.
* Change into install root and call make
  Get help with "make help"

***Intro***

For first help call from install root: "utalmhelp.sh".
