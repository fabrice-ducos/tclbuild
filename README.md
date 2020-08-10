# tclbuild 0.1.5

A build project for building Tcl/Tk and [Jaclin](https://github.com/fabrice-ducos/jaclin) (TclJava fork) from sources

tclbuild was developed to ease the construction of Jaclin from the available JDK and Tcl/Tk sources.

It automatically downloads the versions of Tcl/Tk and other open-source popular tools (Expect, Critcl, TclX, ...) required by the user, 
and builds them along with [Jaclin](https://github.com/fabrice-ducos/jaclin). The goal is to provide a complete Tcl/Tk environment running natively and on a Java Virtual Machine.

This is a work in progress and still experimental.

### To get started

Edit `build.cfg`:
  - set the desired versions for the tools.
  - edit the TARGETS variable with the list of the needed tools.
  - edit the installation path: PREFIX

Once everything is set up, launch `make help` to see the list of available build targets, and check the configuration.

`make` will attempt to build all the targets specified in `build.cfg`

### Requirements
A system with `GNU make` installed (other versions of `make` may work, but none has been tested yet)
