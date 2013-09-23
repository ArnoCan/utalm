# UnifiedTraceAndLogManager #

Modern software systems and application are commonly written in multiple languages, include scripting engines, and are frequently build on multiple specialized frameworks and middleware for a considerable diversity of runtime environments.
The latest influencing update in development paradigm is the application of multicore processors.
This projects is aimed to unify the required trace and logging output and integrate into debugging environments.
The target is to provide general development, test, and production support of software environments based on multiple programming languages for distributed multicore environments.


## Library Components ##

### UTALM Components ###
The UTALM supports a number of common programming languages, this comprises interpreted and compiled languages.
Examples are C/C++, Erlang, Hadoop, Java, JavaScript, MongoDB, MySQL, Perl, PHP, PowerShell, Ruby, Scala,
SQL, and SQLite. Additional handling and visualization plugins are available for Eclipse, and VisualStudio.


### utalm-bash ###
This package **UnifiedTraceAndLogManager-bash** contains the support for bash scripting, refer to versions and variants for additional options.


The main logging and debugging library of the **utalm-bash** for **bash** support is called **libutalm.sh** provides for internal control as well as for command line call integration by default via **-d <debug-suboptions>** option.
A number of suboptions control the behaviour and scope of than activated debugging and logging.
This ranges from debug levels - either by numeric or symbolic names - for various severities with specific level adjustment - **DEBUG**, **INFO**, **WARNING**, and **ERROR**.
Where the severities are colored by default for ANSI terminal emulation.
In addition some enhanced features like tracing within specific files and line-ranges is supported.
The log records and control of output could be controlled widely by call parameters.
The debugging also integrates seamless into the syslog.

The main feature is the support of a common interface for the debugging and logging of operational data in a environment of multiple programmning languages.
The emphasis is here on distributed environments.

This is the **bash** edition.

**Installation**:
* Download zip-file, or clone from github.
* Call **make**, or **make help**.
* Install **tgz** file or **rpm** file.
* Read man pages in $HOME/doc/{pdf,html,man}/{man1,man7}


