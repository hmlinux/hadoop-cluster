#!/bin/bash
jdk_v=jdk1.8.0_181
jdk_s=jdk-8u181-linux-x64.tar.gz
jdk_home=/usr/local/jdk

if java -version &>/dev/null
then
    echo "Jdk is already installed..."
    exit 0
fi

if [ ! -d ${jdk_home} ];then
    if [ ! -e ${jdk_home}/bin/java ];then
        echo
        echo "-----Installing ${jdk_v}-----"
        echo
        cd /usr/local/src
        if [ ! -e ${jdk_s} ];then
            echo "[${jdk_s}] source package no find! Please put it in /usr/local/src/ ..."
        else
            tar -zxf ${jdk_s} -C /usr/local && cd /usr/local && ln -s ${jdk_v} jdk
            echo -e 'export JAVA_HOME=/usr/local/jdk\nexport JRE_HOME=$JAVA_HOME/jre\nexport CLASSPATH=$JAVA_HOME/lib:$JRE_HOME/lib\nexport PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH' > /etc/profile.d/jdk.sh
            source /etc/profile.d/jdk.sh && java -version
            echo "---------------------------------------"
            echo
        fi
    else
        source /etc/profile && java -version
    fi
else
    source /etc/profile && java -version
fi
