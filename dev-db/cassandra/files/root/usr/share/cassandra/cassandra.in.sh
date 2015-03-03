# vim: ft=sh
# Arguments to pass to the JVM
#JVM_OPTS=" \
#        -ea \
#        -Xms128M \
#        -Xmx1G \
#        -XX:TargetSurvivorRatio=90 \
#        -XX:+AggressiveOpts \
#        -XX:+UseParNewGC \
#        -XX:+UseConcMarkSweepGC \
#        -XX:+CMSParallelRemarkEnabled \
#        -XX:+HeapDumpOnOutOfMemoryError \
#        -XX:SurvivorRatio=128 \
#        -XX:MaxTenuringThreshold=0 \
#        -Dcom.sun.management.jmxremote.port=8080 \
#        -Dcom.sun.management.jmxremote.ssl=false \
#        -Dcom.sun.management.jmxremote.authenticate=false"

if [ "x$CASSANDRA_HOME" = "x" ]; then
    CASSANDRA_HOME=$(source /etc/conf.d/cassandra && echo "$CASSANDRA_HOME")
fi

# The directory where Cassandra's configs live (required)
if [ "x$CASSANDRA_CONF" = "x" ]; then
    CASSANDRA_CONF=$(source /etc/conf.d/cassandra && echo "$CASSANDRA_CONF")
fi

# This can be the path to a jar file, or a directory containing the 
# compiled classes. NOTE: This isn't needed by the startup script,
# it's just used here in constructing the classpath.
cassandra_bin="$CASSANDRA_HOME/build/classes/main"
cassandra_bin="$cassandra_bin:$CASSANDRA_HOME/build/classes/thrift"
#cassandra_bin="$cassandra_home/build/cassandra.jar"

# the default location for commitlogs, sstables, and saved caches
# if not set in cassandra.yaml
cassandra_storagedir=$(source /etc/conf.d/cassandra && echo "$CASSANDRA_STORAGE_DIR")

# JAVA_HOME can optionally be set here
#JAVA_HOME=/usr/local/jdk6

# The java classpath (required)
CLASSPATH="$CASSANDRA_CONF:$cassandra_bin"

for jar in "$CASSANDRA_HOME"/lib/*.jar; do
    CLASSPATH="$CLASSPATH:$jar"
done

# set JVM javaagent opts to avoid warnings/errors
if [ "$JVM_VENDOR" != "OpenJDK" -o "$JVM_VERSION" \> "1.6.0" ] \
      || [ "$JVM_VERSION" = "1.6.0" -a "$JVM_PATCH_VERSION" -ge 23 ]
then
    JAVA_AGENT="${JAVA_AGENT:-} -javaagent:$CASSANDRA_HOME/lib/jamm-0.2.8.jar"
fi
