FROM java:openjdk-7u101-jdk
MAINTAINER kitfung <kitfung@oursky.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install curl net-tools

RUN curl -o swarm.jar "http://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/2.0/swarm-client-2.0-jar-with-dependencies.jar"

ENTRYPOINT java -jar swarm.jar -executors 1 -master http://$JENKINS_SERVICE_HOST:$JENKINS_SERVICE_PORT_HTTP -username $JENKINS_USER_NAME -password $JENKINS_PASSWORD -labels ubuntu