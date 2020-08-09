# TclBuild script: integration Makefile for Tcl
# Fabrice Ducos 2019

include build.cfg

# TCL_PLATFORM can be: unix (also works for OSX), win, macosx
# TCL_PLATFORM=macosx provides some additional, optional features for OSX:
#   --enable-framework and --disable-corefoundation (see README in $(TCL_SRCDIR)/macosx), as well as facilities
#   for development on XCode. For deployment purposes, one shall use TCL_PLATFORM=unix by default even on OSX.
TCL_PLATFORM=unix

PACKAGES_DIR=packages
TCL_TARBALL=$(PACKAGES_DIR)/tcl$(TCL_VERSION)-src.tar.gz
TK_TARBALL=$(PACKAGES_DIR)/tk$(TK_VERSION)-src.tar.gz
EXPECT_TARBALL=$(PACKAGES_DIR)/expect$(EXPECT_VERSION).tar.gz
CRITCL_TARBALL=$(PACKAGES_DIR)/critcl-$(CRITCL_VERSION).tar.gz
TCLX_TARBALL=$(PACKAGES_DIR)/tclx-$(TCLX_VERSION).zip
TCLLIB_TARBALL=$(PACKAGES_DIR)/tcllib-$(TCLLIB_VERSION).tar.gz
BWIDGET_TARBALL=$(PACKAGES_DIR)/bwidget-$(BWIDGET_VERSION).tar.gz
JTCL_TARBALL=$(PACKAGES_DIR)/jtcl-$(JTCL_VERSION).tar.gz
JACLIN_TARBALL=$(PACKAGES_DIR)/jaclin-$(JACLIN_VERSION).tar.gz

# tcl_lang_version must be of the form x.y, e.g. 8.6.9 -> 8.6
tcl_lang_version=$(shell echo $(TCL_VERSION) | sed 's/\([0-9]*\.[0-9]*\)\.[0-9]*/\1/')
tclsh=$(PREFIX)/bin/tclsh${tcl_lang_version}
wish=$(PREFIX)/bin/wish${tcl_lang_version}
thread_lib=$(PREFIX)/lib/thread$(THREADS_VERSION)
expect_cmd=$(PREFIX)/bin/expect
critcl_cmd=$(PREFIX)/bin/critcl
tclx_lib=$(PREFIX)/lib/tclx${tcl_lang_version}
tcllib_lib=$(PREFIX)/lib/tcllib$(TCLLIB_VERSION)
bwidget_lib=$(PREFIX)/lib/BWidget
jtclsh=$(PREFIX)/bin/jtclsh
jaclsh=$(PREFIX)/bin/jaclsh
jtcl=$(PREFIX)/bin/jtcl

ifeq (, $(JAVA_HOME))
$(error JAVA_HOME not defined, please set it up to a proper JAVA_HOME directory, or install and configure the jenv utility)
endif

TCL_SRCDIR=$(BUILD_DIR)/tcl$(TCL_VERSION)
TK_SRCDIR=$(BUILD_DIR)/tk$(TK_VERSION)
EXPECT_SRCDIR=$(BUILD_DIR)/expect$(EXPECT_VERSION)
CRITCL_SRCDIR=$(BUILD_DIR)/critcl-$(CRITCL_VERSION)
TCLX_SRCDIR=$(BUILD_DIR)/tclx-$(TCLX_VERSION)
TCLLIB_SRCDIR=$(BUILD_DIR)/tcllib-$(TCLLIB_VERSION)
BWIDGET_SRCDIR=$(BUILD_DIR)/bwidget-$(BWIDGET_VERSION)
JACLIN_SRCDIR=$(BUILD_DIR)/jaclin-$(JACLIN_VERSION)
JTCL_SRCDIR=$(BUILD_DIR)/jtcl-$(JTCL_VERSION)

THREADS_SRCDIR=$(TCL_SRCDIR)/pkgs/thread$(THREADS_VERSION)
threads_pkgIndex=$(THREADS_SRCDIR)/pkgIndex.tcl

.PHONY: all download help clean erase
.PHONY: tcl tk threads expect critcl tclx tcllib bwidget tclblend jacl tcljava

all: $(TARGETS)

download:
	cd packages && $(MAKE) download

