# Laboratory 10: Enterprise Cloud Architect

## Project Overview

For our final laboratory, our group designed and deployed a private cloud storage system using Nextcloud and MariaDB. The goal of our project is to understand how different parts of a cloud environment work together, from the virtual machine and network configuration to the application and database containers.

We used Ubuntu Server as our operating system and Docker Compose to manage the services. We also configured a firewall and created an automated database backup script to improve the security and maintenance of our deployment.

## Project Objectives

- Deploy Nextcloud as a private cloud storage application.
- Connect Nextcloud to a MariaDB database using Docker Compose.
- Use persistent volumes to retain application and database data.
- Configure a firewall to control incoming network connections.
- Automate database backups using a Bash script and cron.
- Document the architecture, deployment, security settings, and maintenance procedures.

## Technology Stack

- **Operating System:** Ubuntu Server
- **Virtualization:** Oracle VirtualBox
- **Container Platform:** Docker
- **Container Management:** Docker Compose
- **Cloud Storage Application:** Nextcloud
- **Database:** MariaDB
- **Firewall:** UFW
- **Automation:** Bash and cron
- **Repository:** GitHub

## Project Files

| File | Description |
|---|---|
| `README.md` | Project overview, objectives, and technology stack |
| `architecture-diagram.png` | Architecture and network topology diagram |
| `docker-compose.yml` | Configuration for the Nextcloud and MariaDB containers |
| `automation-script.sh` | Script for automated database backups |
| `operational-manual.md` | Deployment, security, maintenance, and troubleshooting documentation |
| `final-reflection.md` | Our group's reflection on the cloud computing activities |

## Security and Data Persistence

Our deployment uses environment variables for sensitive configuration and persistent Docker volumes for application and database data. We configured UFW to deny incoming connections by default and allow the ports required for SSH and web access.

The database backup script creates compressed backup files, records its results in a log, and removes older backups according to the configured retention period. The `.env` file contains sensitive credentials and must not be uploaded to this public repository.

## Learning Outcome

Through this activity, our group gained practical experience in container deployment, database connectivity, network security, persistent storage, and automated backup operations. This project also helped us understand the importance of documenting and maintaining a cloud environment, not just getting the application to run.
