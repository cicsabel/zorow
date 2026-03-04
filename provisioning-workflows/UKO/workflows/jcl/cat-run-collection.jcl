//JAVA EXEC PROC=JVMPRC17,
// JAVACLS='com.ibm.ccc.ekmf.cat.agent.CatAgent',
// ARGS='${instance-CAT_USER_DIR}' 
//STDENV DD *
# This is a shell script which configures
# any environment variables for the Java JVM.
# Variables must be exported to be seen by the launcher.
#
# Change product HOME path for JAVA, KAFKA, ZOAU and UKO CAT Agent
# Edit CAT_STEPLIB for the UKO CAT Agent APF authorized library
#
JAVA_HOME=${instance-JAVA_HOME}
KAFKA_HOME=${instance-KAFKA_HOME}
CAT_HOME=${instance-CAT_INSTALL_DIR}
ZOAU_HOME=${instance-ZOAU_HOME}
CAT_STEPLIB=${instance-CC_RUNLIB}
CAT_PATH=/bin:"$ZOAU_HOME"/bin:.
CAT_LIBPATH="$ZOAU_HOME"/lib:.

# Exports for CAT collector
export CAT_HOME CAT_PATH CAT_STEPLIB CAT_LIBPATH

#  PATH setup
export PATH=/bin:"$JAVA_HOME"/bin

# LIBPATH setup
LIBPATH=/lib:/usr/lib:"$JAVA_HOME"/bin:/usr/lib/java_runtime
LIBPATH="$LIBPATH":"$JAVA_HOME"/lib
LIBPATH="$LIBPATH":"$JAVA_HOME"/lib/j9vm
export LIBPATH="$LIBPATH":

# CLASSPATH setup
CP=/usr/include/java_classes/ifaedjreg.jar
CP="$CP":"$KAFKA_HOME"/libs:"$JAVA_HOME"/lib:"$JAVA_HOME"/lib/ext

# Add Application required jars to end of CLASSPATH
for i in $CAT_HOME/lib/*.jar; do
    CP="$CP":"$i"
    done
for i in $KAFKA_HOME/libs/*.jar; do
    CP="$CP":"$i"
    done
export CLASSPATH="$CP":

# Configure JVM options
IJO="-Xms16m -Xmx128m --add-exports=java.base/com.ibm.misc=ALL-UNNAMED"
# Uncomment the following to aid in debugging "Class Not Found" problems
#IJO="$IJO -verbose:class"
# Uncomment the following if you want to run with Ascii file encoding..
#IJO="$IJO -Dfile.encoding=ISO8859-1"
export IBM_JAVA_OPTIONS="$IJO "