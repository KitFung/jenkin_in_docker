FROM jenkins:2.0

MAINTAINER KitFung <kitfung@oursky.com>

USER root
RUN apt-get update \
      && apt-get install -y sudo libsystemd-journal0 libapparmor-dev \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
RUN groupadd docker \
    && gpasswd -a jenkins docker

USER jenkins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt