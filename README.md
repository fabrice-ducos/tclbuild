# tclbuild 0.1.8

A build project for building Tcl/Tk and many popular Tcl/Tk packages from sources

IT IS NOT A REPLACEMENT FOR ActiveState Tcl.
If you need a production-ready, stable version of Tcl, it's probably better to rely on commercially supported packages such as ActiveState's.

tclbuild's goal is to automatically download latest sources of several popular packages and compile them on your system with your available compiler, instead of relying on precompiled binaries.

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

## TODO
Test on various Linux and BSD distributions
Port on Windows native (.bat, nmake)
