echo "export JAVA_HOME=\"$(readlink -f $(which javac) | grep -oP '.*(?=/bin)')\"" >> ~/.bash_profile

cat <<\EOF >> ~/.bash_profile
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
EOF

source ~/.bash_profile
$JAVA_HOME/bin/java -version

cd $HADOOP_HOME/etc/hadoop

echo "export JAVA_HOME=\"$JAVA_HOME\"" > ./hadoop-env.sh

#Adjust core-site.xml file
rm -f core-site.xml
cat <<\EOF >> core-site.xml
<?xml version="1.0"?>
<configuration>
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://master/</value>
  </property>
</configuration>
EOF

#Adjust yarn-site.xml
rm -f yarn-site.xml
cat <<\EOF >> yarn-site.xml
<?xml version="1.0"?>
<configuration>
  <property>
    <name>yarn.resourcemanager.hostname</name>
    <value>master</value>
  </property>
  <property>
    <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle</value>
  </property>
  <property>
    <name>yarn.nodemanager.resource.cpu-vcores</name>
    <value>2</value>
  </property>
  <property>
    <name>yarn.nodemanager.resource.memory-mb</name>
    <value>4096</value>
  </property>
</configuration>
EOF

cat <<\EOF >> mapred-site.xml
<?xml version="1.0"?>
<configuration>
  <property>
    <name>mapreduce.framework.name</name>
    <value>yarn</value>
  </property>
</configuration>
EOF

cat <<\EOF >> hdfs-site.xml
<?xml version="1.0"?>
<configuration>
  <property>
    <name>dfs.datanode.data.dir</name>
    <value>file:///data/datanode</value>
  </property>
  <property>
    <name>dfs.namenode.name.dir</name>
    <value>file:///data/namenode</value>
  </property>
  <property>
    <name>dfs.namenode.checkpoint.dir</name>
    <value>file:///data/namesecondary</value>
  </property>
</configuration>
EOF
