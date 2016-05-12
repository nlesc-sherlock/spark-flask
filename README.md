Webservice which runs sparksql queries in a docker container.

# Prepare

## Config

Create conf directory with all hdfs/yarn/spark config files inside.
Removed *topo* from core-site.xml.

## Data file

Uses Entities.csv panama papers example zipfile from https://offshoreleaks.icij.org/
This file should be available on hdfs as '/user/shelly/panama/offshore_leaks_csvs/Entities.csv'.

# Build

```
docker build -t spark-flask .
```

# Run

```
docker run -d  --net=host -e FLASK_PORT=8081 spark-flask
```

The Spark driver will run in the docker container. Must use `--net=host` option is used so the Spark executor can connect to the Spark driver.
(--net=host will make all ports of docker container on the host machine)

Use `docker logs <container id>` to find the urls of the YARN job and Spark UI websites.