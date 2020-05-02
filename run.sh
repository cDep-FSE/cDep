#!/bin/bash
while getopts ":a:" opt; do
	case ${opt} in
		a) 
			target=$OPTARG
			;;
		*)
			echo "Usage: run.sh -a x (x is any or a combination of the following options separated by ',')"
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
	echo "Usage: run.sh -a x (x is any or a combination of the following options separated by ',')"
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

echo "The program is running and output is cDep_result.csv"
mvn exec:java -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn -Dexec.mainClass="cdep.cDep" -Dexec.args="-o tmp.txt -x ./config_files -a ${target}"
python parser.py tmp.txt
mv cDep_result.csv /result/
