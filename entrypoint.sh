#!/bin/bash
set -e

SWARM_CLIENT_JAR=${SETUP_DIR}/swarm-client-${JENKINS_SWARM_VERSION}-jar-with-dependencies.jar

if [[ -z "${JENKINS_MASTER}" ]] && [ -n "${JENKINS_PORT_8080_TCP_ADDR}" ]; then
  JENKINS_MASTER="http://${JENKINS_PORT_8080_TCP_ADDR}:${JENKINS_PORT_8080_TCP_PORT}"
fi

cat > ${JENKINS_WORKSPACE}/swarm-client <<EOF
#!/bin/sh

/usr/bin/java \
  ${JAVA_OPTS:+${JAVA_OPTS}} \
  -jar ${SWARM_CLIENT_JAR} \
  -fsroot ${JENKINS_WORKSPACE} \
  ${JENKINS_MASTER:+-master ${JENKINS_MASTER}} \
  ${JENKINS_USERNAME:+-username ${JENKINS_USERNAME}} \
  ${JENKINS_PASSWORD:+-password ${JENKINS_PASSWORD}} \
  ${JENKINS_NAME:+-name ${JENKINS_NAME}} \
  ${JENKINS_EXECUTORS:+-executors ${JENKINS_EXECUTORS}} \
  ${JENKINS_LABELS:+-labels '${JENKINS_LABELS}'}
EOF
chmod 755 ${JENKINS_WORKSPACE}/swarm-client

set -x
exec start-stop-daemon --start \
  --exec /usr/bin/supervisord -- -n
