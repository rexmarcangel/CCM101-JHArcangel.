### 1. How does the boot time and setup process of a Docker container compare to installing an operating system on a Virtual Machine?

A Docker container is much faster to set up compared to a Virtual Machine. In a VM, we need to install and boot a complete operating system before we can run an application. With Docker, we can simply pull an image and run the container using a few commands. Because of this, containers can start in seconds and use fewer resources.

### 2. Why is port mapping (-p 8080:80) necessary when running a web server inside a container?

Port mapping is needed so that we can access the web server running inside the container from the host computer. In `-p 8080:80`, port 8080 is the port on the host, while port 80 is the port used by Nginx inside the container. This allows us to access Nginx by using `http://localhost:8080`.

### 3. What happens to the data inside a container when you use the docker rm command?

When we use `docker rm`, the container is removed completely. Any data that was only stored inside the container can also be lost. If we need to keep important data, we should use a Docker volume or another external storage.

### 4. How do you think containerization changes the way software developers and IT operations teams work together (DevOps)?

Containerization makes it easier for developers and IT teams to work together because the application and its needed files can be packaged in one container. Developers can test the same container that the IT team will deploy. This can reduce problems caused by different environments and make the deployment process faster and easier.

### 5. How is your GitHub portfolio evolving?

My GitHub portfolio is becoming more organized as I add more laboratory activities and documentation. I am now including my research, Docker commands, screenshots, and reflections instead of only submitting the final answers. Each laboratory shows the different things I have learned from cloud computing. It also helps me keep track of my progress and build a portfolio that I can use to show my skills in the future.

