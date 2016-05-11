Webservice which runs sparksql queries in a docker container.

# Prepare

Create conf directory with all hdfs/yarn/spark config files inside.

# Build

```
docker build -t spark-flask .
```

# Run

```
docker run -ti --rm -spark-flask
```

TODO

Using deploy mode `client`, the driver is listening inside the docker container.
The yarn cluster is trying to connect to the internal docker ip, which fails.

Possible solution:
Run docker container with public ip

(Re)Using the network stack of the docker host machine can be done with:

```
docker run --net=host ....
```` 
(from https://docs.docker.com/engine/reference/run/#network-settings)



