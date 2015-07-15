DOCKERSL_APP_NAME='mydockersl-app'
DOCKERSL_DATA_NAME='mydockersl-data'

all: build

build:
	@docker build --tag=mizunashi/jenkins-docker-slave .

quickstart:
	@echo "Starting jenkins slave container..."
	@docker run --name=${DOCKERSL_APP_NAME} -d \
		--privileged -e DOCKER_DAEMON_ARGS="-D" \
		--publish=30022:22 \
		mizunashi/jenkins-docker-slave
	@docker run --name=${DOCKERSL_DATA_NAME} -d \
		--volumes-from=${DOCKERSL_APP_NAME} \
		busybox
	@echo "Type 'make logs' for the logs"

stop:
	@echo "Stopping jenkins slave app..."
	@docker stop ${DOCKERSL_APP_NAME} >/dev/null
	@echo "Stopping jenkins slave data..."
	@docker stop ${DOCKERSL_DATA_NAME} >/dev/null

purge: stop
	@echo "Removing stopped containers..."
	@docker rm -v ${DOCKERSL_APP_NAME} >/dev/null
	@docker rm -v ${DOCKERSL_DATA_NAME} >/dev/null

logs:
	@docker logs -f ${DOCKERSL_APP_NAME}

