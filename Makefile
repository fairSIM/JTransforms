#
# fairSIM JTransforms make file
#
JC = javac
JAR = jar

# Options for the java compiler
EXTDIR="./external"

JFLAGS = -g -Xlint:unchecked -Xlint:deprecation -extdirs ./external -d ./
JFLAGS+= -target 1.6 -source 1.6 -bootclasspath ./external/rt-1.6.jar

# remove command to clean up
RM = rm -vf

.PHONY:	all 

all:	
	$(JC) $(JFLAGS) org/fairsim/extern/jtransforms/*.java


# misc rules
git-version :
	git rev-parse HEAD > org/fairsim/git-version-jtransforms.txt  ; \
	git tag --contains >> org/fairsim/git-version-jtransforms.txt ; \
	echo "n/a" >> org/fairsim/git-version-jtransforms.txt
	 	
jar:	git-version	
	$(JAR) -cvf jtransforms_fairSIM_fork_$(shell head -c 10 org/fairsim/git-version-jtransforms.txt).jar \
	org/fairsim/extern/*/*.class \
	org/fairsim/git-version-jtransforms.txt 

doc:	doc/index.html

doc/index.html : $(wildcard org/fairsim/*/*.java) 
	javadoc -d doc/ -classpath ./ -extdirs ${EXTDIR} \
	-subpackages org.fairsim -exclude org.fairsim.extern.jtransforms 

clean :
	$(RM) jtransforms_fairSIM_*.jar jtransforms_fairSIM_*.tar.bz2
	$(RM) org/fairsim/extern/jtransforms/*.class org/fairsim/git-version-jtransforms.txt
	$(RM) -r doc/*
	$(RM) -rf target