help:
	cd $(PACKAGES_DIR) && $(MAKE) help
	@echo
	@echo "make [all]: launch the build and installation process"
	@echo "make tcl: build tcl"
	@echo "make tk: build tk"
	@echo "make threads: build tcl threads (a subpackage of tcl)"
	@echo "make expect: build expect"
	@echo "make critcl: build critcl"
	@echo "make tclx: build tclx"
	@echo "make tcllib: build tcllib"
	@echo "make bwidget: build bwidget"
	@echo "make tclblend: build tclblend"
	@echo "make jacl: build jacl (currently implementing Tcl 8.0)"
	@echo "make tcljava [CFLAGS+=-DTCLBLEND_DEBUG]: build tcljava [with tclblend debug mode]"
	@echo "make jaclin [CFLAGS+=-DTCLBLEND_DEBUG]: build jaclin [with tclblend debug mode]"
	@echo "make jtcl: build jtcl (a jacl fork implementing Tcl 8.4)"
	@echo "make clean: remove the build directory."
	@echo "make download: download the packages given in build.cfg"
	@echo "make erase: erase the downloaded packages"
	@echo "make help: this help"
	@echo
	@echo "The following settings can be redefined on the command line, e.g make PREFIX=/other/prefix JAVA_HOME=/other/java/home"
	@echo "PREFIX=$(PREFIX)"
	@echo "JAVA_HOME=$(JAVA_HOME)"
	@echo "BUILD_DIR=$(BUILD_DIR)"

tcl: $(tclsh)

$(tclsh): $(TCL_SRCDIR)
	cd $(TCL_SRCDIR)/$(TCL_PLATFORM) && ./configure --prefix=$(PREFIX) $(THREADS_FLAGS) $(MORE_TCL_FLAGS) && $(MAKE) && $(MAKE) install

tk: $(wish)

$(wish): $(tclsh) $(TK_SRCDIR)
	cd $(TK_SRCDIR)/$(TCL_PLATFORM) && ./configure --prefix=$(PREFIX) --with-tcl=$(TCL_SRCDIR)/$(TCL_PLATFORM) $(THREADS_FLAGS) $(MORE_TCL_FLAGS) $(MORE_TK_FLAGS) && $(MAKE) && $(MAKE) install

threads: $(threads_lib)

$(threads_lib): $(threads_pkgIndex)

$(threads_pkgIndex): $(TCL_SRCDIR) $(THREADS_SRCDIR)
	cd $(THREADS_SRCDIR) && ./configure --prefix=$(PREFIX) $(THREADS_FLAGS) $(MORE_TCL_FLAGS) --with-tcl=$(TCL_SRCDIR)/$(TCL_PLATFORM) && $(MAKE) && $(MAKE) install

expect: $(expect_cmd)

$(expect_cmd): $(tclsh) $(EXPECT_SRCDIR)
	cd $(EXPECT_SRCDIR) && ./configure --prefix=$(PREFIX) $(THREADS_FLAGS) $(MORE_TCL_FLAGS) --with-tcl=$(TCL_SRCDIR)/$(TCL_PLATFORM) && $(MAKE) && $(MAKE) install

critcl: $(critcl_cmd)

$(critcl_cmd): $(tclsh) $(CRITCL_SRCDIR)
	cd $(CRITCL_SRCDIR) && $(tclsh) ./build.tcl install

tclx: $(tclx_lib)

$(tclx_lib): $(tclsh) $(TCLX_SRCDIR)
	cd $(TCLX_SRCDIR) && ./configure --prefix=$(PREFIX) $(THREADS_FLAGS) $(MORE_TCL_FLAGS) --with-tcl=$(TCL_SRCDIR)/$(TCL_PLATFORM) && $(MAKE) && $(MAKE) install

tcllib: $(tcllib_lib)

$(tcllib_lib): $(tclsh) $(TCLLIB_SRCDIR)
	cd $(TCLLIB_SRCDIR) && ./configure --prefix=$(PREFIX) --with-tclsh=$(tclsh) && $(MAKE) && $(MAKE) install

bwidget: $(bwidget_lib)

$(bwidget_lib): $(BWIDGET_SRCDIR)
	mv $(BWIDGET_SRCDIR) $(PREFIX)/lib/BWidget

tclblend: $(jtclsh)

