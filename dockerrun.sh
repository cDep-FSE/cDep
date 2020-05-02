#!/bin/bash
while getopts ":a:" opt; do
    case ${opt} in
        a)
            target=$OPTARG
            ;;
        *)
            echo "Usage: dockerrun.sh -a x (x is any or a combination of the following options separated by ',')"
            echo "       0:hdfs"
            echo "       1:mapreduce"
            echo "       2:yarn" 
            echo "       3:hadoop_common"
            echo "       4:hadoop_tools" 
            echo "       5:hbase" 
            echo "       6:alluxio" 
            echo "       7:zookeeper" 
            echo "       8:spark"
            exit 1
            ;;
    esac
done

if [ -z "${target}" ]; then
    echo "Usage: dockerrun.sh -a x (x is any or a combination of the following options separated by ',')"
    echo "       0:hdfs"
    echo "       1:mapreduce"
    echo "       2:yarn" 
    echo "       3:hadoop_common"
    echo "       4:hadoop_tools" 
    echo "       5:hbase" 
    echo "       6:alluxio" 
    echo "       7:zookeeper" 
    echo "       8:spark"
    exit 1
fi

docker run -m 12GB -e TARGET=$target -v /tmp/output:/result/ cdep/cdep:1.0
