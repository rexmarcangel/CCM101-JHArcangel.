## Mission Overview

This mission introduces Docker and containerization as essential technologies for building cloud-native applications. This activity compares Virtual Machines and containers, then shows how Docker can be used to deploy and manage an Nginx web server.

## Objectives

* Understand the differences between Virtual Machines and containers.
* Learn the basic Docker commands.
* Verify that Docker is installed and running.
* Pull and run an Nginx Docker image.
* Use port mapping to access a web server inside a container.
* Practice the Docker container lifecycle.
* Document the deployment process and lessons learned.

## This is the list of command I used in docker

## Checkpoint 3 - Docker Environment

```bash
docker --version
docker info
```

## Checkpoint 4 - Deploy Nginx

```bash
docker pull nginx
docker run -d -p 8080:80 --name nginx-server nginx
curl http://localhost:8080
```

## Checkpoint 5 - Container Lifecycle


```bash
docker ps
docker stop nginx-server
docker ps
docker ps -a
docker rm nginx-server
```

## Skills Learned

* Understanding containerization and Docker.
* Comparing Virtual Machines and containers.
* Pulling images from Docker Hub.
* Running containers in detached mode.
* Mapping host and container ports.
* Testing a containerized web server.
* Managing the Docker container lifecycle.
* Organizing project files and screenshots in GitHub.

## Challenges Encountered

One challenge was understanding the difference between a Virtual Machine and a container. Another challenge was learning how port mapping works when accessing a web server inside a container. I also needed to understand the difference between stopping a container and removing a container. Through the activity, I became more familiar with basic Docker commands and container management.


