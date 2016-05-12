FROM sequenceiq/spark:1.6.0
MAINTAINER SequenceIQ

RUN mkdir /conf
ENV YARN_CONF_DIR=/conf
# in bootstrap conf is filled with hdfs/yarn/spark config files
ENV HADOOP_CONF_DIR=/app/conf
ENV YARN_CONF_DIR=/app/conf
ENV SPARK_CONF_DIR=/app/conf

RUN yum -y install python-pip

ADD . /app

WORKDIR /app

RUN pip install -r requirements.txt

ENV FLASK_PORT=8080
EXPOSE 8080

ENTRYPOINT ["spark-submit", "--master", "yarn", "--deploy-mode", "client", "--proxy-user", "shelly", "--packages", "com.databricks:spark-csv_2.10:1.4.0", "app.py"]
