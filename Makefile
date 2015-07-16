DOCKERSL_APP_NAME='mydockersl-app'
DOCKERSL_DATA_NAME='mydockersl-data'
SSH_KEYS_PATH="${PWD}/ssh-keys"

all: build

build:
	@docker build --tag=${USER}/jenkins-docker-slave .

quickstart:
	@echo "Create SSH keys..."
	@mkdir -p ${SSH_KEYS_PATH}
	@[ -f ${SSH_KEYS_PATH}/id_rsa ] \
		|| ssh-keygen -t rsa -f ${SSH_KEYS_PATH}/id_rsa -C '' -N ''
	@echo "Starting jenkins docker slave container..."
	@docker run --name=${DOCKERSL_APP_NAME} -d \
		--privileged --env='DOCKER_DAEMON_ARGS=-D' \
		--env="AUTHORIZED_KEY_STRING=`head -1 ${SSH_KEYS_PATH}/id_rsa.pub`" \
		mizunashi/jenkins-docker-slave
	@docker run --name=${DOCKERSL_DATA_NAME} -d \
		--volumes-from=${DOCKERSL_APP_NAME} \
		busybox
	@echo "Type 'make logs' for the logs"
	@echo "Type 'make test' for the login test of SSH"

stop:
	@echo "Stopping jenkins docker slave app..."
	@docker stop ${DOCKERSL_APP_NAME} >/dev/null
	@echo "Stopping jenkins docker slave data..."
	@docker stop ${DOCKERSL_DATA_NAME} >/dev/null

purge: stop
	@echo "Removing stopped containers..."
	@docker rm -v ${DOCKERSL_APP_NAME} >/dev/null
	@docker rm -v ${DOCKERSL_DATA_NAME} >/dev/null

logs:
	@docker logs -f ${DOCKERSL_APP_NAME}

test:
	@ssh jenkins@`docker inspect -f '{{.NetworkSettings.IPAddress}}' ${DOCKERSL_APP_NAME}` \
		-i ${SSH_KEYS_PATH}/id_rsa \
		&& ssh-keygen -R `docker inspect -f '{{.NetworkSettings.IPAddress}}' ${DOCKERSL_APP_NAME}`
