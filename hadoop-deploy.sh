#!/bin/sh

##SCRIPT INSTALL Hadoop

###JDK INSTALL
apt update
apt install openjdk-11-jdk
apt install openssh-server openssh-client
apt-get update
apt-get install default-jdk


## ADDUSER 
adduser hadoop
#echo -e "Passw0rd\nPassw0rd" | passwd hdoop
su - hadoop
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys


# HADOOP
wget https://downloads.apache.org/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz

tar -zxvf hadoop-3.3.1.tar.gz
mv hadoop-3.3.1 /usr/local/hadoop
chown hadoop.hadoop /usr/local/hadoop -R

# JAVA
update-alternatives --config java
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
env | grep JAVA_HOME

#VAR HADOOP
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export YARN_HOME=$HADOOP_HOME
export PATH="$PATH:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin"
env | grep -i -E "hadoop|yarn"