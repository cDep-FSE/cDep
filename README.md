# cDep: Configuration Dependency Analysis
cDep is a tool for discovering configuration dependencies both within and across software components. cDep analyzes Java bytecode of the target software programs. It outputs specific types of dependencies and the corresponding interdependent parameters. 

cDep currently supports: Hadoop Common, HDFS, YARN, HBASE, Alluxio, ZooKeeper, MapReduce, and Spark.

**All the results in the submission, including both the study dataset and the cDep results can be reproduced.**
 
## Running cDep

### Docker Container Image

We prepared a Docker container image, with which you can directly interact with the pre-built cDep.

The cDep Docker image can be downloaded from: https://hub.docker.com/repository/docker/cdep/cdep/

To run the Docker image, there is one CLI option:

* `-a <arg>`: The supported applications are `0:hdfs`, `1:mapreduce`, `2:yarn`, `3:hadoop_common`, 
                     `4:hadoop_tools`, `5:hbase`, `6:alluxio`, `7:zookeeper`, `8:spark`

One example running command is as follows:
```
$ ./dockerrun.sh -a 0,1
```
Note that multiple applications should be seperated by `,`.

The results will be stored at `/tmp/output/cDep_result.csv`.
**Note that it could take several tens of minutes (so be patient).**

### cDep in Your Own Environment

We build cDep using Java(TM) SE Runtime Environment (build 12.0.2+10);
we do not provide guarantee on other Java versions. **Please use the Docker container image to try out cDep.**

First, clone the repository,
```
$ git clone git@github.com:cDep-FSE/cDep.git
$ cd cdep
```

Second, build cDep (we use Maven as the build tool for cDep)
```
$ mvn compile
```
After compiling, `cDep.class` should be generated at `target/classes/cdep/cDep.class`.


## Reproducibility

**All the results in the submission, including both the study dataset and the cDep results can be reproduced.**

### cDep Results

The cDep results can be reproduced by running cDep:
```
$ ./dockerrun.sh  -a 0,1,2,3,4,5,6,7,8
```

The `cDep_result.csv` is in the format of:
`["java class"; "java method", "jimple stmt", "dependency type", "parameters"]`

The following shows an example of a dependency cDep extracts from MapReduce:

```
('org.apache.hadoop.mapred.MapFileOutputFormat', '<org.apache.hadoop.mapred.MapFileOutputFormat: org.apache.hadoop.mapred.RecordWriter getRecordWriter(org.apache.hadoop.fs.FileSystem,org.apache.hadoop.mapred.JobConf,java.lang.String,org.apache.hadoop.util.Progressable)>', 'if $z0 == 0 goto $r7 = new org.apache.hadoop.io.MapFile$Writer', 'control dependency', 'mapreduce.output.fileoutputformat.compress', 'mapreduce.output.fileoutputformat.compress.type')
```

The two parameters, `mapreduce.output.fileoutputformat.compress` and `mapreduce.output.fileoutputformat.compress.type`, have a control dependency.

### Configuration Dependency Dataset

The configuration dependency dataset can be found at `dataset`.

It contains the following four files:
* `hadoop_intra.csv` : Intra-component dependencies in each individual component of the Hadoop-based stack;
* `hadoop_inter.csv` : Inter-component dependencies across components of the Hadoop-based stack;
* `openstack_intra.csv` : Intra-component dependencies in each individual component of OpenStack;
* `openstack_inter.csv` : Inter-component dependencies across components of OpenStack;
* `one_off_dep.csv` : One-off dependencies described in Section 4.3.

All the data sheets are in the format of CSV, with the first row describing the meaning of each column.

The data sheets provide detailed labels of the analysis results presented in our study.

### cDep Findings
The found dependency cases from cDep could be found at `cDep_result`.
It contains the following two files:
* `intra.csv` : Intra-component dependencies in each individual component of the Hadoop-based stack;
* `inter.csv` : Inter-component dependencies across components of the Hadoop-based stack;

All the data sheets are in the format of CSV, with the first row describing the meaning of each column.
