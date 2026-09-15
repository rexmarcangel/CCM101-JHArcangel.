## Container Lifecycle Commands

### 1. List Running Containers
```bash
docker ps
```
This command lists all currently running Docker containers and displays information such as the container ID, image, status, and ports.

### 2. Stop the Running Container

```bash
docker stop nginx-server
```

This command stops the running Nginx container named `nginx-server`.

### 3. Verify the Container is Stopped

```bash
docker ps
```
This command verifies that the Nginx container is no longer running.

To view both running and stopped containers, the following command can also be used:
```bash
docker ps -a
```
### 4. Remove the Container Completely

```bash
docker rm nginx-server
```
This command permanently removes the stopped `nginx-server` container from the Docker environment.

## Lifecycle conclusion

The Docker container lifecycle starts by running a container, checking its status, stopping it when it is no longer needed, and finally removing it completely.

