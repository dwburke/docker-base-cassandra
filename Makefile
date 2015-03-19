

PWD = $(shell pwd)

CASSANDRA_IMAGE          ?= dwburke/base-cassandra
CASSANDRA_VERSION        ?= latest

all: default

default:
	${MAKE} pull
	${MAKE} build

pull:
	@if [ ! -e out/cassandra-pull.x ]; then \
		docker pull devdb/cassandra; \
		touch out/cassandra-pull.x; \
	fi

delete:
	docker rmi ${CASSANDRA_IMAGE}:${CASSANDRA_VERSION}

out/cassandra-build.x: Dockerfile
	docker build --tag="${CASSANDRA_IMAGE}" .
	touch out/cassandra-build.x

build: out/cassandra-build.x

clean:
	@rm -f out/cassandra-*.x; \


