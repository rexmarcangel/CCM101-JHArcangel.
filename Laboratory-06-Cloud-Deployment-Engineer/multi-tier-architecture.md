# Two-Tier Architecture

A Two-Tier Architecture is a system that separates the application into two main parts: the web/application tier and the database tier. In this activity, the Nextcloud application works as the web tier while MariaDB works as the database tier.

## The Web/Application Tier

The web/application tier is responsible for handling the user's requests and displaying the Nextcloud interface. In this activity, the Nextcloud container receives HTTP requests through port 8080 and provides the cloud storage interface that users can access through a web browser.

## The Database Tier

The database tier is responsible for storing important information needed by the application. MariaDB stores data such as user accounts, configuration information, and other Nextcloud metadata.

## Why Separate Them?

Separating the web application and database into different containers makes the system easier to manage and maintain. Each container has its own job, so the database can be managed separately from the application, and the system can also be expanded or updated more easily in the future.

