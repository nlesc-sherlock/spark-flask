FROM sequenceiq/spark:1.6.0
MAINTAINER SequenceIQ

RUN mkdir /conf
ENV YARN_CONF_DIR=/conf
# in bootstrap conf is filled with hdfs/yarn/spark config files
ENV HADOOP_CONF_DIR=/app/conf
ENV YARN_CONF_DIR=/app/conf
ENV SPARK_CONF_DIR=/app/conf
# TODO Uncomment JAVA_HOME in *env.sh
# add
#spark.driver.extraJavaOptions -Dhdp.version=2.4.2.0-258
#spark.yarn.am.extraJavaOptions -Dhdp.version=2.4.2.0-258

RUN yum -y install python-pip

ADD . /app

WORKDIR /app

RUN pip install -r requirements.txt

ENTRYPOINT ["spark-submit", "--master", "yarn", "--proxy-user", "shelly", "--deploy-mode", "client", "--packages", "com.databricks:spark-csv_2.10:1.4.0", "app.py"]