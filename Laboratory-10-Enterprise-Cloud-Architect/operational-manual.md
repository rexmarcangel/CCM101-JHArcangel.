##  Purpose

This manual explains the setup and maintenance of our private cloud storage project. Our group used Ubuntu Server, Docker Compose, Nextcloud, and MariaDB to build a system where users can access files through a web browser.

We also configured a firewall and prepared an automated database backup script. This document records the main components, security measures, and maintenance procedures for our project.

##  System Architecture

Our environment uses the following components:

- **Host machine:** A Windows computer used to run and manage the virtual machine.
- **Hypervisor:** Oracle VirtualBox, which runs the Ubuntu Server virtual machine.
- **Guest operating system:** Ubuntu Server, where Docker and UFW are installed.
- **Nextcloud container:** Provides the private cloud storage web interface.
- **MariaDB container:** Stores Nextcloud's database information.
- **Docker volumes:** Preserve application and database data beyond a container restart or recreation.
- **Docker bridge network:** Allows the application and database containers to communicate privately.
- **UFW firewall:** Controls incoming connections to the Ubuntu virtual machine.

The host browser connects to Nextcloud through the configured web port. The Nextcloud container communicates with MariaDB over the internal Docker network instead of exposing the database port directly to the host.

Refer to `architecture-diagram.png` for the architecture and network topology.

##  Requirements

Before deployment, we prepare:

- Ubuntu Server with sufficient memory and disk space.
- Docker Engine and the Docker Compose plugin.
- UFW and cron.
- The project files, including `docker-compose.yml` and `automation-script.sh`.
- A private `.env` file containing the required credentials.
- Network access to download the required container images.

## Configuration and Credentials

The `.env` file supplies the configuration used by Docker Compose. It must contain these variables:

- `MYSQL_ROOT_PASSWORD`
- `MYSQL_DATABASE`
- `MYSQL_USER`
- `MYSQL_PASSWORD`
- `NEXTCLOUD_ADMIN_USER`
- `NEXTCLOUD_ADMIN_PASSWORD`
- `NEXTCLOUD_TRUSTED_DOMAINS`

Use strong, unique passwords. Do not commit `.env` to GitHub or include passwords in screenshots, logs, or public documentation.

The `NEXTCLOUD_TRUSTED_DOMAINS` value must contain the hostname or IP address used to access Nextcloud. Configure it according to the actual VM network and access method.

##  Deployment and Operation

### Start the services

From the directory containing `docker-compose.yml` and `.env`, run command:

```bash
docker compose config
docker compose up -d
```

The first command checks whether the Compose configuration can be parsed. Review the output carefully and do not publish output containing sensitive values.

### Check the running containers

```bash
docker compose ps
```

### Review application logs

```bash
docker compose logs --tail=100 app
```

### Review database logs

```bash
docker compose logs --tail=100 db
```

### Access Nextcloud

Open a browser and visit:

```text
http://VM_IP_ADDRESS:8080
```


For real deployments, use HTTPS and an appropriate TLS configuration rather than sending credentials over plain HTTP.

##  Data Persistence

Our Compose configuration uses two named Docker volumes:

- `db_data` stores MariaDB database files.
- `nextcloud_data` stores Nextcloud application data.

Inspect the volumes with:

```bash
docker volume ls
```

Container recreation does not normally remove named volumes. However, deleting volumes can permanently remove data. Avoid running `docker compose down -v` unless you intentionally want to remove the volumes and understand the consequences.

Persistent volumes are not a replacement for backups.

##  Firewall and Network Security

Our Ubuntu server uses UFW to control incoming connections. The intended policy is to deny incoming traffic by default and allow outgoing traffic.

Check the current firewall status:

```bash
sudo ufw status verbose
```

For our lab environment, the allowed ports are:

- **22/tcp:** SSH administration, if SSH is required.
- **8080/tcp:** Nextcloud web access over HTTP.

Only enable ports that are actually needed. Restrict SSH and web access to trusted networks when possible. Before enabling UFW over a remote SSH session, ensure that the required SSH access is allowed to avoid losing administrative access.

The MariaDB service should remain on the internal Docker network without a public host port mapping.

Port 8080 provides HTTP, not HTTPS. A production deployment should use HTTPS, strong credentials, regular security updates, restricted administrative access, and a documented recovery plan.

##  Automated Database Backup

Our `automation-script.sh` creates a compressed MariaDB database dump, checks the resulting archive, records the result in a log, and removes old backup archives based on the configured retention period.

Run it manually from the project directory:

```bash
chmod +x automation-script.sh
./automation-script.sh
```

The script requires the `.env` file and a running database service. It stores backups in the `backups` directory by default.

Review the backup log:

```bash
cat backups/backup.log
```

List the backup files:

```bash
ls -lh backups/
```

Test a backup archive:

```bash
gzip -t backups/nextcloud_db_BACKUP_FILENAME.sql.gz
```

Replace `BACKUP_FILENAME` with the actual timestamped filename.

### Schedule daily backups with cron

Edit the current user's crontab:

```bash
crontab -e
```

Add a schedule using the actual absolute path to the script:

```cron
0 2 * * * /bin/bash /absolute/path/to/automation-script.sh
```

This schedules the script for 2:00 AM according to the VM's local time. Save the crontab and verify it with:

```bash
crontab -l
```

Ensure the cron service is running. The VM must be powered on and the database service must be running at the scheduled time. Backups should be copied to separate, secure storage and periodically tested by restoring them in a safe test environment.

**Backup limitation:** The supplied script backs up the MariaDB database only. A complete recovery plan must also protect Nextcloud's uploaded files and configuration. Database backups alone cannot restore all user files.

##  Routine Maintenance

Our group recommends the following maintenance tasks:

- Check container status and logs regularly.
- Check available disk space and backup sizes.
- Review UFW rules and remove unnecessary access.
- Apply updates during planned maintenance windows.
- Monitor backup logs for failures.
- Keep copies of backups away from the VM.
- Test the restoration process before relying on backups.
- Keep credentials private and rotate them if they are exposed.
- Record configuration changes so the deployment can be reproduced.

### Database connection fails

1. Check whether the database container is healthy.
2. Review the database logs.
3. Confirm that the database environment variables match between services.
4. Check the Docker network configuration.
5. Do not delete the database volume as a troubleshooting shortcut.

### Backup fails

1. Check that the database container is running.
2. Confirm that the required variables are set in `.env`.
3. Review `backups/backup.log`.
4. Check free disk space and the permissions of the backup directory.
5. Run the script manually and verify the resulting archive.

## . Responsible Operation

Our group understands that running a service is only one part of managing a cloud environment. Security, monitoring, backups, recovery testing, and clear documentation are also necessary.

This project is a laboratory proof of concept. Before using it for real university data, additional work would be needed, including HTTPS, tighter network restrictions, off-server backups, restore testing, monitoring, and a formal update and access-control process.
