Jenkins in Docker
===

This project is about how to setup jenkins master and slave in a docker and kubernetes environment.

Build Step
---

 1. Build the image of jenkins-master in ./master folder

 	`docker build -t="{{IMAGE_NAME}}" ./master`

 2. Build the image of jenkins-master in ./slave folder
 
 	`docker build -t="{{IMAGE_NAME}}" ./slave`
 	
 3. Push those images to docker hub
 
 
Run in Docker
---
 \*\*\* slave is not available here since it is used for distributed builds in different machines \*\*\*
 
Requirement:

- [docker](https://docs.docker.com/engine/installation/)
- [docker-compose](https://docs.docker.com/compose/install/)


#####Start Jenkins server

```bash
docker run -d -p 8080:8080 \
 	-v /var/run/docker.sock:/var/run/docker.sock \
	-v $(which docker):/usr/bin/docker \
 	-v $(which docker-compose):/usr/bin/docker-compose \
	{{JENKINS_MASTER_IMAGE_NAME}}
```

Remind: All the docker/docker-compose operation in Jenkins require `sudo`

#####Test whether setup properly

Open a new jobs in Jenkins and execute `sudo docker run hello-world` and check the console output.


Integration to Kubernetes
---

1\. Move the `jenkins-master.yaml` and `jenkins-slave.yaml` to the host machine.

2\. Create a folder to store the Jenkins master data

```Bash
mkdir -p /var/jenkins
chmod -R 777 /var/jenkins
```

3\. Edit `jenkins-master.yaml` and `jenkins-slave.yaml` to use the correct image if you have built a new image. **Moreover**, make sure the path of docker and docker-compose in `volumes` is correct.

4\. Start the Jenkins master server - `kubectl create -f jenkins-master.yaml`

5\. Access Jenkins through its address, you can get it through `kubectl describe svc jenkins`

6\. Configurate jenkins according to the instruction

7\. Edit the env in `jenkins-slave.yaml`. Change the value of variable according to your setting in previous step.

8\. Start the Jenkins slave - `kubectl create -f jenkins-slave.yaml`

9\. You can scale the number of slave later - `kubectl scale rc jenkins-controller --replicas={{new number}}`

###Why don't use environment variable in yaml
> Giving users the power to customize the env to the app is better than customizing the app to the env
- [One of the kubernetes members](https://github.com/kubernetes/kubernetes/issues/1382#issuecomment-56200142)