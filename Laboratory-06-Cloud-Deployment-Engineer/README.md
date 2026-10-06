## Mission Overview

In this laboratory activity, I learned how to deploy a private cloud storage system using Nextcloud and Docker Compose. The setup used two containers: one for the Nextcloud application and another for the MariaDB database.

The main goal was to understand how multiple containers can work together as one application.

## Objectives

* Understand the concept of Two-Tier Architecture.
* Deploy MariaDB and Nextcloud using Docker Compose.
* Create a `docker-compose.yml` configuration file.
* Connect the Nextcloud application to a MariaDB database.
* Use environment variables for database configuration.
* Start and stop multiple containers using Docker Compose.
* Document the deployment process with screenshots.

## Commands Executed

```bash
docker --version

docker-compose --version

mkdir nextcloud-deployment

cd nextcloud-deployment

nano docker-compose.yml

docker-compose up -d

docker-compose ps

docker-compose down
```

## Skills Learned

Through this activity, I learned how Docker Compose can be used to manage multiple containers at the same time. I also learned how a web application can communicate with a separate database container using a service name.

Another important lesson was how YAML configuration files can describe an entire application setup. This makes deployment more organized because the same configuration can be used again instead of manually creating every container.

I also gained more experience with Nextcloud, MariaDB, Docker networking, environment variables, and multi-tier cloud architecture.

