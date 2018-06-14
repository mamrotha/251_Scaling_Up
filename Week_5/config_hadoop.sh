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
</configuration>
EOF


