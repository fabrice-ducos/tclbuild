# tclbuild 0.1.10

A build project for building Tcl/Tk and many popular Tcl/Tk packages from sources

IT IS NOT A REPLACEMENT FOR ActiveState Tcl.
If you need a production-ready, stable version of Tcl, it's probably better to rely on commercially supported packages such as ActiveState's.

tclbuild's goal is to automatically download stable sources of several popular packages and compile them on your system with your available compiler, instead of relying on precompiled binaries.

It provides native and JVM builds for Tcl. For the JVM builds, it uses Jaclin, a TclJava fork from tclbuild's author, that supports recent versions of the JDK (JDK 10 and newer, with support for JDK 4- dropped).

*The JVM builds with modern JDK are a unique feature of tclbuild (not available in other Tcl distributions)*.

This is a work in progress and still experimental.
It should work on any Unix-like system (Linux, BSD, OSX) with a Java Development Kit installed.
Windows native is not supported for the moment, but a workaround is to use Cygwin or a Linux image on Windows (on Windows 10+).

## To get started

### For the impatient

Just type `make`
All what you need (binaries, libraries, header files) will be created in the `local` directory.
Especially, you can find the binaries under `local/bin`.

You can copy the directories wherever you need (e.g. under `/usr/local`).
`tclbuild` doesn't currently perform an automatic installation in system directories to avoid overwriting a working installation.

### If you need more control

Edit `build.cfg`:
  - set the desired versions for the tools.
  - edit the TARGETS variable with the list of the needed tools.
  - edit the installation path: PREFIX

Once everything is set up, launch `make help` to see the list of available build targets, and check the configuration.

`make` will attempt to build all the targets specified in `build.cfg`

## Requirements
A modern JDK (JDK 5+)
A system with `GNU make` installed (other versions of `make` may work, but none has been tested yet)

## What is installed by default by this version of tclbuild
(these versions are known to be stable, but you can change them by editing build.cfg)

  - tcl:      tcl 8.6.9 - the core langage
  - tk:       tk 8.6.9 - the popular Tk toolkit
  - ck:       ck master - a Tk clone for the console, based on curses (currently no version tag available)
  - expect:   expect 5.45.4 - the famous Expect automation tool based on Tcl
  - tcllib:   tcllib 1.19 - standard tcl library
  - bwidget:  bwidget 1.9.13 - a cross-platform widget toolkit for Blender (currently GPL2)
  - critcl:   critcl 3.1.17 - package for on-the-fly compilation of tcl scripts
  - tclx:     tclx 8.4.2 - popular extensions for Tcl
  - jaclin:   jaclin 0.1.2 - fork of TclJava (Tcl on the JVM), with Tclblend updated for Tcl 8.6 (jtclsh 8.6 and jaclsh 8.0)

## TODO
Test on various Linux and BSD distributions
Port on Windows native (.bat, nmake)
