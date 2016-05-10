docker run -d -p 8080:8080 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(which docker):/usr/bin/docker \
  -v $(which docker-compose):/usr/bin/docker-compose \
  kitfung/jenkins_in_docker