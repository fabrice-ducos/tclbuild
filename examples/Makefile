PREFIX=../local
JACLIN_VERSION=0.1.0
TCLJAVA_LIB=$(PREFIX)/lib/jaclin-$(JACLIN_VERSION)
CLASSPATH=$(TCLJAVA_LIB)/tcljava.jar:$(TCLJAVA_LIB)/tclblend.jar:.
JAVA_LIBRARY_PATH=$(TCLJAVA_LIB)
JAVAC_FLAGS=-g
#JAVA_FLAGS=-Djava.library.path=$(JAVA_LIBRARY_PATH) -verbose:jni
JAVA_FLAGS=-Djava.library.path=$(JAVA_LIBRARY_PATH)

export CLASSPATH

all: test

StringLengthTest.class:
	javac $(JAVAC_FLAGS) StringLengthTest.java

test: StringLengthTest.class
	java $(JAVA_FLAGS) StringLengthTest

clean:
	-rm -f *.class
	-rm -f *.log
	-rm -f *~