$(jtclsh): $(threads_pkgIndex) $(JACLIN_SRCDIR)
	cd $(JACLIN_SRCDIR) && ./configure --enable-tclblend --prefix=$(PREFIX) --with-tcl=$(TCL_SRCDIR)/$(TCL_PLATFORM) --with-thread=$(THREADS_SRCDIR) --with-jdk=$(JAVA_HOME) && $(MAKE) && $(MAKE) install

$(threads_pkgIndex): threads

jacl: $(jaclsh)

$(jaclsh): $(JACLIN_SRCDIR)
	cd $(JACLIN_SRCDIR) && ./configure --enable-jacl --prefix=$(PREFIX) --with-tcl=$(TCL_SRCDIR)/$(TCL_PLATFORM) --with-thread=$(THREADS_SRCDIR) --with-jdk=$(JAVA_HOME) && $(MAKE) && $(MAKE) install

tcljava: tclblend jacl

jaclin: tclblend jacl

jtcl: $(JTCL_SRCDIR)
	cd $(JTCL_SRCDIR) && echo "jtcl not yet supported..." && false

$(TCL_SRCDIR): $(TCL_TARBALL) $(BUILD_DIR)
	$(UNTAR) $< -C $(BUILD_DIR)

$(THREADS_SRCDIR): $(TCL_SRCDIR)

$(TK_SRCDIR): $(TK_TARBALL) $(BUILD_DIR)
	$(UNTAR) $< -C $(BUILD_DIR)

$(EXPECT_SRCDIR): $(EXPECT_TARBALL) $(BUILD_DIR)
	$(UNTAR) $< -C $(BUILD_DIR)

$(CRITCL_SRCDIR): $(CRITCL_TARBALL) $(BUILD_DIR)
	$(UNTAR) $< -C $(BUILD_DIR)

$(TCLX_SRCDIR): $(TCLX_TARBALL) $(BUILD_DIR)
	$(UNZIP) $< -d $(BUILD_DIR)

$(TCLLIB_SRCDIR): $(TCLLIB_TARBALL) $(BUILD_DIR)
	$(UNTAR) $< -C $(BUILD_DIR)

$(BWIDGET_SRCDIR): $(BWIDGET_TARBALL) $(BUILD_DIR)
	$(UNTAR) $< -C $(BUILD_DIR)

$(TCLBLEND_SRCDIR): $(TCLBLEND_TARBALL) $(BUILD_DIR)
	$(UNTAR) $< -C $(BUILD_DIR)

$(JACL_SRCDIR): $(JACL_TARBALL) $(BUILD_DIR)
	$(UNTAR) $< -C $(BUILD_DIR)

$(JACLIN_SRCDIR): $(JACLIN_TARBALL) $(BUILD_DIR)
	$(UNTAR) $< -C $(BUILD_DIR)

$(JTCL_SRCDIR): $(JTCL_TARBALL) $(BUILD_DIR)
	$(UNTAR) $< -C $(BUILD_DIR)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(TCL_TARBALL):
	cd $(PACKAGES_DIR) && $(MAKE) tcl

$(TK_TARBALL):
	cd $(PACKAGES_DIR) && $(MAKE) tk

$(EXPECT_TARBALL):
	cd $(PACKAGES_DIR) && $(MAKE) expect

$(CRITCL_TARBALL):
	cd $(PACKAGES_DIR) && $(MAKE) critcl

$(TCLX_TARBALL):
	cd $(PACKAGES_DIR) && $(MAKE) tclx

$(TCLLIB_TARBALL):
	cd $(PACKAGES_DIR) && $(MAKE) tcllib

$(BWIDGET_TARBALL):
	cd $(PACKAGES_DIR) && $(MAKE) bwidget

$(TCLBLEND_TARBALL):
	cd $(PACKAGES_DIR) && $(MAKE) tclblend

$(JACL_TARBALL):
	cd $(PACKAGES_DIR) && $(MAKE) jacl

$(JACLIN_TARBALL):
	cd $(PACKAGES_DIR) && $(MAKE) jaclin

$(JTCL_TARBALL):
	cd $(PACKAGES_DIR) && $(MAKE) jtcl

clean:
	cd examples && $(MAKE) clean
	-rm -rf $(BUILD_DIR)
	-rm -f *~

erase:
	cd $(PACKAGES_DIR) && $(MAKE) erase
