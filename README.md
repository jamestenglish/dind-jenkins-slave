# dind-jenkins-slave

A Docker image which allows for running Docker in Docker (DinD). This image is meant to be used with the [Jenkins Docker plugin](https://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin). It allows for Docker containers used as Jenkins build slaves to create and publish their own Docker images in-turn.

This is a mashup of "[evarga/jenkins-slave](https://registry.hub.docker.com/u/evarga/jenkins-slave/)" and "[jpetazzo/dind](https://registry.hub.docker.com/u/jpetazzo/dind/)".

This is forked from "[tehranian/dind-jenkins-slave](https://registry.hub.docker.com/u/tehranian/dind-jenkins-slave/)".

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

```bash
$ docker run -d --privileged -e DOCKER_DAEMON_ARGS="-D" \
  --link jenkins-master-container:jenkins \
  -e JENKINS_USERNAME=jenkins \
  -e JENKINS_PASSWORD=jenkins \
  -e JENKINS_LABELS="docker dind" \
  mizunashi/jenkins-docker-slave
```

### See Also

* [dind document](https://github.com/jpetazzo/dind)
* [mizunashi/jenkins-swarm-slave](https://github.com/mizunashi-mana/jenkins-swarm-slave-docker)

## Require Environments

Value type:

* CONST - Contant value.  Dockerfile provided.  You can use entrypoint, building run or etc.
* SETTABLE - Settable value.  You can set the value when `docker run` with `-e` or `--env` option.

| Name                  | Type     | Description |
|-----------------------|----------|-------------|
| JENKINS_WORKUSER      | CONST    | Setted `jenkins`. This is work username. |
| JENKINS_WORKSPACE     | CONST    | Setted `/var/jenkins_ws`. This is work user's home dir. |
| SETUP_DIR             | CONST    | Setted `/var/cache/jenkins_ws`. This is to lie setup files. |
| JAVA_OPTS             | SETTABLE | `java` run with this extra options |
| JENKINS_MASTER        | SETTABLE | If this value was setted, `docker` set the target URL for jenkins master. |
| JENKINS_USERNAME      | SETTABLE | If this value was setted, `docker` set the username for authentication. |
| JENKINS_PASSWORD      | SETTABLE | If this value was setted, `docker` set the password for authentication. |
| JENKINS_NAME          | SETTABLE | If this value was setted, `docker` set the name of this jenkins slave. |
| JENKINS_EXECUTORS     | SETTABLE | If this value was setted, `docker` set the number of executors for this jenkins slave. |
| JENKINS_LABELS        | SETTABLE | If this value was setted, `docker` set the whitespace-separater list of labels for this jenkins slave. |
| DOCKER_DAEMON_ARGS    | SETTABLE | `docker` in `docker` run with this extra option. | 
| DOCKER_PORT           | SETTABLE | If this value was setted, `docker` in `docker` open http api on the port. |
| DOCKER_LOG            | SETTABLE | If this value was setted, `docker` in `docker` is logging in this path. |

