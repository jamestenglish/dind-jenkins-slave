# dind-jenkins-slave

A Docker image which allows for running Docker in Docker (DinD). This image is meant to be used with the [Jenkins Docker plugin](https://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin). It allows for Docker containers used as Jenkins build slaves to create and publish their own Docker images in-turn.

This is a mashup of "[evarga/jenkins-slave](https://registry.hub.docker.com/u/evarga/jenkins-slave/)" and "[jpetazzo/dind](https://registry.hub.docker.com/u/jpetazzo/dind/)".

This is forked from "[tehranian/dind-jenkins-slave](https://registry.hub.docker.com/u/tehranian/dind-jenkins-slave/)".

## Attention

The image includes default example ssh key.  
So, if you run this image without custom key option and publish ssh port, all of people can login.

**It is very dangerous that exposed ssh port publishes globally.**

## Installation

Pulling:

```bash
$ docker pull mizunashi/jenkins-docker-slave
```

Building:

```bash
$ git clone https://github.com/mizunashi-mana/dind-jenkins-slave
$ cd dind-jenkins-slave
$ make build
```

## Usage

you can quickstart:

```bash
$ make quickstart
$ docker ps
...
xxxxxxxxxxxx        mizunashi/jenkins-docker-slave:latest   "/usr/bin/supervisor   X seconds ago       Up X seconds        22/tcp      mydockersl-app
...
```

The ssh key to login jenkins-slave is in `./ssh-keys` directory.

If you would run with custom options:

```bash
$ docker run --privileged -t -i mizunashi/jenkins-docker-slave
```

`--privileged` option is necessary.

And, if you would run with custom options and daemon:

```bash
$ docker run -d --privileged -e DOCKER_DAEMON_ARGS="-D" mizunashi/jenkins-docker-slave
```

See Also, [dind document](https://github.com/jpetazzo/dind)

And, using custom authorized_keys:

```bash
$ docker run -d --name mydockersl-app --privileged \
  -e AUTHORIZED_KEYS_URL='http://your domain/your keys' \
  -e DOCKER_DAEMON_ARGS="-D" \
  mizunashi/jenkins-docker-slave
```

See Also, [docker-jenkins-slave document](https://github.com/mizunashi-mana/docker-jenkins-slave)

And, linked jenkins container:

```bash
$ docker run -d --privileged \
  -e DOCKER_DAEMON_ARGS="-D" \
  --name mydocker-sl \
  mizunashi/jenkins-docker-slave
$ docker run -d --name myjenkins --link mydocker-sl:mydocker-sl jenkins
```
