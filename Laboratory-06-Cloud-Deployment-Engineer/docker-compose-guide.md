## The `services:` Block

The `services:` block defines the containers that will be used in the application. In this project, there are two services: `database` and `app`.

The `database` service uses the MariaDB 10.6 image, while the `app` service uses the Nextcloud image. Docker Compose creates and manages both containers using the instructions inside the YAML file.

## How Does Nextcloud Find the Database?

The Nextcloud container knows where the MariaDB database is located because of the `MYSQL_HOST` environment variable.

The Compose file contains:

```yaml
- MYSQL_HOST=database
```

The value `database` matches the name of the database service:

```yaml
database:
```

Because both services are managed by Docker Compose, they can communicate with each other using the service name. This means Nextcloud can connect to MariaDB using `database` as the host instead of needing to use an IP address.

## `docker run` vs `docker-compose up -d`

The `docker run` command is normally used to create and start an individual container. If an application needs multiple containers, the commands can become longer because each container and its settings have to be configured separately.

`docker-compose up -d` uses the instructions written in the `docker-compose.yml` file to create and start multiple related containers at once. The `-d` option runs the containers in the background, allowing the terminal to be used for other commands.

## Compose File Used

The project used the following Docker Compose configuration:

```yaml
version: '3'

services:
  database:
    image: mariadb:10.6
    environment:
      - MYSQL_ROOT_PASSWORD=cloudnova_root
      - MYSQL_PASSWORD=cloudnova_pass
      - MYSQL_DATABASE=nextcloud_db
      - MYSQL_USER=nextcloud_user

  app:
    image: nextcloud
    ports:
      - 8080:80
    environment:
      - MYSQL_PASSWORD=cloudnova_pass
      - MYSQL_DATABASE=nextcloud_db
      - MYSQL_USER=nextcloud_user
      - MYSQL_HOST=database
```

