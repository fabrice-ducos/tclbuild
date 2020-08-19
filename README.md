# TacTCL 0.2.5
(pronounce "tactical")

A small, free Tcl/Tk distribution with some popular Tcl/Tk packages built from sources (it can be increased later on demand).

IT IS NOT A REPLACEMENT FOR ActiveState Tcl.
If you need a production-ready, stable version of Tcl, it's probably better to rely on commercially supported packages such as ActiveState's.

TacTCL's goal is to automatically download stable sources of several popular packages and compile them on your system with your available compiler, instead of relying on precompiled binaries.

It provides native and JVM builds for Tcl. For the JVM builds, it uses Jaclin, a TclJava fork from TacTCL's author, that supports recent versions of the JDK (JDK 10 and newer, with support for JDK 4- dropped).

*The JVM builds with modern JDK and last versions of Tcl (8.6 with TclOO support) are a unique feature of TacTCL (currently not available in other Tcl distributions)*.

*Properly used, they can provide a safe environment with a server-side Java security manager, and Safe Tcl running on the JVM for the controlled execution of untrusted scripts (with smooth communication between Java and Tcl layers)*

This is a work in progress and still experimental (contributors are welcome).
It should work on any Unix-like system (Linux, BSD, OSX) with a Java Development Kit installed.
Windows native is not supported for the moment, but a workaround is to use Cygwin or a Linux image on Windows (on Windows 10+).

## To get started

### For the impatient

Just type `make`
The sources from stable versions will be downloaded and compiled, and all what you need (binaries, libraries, header files) will be created in the `local` directory.
Especially, you will find the binaries under `local/bin`.

You can copy the directories wherever you need (e.g. under `/usr/local`).
`TacTCL` doesn't currently perform an automatic installation in system directories to avoid overwriting a working installation.

You can test jtclsh and jaclsh (the JVM Tcl interpreters from Tclblend and Jacl) with these commands:

```
$ ./local/bin/jtclsh 
% puts $tcl_version
8.6
```

```
$ ./local/bin/jaclsh 
% puts $tcl_version
8.0
```

### To get a more user's friendly tcl shell
(currently recognized by tclsh and jtclsh but not by jaclsh):

`cp tclshrc $HOME/.tclshrc # don't forget the dot in the target`

Edit the first line (lappend autopath) of `$HOME/.tclshrc` to the proper path of the Tcl package root on your system
(this must be currently done manually; this should be improved later)

### If you need more control

Edit `build.cfg`:
  - set the desired versions for the tools
  - comment or uncomment the TARGETS lines depending on the needed tools
  - edit the installation path: PREFIX

Once everything is set up, launch `make help` to see the list of available build targets, and check the configuration.

`make` will attempt to build all the targets specified in `build.cfg`

## Requirements
  - A modern JDK (JDK 5+)
  - A system with `GNU make` installed (other versions of `make` may work, but none has been tested yet)

## What is installed by default by this version of TacTCL
(these versions are known to be stable, but you can change them by editing build.cfg)

  - tcl:      tcl 8.6.9 - the core langage
  - tk:       tk 8.6.9 - the popular Tk toolkit
  - ck:       ck master - a Tk clone for the console, based on curses (currently no version tag available)
  - tclreadline: tclreadline 2.3.8 - a command line interpreter facility for tcl (syntax highlighthing and history-aware interpreter)
  - expect:   expect 5.45.4 - the famous Expect automation tool based on Tcl
  - tcllib:   tcllib 1.19 - standard tcl library
  - bwidget:  bwidget 1.9.13 - a cross-platform widget toolkit for Blender (currently GPL2)
  - critcl:   critcl 3.1.17 - package for on-the-fly compilation of tcl scripts
  - tclx:     tclx 8.4.2 - popular extensions for Tcl
  - jaclin:   jaclin 0.1.2 - TclJava fork (Tcl on the JVM), with Tclblend updated for Tcl 8.6 (jtclsh 8.6 and jaclsh 8.0)

## Systems for which TacTCL has been successfully tested (a JDK 5+ is required for TclJava/Jaclin):
  - Linux Mint 4.10.0-38 (should probably work on most Linux systems too)
  - MacOSX 10.15.3 (except for wish8.6, see the Known bugs section)
  - JDK 9 and 12 (all JDK starting from 5 should be supported, but let the maintainers know otherwise)

## Known bugs
  - MacOSX 10.15.3: wish8.6 currently fails to load because of a link error (non Tk interpreters work)

## TODO
  - Test on various Linux and BSD distributions
  - Port on Windows native (.bat, nmake)
